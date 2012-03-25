LOCAL_PATH:= $(call my-dir)

# libgmock
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
        src/gmock-cardinalities.cc \
        src/gmock-internal-utils.cc \
        src/gmock-matchers.cc \
        src/gmock-spec-builders.cc \
        src/gmock.cc 
LOCAL_C_INCLUDES := \
        $(LOCAL_PATH) \
        $(LOCAL_PATH)/include
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)
LOCAL_MODULE:= libgmock
LOCAL_STATIC_LIBRARIES := libgtest
include $(BUILD_STATIC_LIBRARY)

# libgmock_main
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
        src/gmock_main.cc
LOCAL_MODULE:= libgmock_main
LOCAL_STATIC_LIBRARIES := libgmock
include $(BUILD_STATIC_LIBRARY)

