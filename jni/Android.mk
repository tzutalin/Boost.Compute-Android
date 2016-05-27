LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := test_sort

LOCAL_SRC_FILES := ../CL-Stub/libopencl.c \
                ../third-party/miniglog/glog/logging.cc \
                test_sort.cpp

LOCAL_C_INCLUDES := \
                CL-12/ \
                CL-Stub/ \
                third-party/miniglog/ \
                compute/include

LOCAL_CFLAGS   += -fPIC -O2
LOCAL_LDLIBS := -lm -llog -ldl -lz
LOCAL_CPPFLAGS += -fexceptions -frtti -std=c++11

LOCAL_ARM_MODE := arm
ifeq ($(TARGET_ARCH_ABI), armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_CFLAGS += -pie -fPIE
LOCAL_LDFLAGS += -pie -fPIE
include $(BUILD_EXECUTABLE)

#include $(BUILD_SHARED_LIBRARY)
