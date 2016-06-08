LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := test_sort

LOCAL_SRC_FILES := ../CL-Stub/libopencl.c \
                test_sort.cpp

LOCAL_C_INCLUDES := \
                CL-12/ \
                CL-Stub/ \
                third-party/miniglog/ \
                third-party/Boost-for-Android/boost_1_55_0 \
                compute/include

#MINIGLOG_LIB_TYPE:=SHARED
MINIGLOG_LIB_TYPE:=STATIC
ifeq ($(MINIGLOG_LIB_TYPE),SHARED)
	LOCAL_SHARED_LIBRARIES := miniglog
else
	LOCAL_STATIC_LIBRARIES := miniglog
endif

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

include third-party/miniglog/MINIGLOG.mk
