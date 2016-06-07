/*
 * test_sort.cpp using google-style
 *
 *  Created on: May 27, 2016
 *      Author: Tzutalin
 *
 *  Copyright (c) 2016 Tzutalin. All rights reserved.
 */

#include <algorithm>
#include <boost/compute.hpp>
#include <ctime>
#include <glog/logging.h>
#include <vector>

namespace compute = boost::compute;

int main() {
  std::cout << "get the default compute device" << std::endl;
  compute::device gpu = compute::system::default_device();

  std::cout << "get name:" << gpu.name() << std::endl;
  std::cout << "get global memory:" << gpu.global_memory_size() << std::endl;
  std::cout << "get local memory:" << gpu.local_memory_size() << std::endl;
  std::cout << "get compute_units:" << gpu.compute_units() << std::endl;
  std::cout << "get device type:" << gpu.type() << std::endl;

  std::cout << "create a compute context and command queue" << std::endl;
  const int num_vector =
      10000;  // over 50000, there is Out of Resource for my device
  {
    compute::context ctx(gpu);
    compute::command_queue queue(ctx, gpu);
    // Going to measure
    std::clock_t begin = std::clock();
    std::cout << "generate random " << num_vector << " numbers on the host"
              << std::endl;
    std::vector<float> host_vector(num_vector);
    std::generate(host_vector.begin(), host_vector.end(), rand);

    std::cout << "create vector on the device" << std::endl;
    compute::vector<float> device_vector(num_vector, ctx);

    std::cout << "copy data to the device" << std::endl;
    compute::copy(host_vector.begin(), host_vector.end(), device_vector.begin(),
                  queue);

    std::cout << "sort data on the device" << std::endl;
    compute::sort(device_vector.begin(), device_vector.end(), queue);

    std::cout << "copy data back to the host" << std::endl;
    compute::copy(device_vector.begin(), device_vector.end(),
                  host_vector.begin(), queue);

    std::clock_t end = std::clock();
    double elapsed_secs = double(end - begin) / CLOCKS_PER_SEC;
    std::cout << "cost time:" << elapsed_secs << std::endl;
  }

  {
    std::cout << "\nCompare with STL sort without Boost.Compute" << std::endl;
    std::clock_t begin = std::clock();
    std::cout << "generate random " << num_vector << " numbers for stl to sort"
              << std::endl;
    std::vector<float> stl_vector(num_vector);
    std::generate(stl_vector.begin(), stl_vector.end(), rand);
    std::sort(stl_vector.begin(), stl_vector.end());
    std::clock_t end = std::clock();
    double elapsed_secs = double(end - begin) / CLOCKS_PER_SEC;
    std::cout << "cost time:" << elapsed_secs << std::endl;
  }
  return 0;
}
