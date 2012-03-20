LOCAL_PATH:= $(call my-dir)

# libgtest
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
        gtest/src/gtest-death-test.cc \
        gtest/src/gtest-filepath.cc \
        gtest/src/gtest-port.cc \
        gtest/src/gtest-printers.cc \
        gtest/src/gtest-test-part.cc \
        gtest/src/gtest-typed-test.cc \
        gtest/src/gtest.cc
LOCAL_EXPORT_C_INCLUDES := \
        $(LOCAL_PATH)/gtest \
        $(LOCAL_PATH)/gtest/include
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
        gtest/src/gtest_main.cc
LOCAL_MODULE:= libgtest_main
LOCAL_STATIC_LIBRARIES := libgtest
include $(BUILD_STATIC_LIBRARY)

# libgmock
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
        gmock/src/gmock-cardinalities.cc \
        gmock/src/gmock-internal-utils.cc \
        gmock/src/gmock-matchers.cc \
        gmock/src/gmock-spec-builders.cc \
        gmock/src/gmock.cc 
LOCAL_C_INCLUDES := \
        $(LOCAL_PATH)/gmock \
        $(LOCAL_PATH)/gmock/include
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)
LOCAL_MODULE:= libgmock
LOCAL_STATIC_LIBRARIES := libgtest
include $(BUILD_STATIC_LIBRARY)

# libgmock_main
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
        gmock/src/gmock_main.cc
LOCAL_MODULE:= libgmock_main
LOCAL_STATIC_LIBRARIES := libgmock
include $(BUILD_STATIC_LIBRARY)

