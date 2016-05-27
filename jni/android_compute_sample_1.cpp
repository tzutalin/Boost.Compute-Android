#include <iostream>
#include <string>
#include <android/log.h>
#include <boost/compute/core.hpp>

#include <com_ivizon_androidcomputesample_NativeComputeLoad.h>
#include "libopencl.h"


namespace compute = boost::compute;
using namespace std;

// Commonly-defined shortcuts for LogCat output from native C applications.
#define  LOG_TAG    "AndroidComputeSample_1"
#define  LOGD(...)  __android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, __VA_ARGS__)
#define  LOGE(...)  __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

compute::device device;

JNIEXPORT void JNICALL Java_com_ivizon_androidcomputesample_NativeComputeLoad_initBoostCompute
  (JNIEnv *, jclass)
{
	 device = compute::system::default_device();
	 LOGE(">>>>>>&&&&#####$$$$$ Initialized ");
}

JNIEXPORT jstring JNICALL Java_com_ivizon_androidcomputesample_NativeComputeLoad_getDeviceName
  (JNIEnv * env, jclass jobject)
{
    jstring device_name;
    LOGE(">>>>>>&&&&#####$$$$$ Allocating Memory with size %d ", device.name().size());
    char *buffer = (char*) malloc(sizeof(char) * device.name().size());
    strcpy(buffer, device.name().c_str());
    LOGE(">>>>>>&&&&#####$$$$$ Forming the string");
    device_name = env->NewStringUTF(buffer);

    LOGE(">>>>>>&&&&#####$$$$$hello from %s", device.name().c_str());

    return device_name;
}

JNIEXPORT jint JNICALL Java_com_ivizon_androidcomputesample_NativeComputeLoad_getComputeUnits
  (JNIEnv *, jclass)
{
	 LOGE(">>>>>>&&&&#####$$$$$ Number of compute units %d", device.compute_units());
	return device.compute_units();
}

JNIEXPORT jlong JNICALL Java_com_ivizon_androidcomputesample_NativeComputeLoad_getGlobalMemory
  (JNIEnv *, jclass)
{
	LOGE(">>>>>>&&&&#####$$$$$ Global Memory %ld", device.global_memory_size());
	return device.global_memory_size();
}
JNIEXPORT jlong JNICALL Java_com_ivizon_androidcomputesample_NativeComputeLoad_getLocalMemory
  (JNIEnv *, jclass)
{
	LOGE(">>>>>>&&&&#####$$$$$ Local Memory %ld", device.local_memory_size());
	return device.local_memory_size();
}
