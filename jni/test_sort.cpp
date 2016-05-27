#include <vector>
#include <algorithm>
#include <boost/compute.hpp>
#include <glog/logging.h>

namespace compute = boost::compute;

int main()
{
    std::cout << "get the default compute device" << std::endl;
    compute::device gpu = compute::system::default_device();

    std::cout << "get name:" << gpu.name() << std::endl;
    std::cout << "get global memory:" << gpu.global_memory_size() << std::endl;
    std::cout << "get local memory:" << gpu.local_memory_size() << std::endl;
    std::cout << "get compute_units:" << gpu.compute_units() << std::endl;

    std::cout << "create a compute context and command queue" << std::endl;
    compute::context ctx(gpu);
    compute::command_queue queue(ctx, gpu);

    const int num_vector = 1000;
    std::cout<< "generate random numbers on the host" << std::endl;
    std::vector<float> host_vector(num_vector);
    std::generate(host_vector.begin(), host_vector.end(), rand);

    std::cout << "create vector on the device" << std::endl;
    compute::vector<float> device_vector(num_vector, ctx);

    std::cout << "copy data to the device" << std::endl;
    compute::copy(
        host_vector.begin(), host_vector.end(), device_vector.begin(), queue
    );

    std::cout<< "sort data on the device" << std::endl;
    compute::sort(
        device_vector.begin(), device_vector.end(), queue
    );

    std::cout << "copy data back to the host" << std::endl;
    compute::copy(
        device_vector.begin(), device_vector.end(), host_vector.begin(), queue
    );

    return 0;
}
