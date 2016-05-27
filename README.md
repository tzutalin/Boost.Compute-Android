# Boost.Compute-Android

## Purpose

Boost.Compute-Anroid is a GPU/parallel-computing library for C++ based on OpenCL for Android platform

## Requirements
* Prepare a Android device

* [Download and setup NDK](https://github.com/tzutalin/android-ndk-downloader)

## Setup
`$ ./envsetup`

## Build and run the first sample, sort.cpp

* Connect to an Android device

* Build and run

`$ ./build.py --test`

* Result on terminal:
```
        get the default compute device
        Get name:QUALCOMM Adreno(TM)
        Get global memory:956149760
        Get local memory:8192
        Get compute_units:4
        create a compute context and command queue
        generate random numbers on the host
        create vector on the device
        copy data to the device
        sort data on the device
        copy data back to the host
```
