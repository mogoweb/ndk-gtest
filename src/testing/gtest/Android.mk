LOCAL_PATH:= $(call my-dir)

# libgtest
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
        src/gtest-death-test.cc \
        src/gtest-filepath.cc \
        src/gtest-port.cc \
        src/gtest-printers.cc \
        src/gtest-test-part.cc \
        src/gtest-typed-test.cc \
        src/gtest.cc
LOCAL_EXPORT_C_INCLUDES := \
        $(LOCAL_PATH) \
        $(LOCAL_PATH)/include
LOCAL_EXPORT_CFLAGS := \
        -DGTEST_HAS_RTTI=0 \
        -DGTEST_USE_OWN_TR1_TUPLE=1
LOCAL_C_INCLUDES := $(LOCAL_EXPORT_C_INCLUDES)
LOCAL_CFLAGS := $(LOCAL_EXPORT_CFLAGS)
LOCAL_MODULE:= libgtest
include $(BUILD_STATIC_LIBRARY)

# libgtestmain
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
        src/gtest_main.cc
LOCAL_MODULE:= libgtest_main
LOCAL_STATIC_LIBRARIES := libgtest
include $(BUILD_STATIC_LIBRARY)

