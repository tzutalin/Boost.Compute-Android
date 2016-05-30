# Boost.Compute-Android

## Purpose

Boost.Compute-Anroid is a GPU/parallel-computing library for C++ based on OpenCL for Android platform

## Requirements
* Prepare a Android device

* [Download and setup NDK](https://github.com/tzutalin/android-ndk-downloader)

## Setup
`$ ./envsetup`

## Build and run the first sample, sort.cpp

Make sure connecting to an Android device

`$ adb devices`


Build and run

`$ ./build.py --test`

Result on terminal:
```
    get the default compute device
    get name:QUALCOMM Adreno(TM)
    get global memory:956149760
    get local memory:8192
    get compute_units:4
    get device type:4
    create a compute context and command queue
    generate random 10000 numbers on the host
    create vector on the device
    copy data to the device
    sort data on the device
    copy data back to the host
    cost time:1.0061

    Compare with STL sort without Boost.Compute
    generate random 10000 numbers for stl to sort
    cost time:0.00234
```
