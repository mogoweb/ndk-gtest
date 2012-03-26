LOCAL_PATH:= $(call my-dir)

# base_static
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
		third_party/dmg_fp/g_fmt.cc \
		third_party/dmg_fp/dtoa_wrapper.cc \
		third_party/dynamic_annotations/dynamic_annotations.c \
		third_party/nspr/prtime.cc \
		third_party/icu/icu_utf.cc \
		android/jni_android.cc \
		android/jni_string.cc \
		android/scoped_java_ref.cc \
		at_exit.cc \
		base_paths.cc \
		base_switches.cc \
		callback_internal.cc \
		command_line.cc \
		debug/alias.cc \
		debug/debugger.cc \
		debug/debugger_posix.cc \
		debug/trace_event.cc \
		debug/trace_event_impl.cc \
		file_descriptor_shuffle.cc \
		file_path.cc \
		file_util.cc \
		file_util_android.cc \
		file_util_posix.cc \
		lazy_instance.cc \
		location.cc \
		logging.cc \
		memory/ref_counted.cc \
		memory/ref_counted_memory.cc \
		memory/singleton.cc \
		memory/weak_ptr.cc \
		message_loop.cc \
		message_loop_proxy.cc \
		message_loop_proxy_impl.cc \
		message_pump.cc \
		message_pump_default.cc \
		metrics/histogram.cc \
		os_compat_android.cc \
		path_service.cc \
		pending_task.cc \
		pickle.cc \
		platform_file.cc \
		platform_file_posix.cc \
		process_posix.cc \
		process_util.cc \
		process_util_linux.cc \
		process_util_posix.cc \
		profiler/alternate_timer.cc \
		profiler/tracked_time.cc \
		safe_strerror_posix.cc \
		string_number_conversions.cc \
		string_piece.cc \
		string_split.cc \
		string_util.cc \
		string16.cc \
		stringprintf.cc \
		synchronization/condition_variable_posix.cc \
		synchronization/lock_impl_posix.cc \
		synchronization/waitable_event_posix.cc \
		sys_info_posix.cc \
		sys_string_conversions_posix.cc \
		task_runner.cc \
		threading/platform_thread_posix.cc \
		threading/post_task_and_reply_impl.cc \
		threading/thread_local_posix.cc \
		threading/thread_local_storage_posix.cc \
		time.cc \
		time_posix.cc \
		tracked_objects.cc \
		tracking_info.cc \
		utf_string_conversion_utils.cc \
		utf_string_conversions.cc \
		values.cc \
        vlog.cc
        
LOCAL_C_INCLUDES := \
        $(LOCAL_PATH)/.. \
        $(LOCAL_PATH)/../..
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)
LOCAL_MODULE := libbase_static
LOCAL_STATIC_LIBRARIES := libgtest libevent
# Just a few definitions not provided by bionic.
LOCAL_CFLAGS += -include "android/prefix.h"
include $(BUILD_STATIC_LIBRARY)

# test_support_base
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
		test/test_stub_android.cc \
        test/test_suite.cc \
        test/test_switches.cc \
        test/test_timeouts.cc
LOCAL_C_INCLUDES := \
		$(LOCAL_PATH)/../..
LOCAL_CFLAGS := 
LOCAL_MODULE := libtest_support_base
LOCAL_STATIC_LIBRARIES := libgtest libgtest_support libgmock libbase_static
include $(BUILD_STATIC_LIBRARY)

# base_unittests
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
        test/run_all_unittests.cc
LOCAL_MODULE := libbase_unittests
LOCAL_STATIC_LIBRARIES := libtest_support_base
LOCAL_LDLIBS := -llog
include $(BUILD_EXECUTABLE)

#include $(LOCAL_PATH)/third_party/libevent/Android.mk
