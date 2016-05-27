
DIR=.
VERSION=12

echo "Downloading headers for version ${VERSION}..."

mkdir -p "${DIR}/CL-${VERSION}/CL"
cd "${DIR}/CL-${VERSION}/CL"

wget https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/opencl${VERSION}/opencl.h
wget https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/opencl${VERSION}/cl_platform.h
wget https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/opencl${VERSION}/cl.h
wget https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/opencl${VERSION}/cl_ext.h
wget https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/opencl${VERSION}/cl_egl.h
wget https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/opencl${VERSION}/cl_dx9_media_sharing.h
wget https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/opencl${VERSION}/cl_d3d10.h
wget https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/opencl${VERSION}/cl_d3d11.h
wget https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/opencl${VERSION}/cl_gl.h
wget https://raw.githubusercontent.com/KhronosGroup/OpenCL-Headers/opencl${VERSION}/cl_gl_ext.h
wget https://www.khronos.org/registry/cl/api/2.1/cl.hpp

    
