LOCAL_PATH := $(call my-dir)
MY_LOCAL_PATH := $(LOCAL_PATH)

# libgtest_support
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
	multiprocess_func_list.cc \
	
LOCAL_MODULE:= libgtest_support
include $(BUILD_STATIC_LIBRARY)

include $(call all-makefiles-under, $(MY_LOCAL_PATH))

