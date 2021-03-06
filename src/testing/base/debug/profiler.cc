// Copyright (c) 2012 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/debug/profiler.h"

#include <string>

#include "base/process_util.h"
#include "base/string_util.h"
#include "base/stringprintf.h"

#if defined(OS_WIN)
#include "base/win/pe_image.h"
#endif  // defined(OS_WIN)

#if defined(ENABLE_PROFILING) && !defined(NO_TCMALLOC)
#include "third_party/tcmalloc/chromium/src/google/profiler.h"
#endif

namespace base {
namespace debug {

#if defined(ENABLE_PROFILING) && !defined(NO_TCMALLOC)

static int profile_count = 0;

void StartProfiling(const std::string& name) {
  ++profile_count;
  std::string full_name(name);
  std::string pid = StringPrintf("%d", GetCurrentProcId());
  std::string count = StringPrintf("%d", profile_count);
  ReplaceSubstringsAfterOffset(&full_name, 0, "{pid}", pid);
  ReplaceSubstringsAfterOffset(&full_name, 0, "{count}", count);
  ProfilerStart(full_name.c_str());
}

void StopProfiling() {
  ProfilerFlush();
  ProfilerStop();
}

void FlushProfiling() {
  ProfilerFlush();
}

bool BeingProfiled() {
  return ProfilingIsEnabledForAllThreads();
}

void RestartProfilingAfterFork() {
  ProfilerRegisterThread();
}

#else

void StartProfiling(const std::string& name) {
}

void StopProfiling() {
}

void FlushProfiling() {
}

bool BeingProfiled() {
  return false;
}

void RestartProfilingAfterFork() {
}

#endif

#if !defined(OS_WIN)

bool IsBinaryInstrumented() {
  return false;
}

ReturnAddressLocationResolver GetProfilerReturnAddrResolutionFunc() {
  return NULL;
}

#else  // defined(OS_WIN)

// http://blogs.msdn.com/oldnewthing/archive/2004/10/25/247180.aspx
extern "C" IMAGE_DOS_HEADER __ImageBase;

bool IsBinaryInstrumented() {
  HMODULE this_module = reinterpret_cast<HMODULE>(&__ImageBase);
  base::win::PEImage image(this_module);

  // This should be self-evident, soon as we're executing.
  DCHECK(image.VerifyMagic());

  // Syzygy-instrumented binaries contain a PE image section named ".thunks",
  // and all Syzygy-modified binaries contain the ".syzygy" image section.
  // This is a very fast check, as it only looks at the image header.
  return (image.GetImageSectionHeaderByName(".thunks") != NULL) &&
      (image.GetImageSectionHeaderByName(".syzygy") != NULL);
}

// Callback function to PEImage::EnumImportChunks.
static bool FindResolutionFunctionInImports(
    const base::win::PEImage &image, const char* module_name,
    PIMAGE_THUNK_DATA unused_name_table, PIMAGE_THUNK_DATA import_address_table,
    PVOID cookie) {
  // Our import address table contains pointers to the functions we import
  // at this point. Let's retrieve the first such function and use it to
  // find the module this import was resolved to by the loader.
  const wchar_t* function_in_module =
      reinterpret_cast<const wchar_t*>(import_address_table->u1.Function);

  // Retrieve the module by a function in the module.
  const DWORD kFlags = GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS |
                       GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT;
  HMODULE module = NULL;
  if (!::GetModuleHandleEx(kFlags, function_in_module, &module)) {
    // This can happen if someone IAT patches us to a thunk.
    return true;
  }

  // See whether this module exports the function we're looking for.
  ReturnAddressLocationResolver exported_func =
      reinterpret_cast<ReturnAddressLocationResolver>(
          ::GetProcAddress(module, "ResolveReturnAddressLocation"));

  if (exported_func != NULL) {
    ReturnAddressLocationResolver* resolver_func =
        reinterpret_cast<ReturnAddressLocationResolver*>(cookie);
    DCHECK(resolver_func != NULL);
    DCHECK(*resolver_func == NULL);

    // We found it, return the function and terminate the enumeration.
    *resolver_func = exported_func;
    return false;
  }

  // Keep going.
  return true;
}

ReturnAddressLocationResolver GetProfilerReturnAddrResolutionFunc() {
  if (!IsBinaryInstrumented())
    return NULL;

  HMODULE this_module = reinterpret_cast<HMODULE>(&__ImageBase);
  base::win::PEImage image(this_module);

  ReturnAddressLocationResolver resolver_func = NULL;
  image.EnumImportChunks(FindResolutionFunctionInImports, &resolver_func);

  return resolver_func;
}

#endif  // defined(OS_WIN)

}  // namespace debug
}  // namespace base
