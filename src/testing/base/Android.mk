LOCAL_PATH:= $(call my-dir)

# base_static
include $(CLEAR_VARS)
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
		at_exit.cc \
		base_paths.cc \
		base_switches.cc \
		callback_internal.cc \
		command_line.cc \
		debug/debugger.cc \
		debug/debugger_posix.cc \
		file_path.cc \
		file_util_posix.cc \
		lazy_instance.cc \
		logging.cc \
		memory/ref_counted.cc \
		memory/singleton.cc \
		message_loop.cc \
		message_pump.cc \
		path_service.cc \
		process_util_linux.cc \
		process_util_posix.cc \
		string_number_conversions.cc \
		string_piece.cc \
		string_split.cc \
		string_util.cc \
		synchronization/condition_variable_posix.cc \
		synchronization/lock_impl_posix.cc \
		synchronization/waitable_event_posix.cc \
		time.cc \
		time_posix.cc \
		threading/platform_thread_posix.cc \
        vlog.cc
        
LOCAL_C_INCLUDES := \
        $(LOCAL_PATH)/.. 
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)
LOCAL_MODULE := libbase_static
LOCAL_STATIC_LIBRARIES := libgtest
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
