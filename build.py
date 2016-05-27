#!/usr/bin/python
import os
import sys
import argparse
from distutils.dir_util import copy_tree
import subprocess
from subprocess import Popen, PIPE

DEVICE_ABI = 'armeabi-v7a';

def parse_args():
    """
    Parse input arguments
    """
    parser = argparse.ArgumentParser(description='Build dlib-android')
    parser.add_argument('--jobs', dest='jobs', help='Jobs to compile',
                        default=1, type=int)

    parser.add_argument('--clean', action='store_true',
                        help='clean obj and binaries')

    parser.add_argument('--test', action='store_true',
                        help='Push executable file to data/local/tmp/, and run them')

    args = parser.parse_args()
    return args

def ndk_build(jobs):
    try:
        # subprocess.call(['ndk-build', 'NDK_LOG=1', 'NDK_DEBUG=1', 'V=1', '-j' + str(jobs)])
        print subprocess.check_output(['ndk-build', '-j4', 'NDK_LOG=1', 'NDK_DEBUG=1', 'V=1'], stderr=subprocess.STDOUT, universal_newlines=True)
    except subprocess.CalledProcessError as grepexc:
        print grepexc.output
        print('\033[91m' + ' error ! ' + '\033[0m')
        os.sys.exit(0)

def ndk_clean():
    subprocess.call(['ndk-build', 'clean'])

def setDeviceABI():
    global DEVICE_ABI
    p = subprocess.Popen(['adb', 'shell', 'getprop', 'ro.product.cpu.abi'], stdin=PIPE, stdout=PIPE, stderr=PIPE)
    output, err = p.communicate(b"input data that is passed to subprocess' stdin")
    rc = p.returncode
    if rc == 0:
        if "x86" in output:
            DEVICE_ABI = 'x86'

    print 'ABI:' + DEVICE_ABI

def test():
    global DEVICE_ABI
    print '----Push test_sort to phone device'
    srcFolder = os.path.join('libs', DEVICE_ABI, 'test_sort')
    subprocess.call(['adb', 'push', srcFolder, '/data/local/tmp'])
    print '----Execute /data/local/tmp/test_sort'
    subprocess.call(['adb', 'shell', './data/local/tmp/test_sort'])

if __name__ == '__main__':
    # Move to top-level
    ROOT = os.path.dirname(os.path.abspath(__file__))
    os.chdir(ROOT)

    libs_dir = os.path.join(ROOT, 'libs')
    obj_dir = os.path.join(ROOT, 'obj')

    setDeviceABI()

    args = parse_args()
    if args.clean:
        ndk_clean()
    else:
        ndk_build(args.jobs)

    if args.test:
        test()
