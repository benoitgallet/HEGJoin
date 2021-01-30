# Heterogeneous CPU-GPU Epsilon Grid Joins (HEGJoin)
Authors: Benoit Gallet and Michael Gowanlock
Institution: Northern Arizona University, *School of Informatics, Computing and Cyber Systems*
E-mails: <benoit.gallet@nau.edu>, <michael.gowanlock@nau.edu>

Corresponding publications:
- Benoit Gallet and Michael Gowanlock. Heterogeneous CPU-GPU Epsilon Grid Joins: Static and Dynamic Work Partitioning Strategies, ***Data Science and Engineering***, 2020.
- Benoit Gallet and Michael Gowanlock. HEGJoin: Heterogeneous CPU-GPU Epsilon Grids for Accelerated Distance Similarity Join, ***Proceedings of the 25th International Conference on Database Systems for Advanced Applications (DASFAA)***, 2020.

## Introduction
HEGJoin is a similarity self-join algorithm which, given a multi-dimensional dataset, finds all pairs of points that are within a distance *epsilon* from each other, using the Euclidean distance as the metric. HEGJoin is a heterogeneous algorithm that concurrently uses the CPU and the GPU to increase the overall performance in comparison to other CPU and GPU-only algorithms.

## Pre-Requisites
HEGJoin is written in C++, and uses the CUDA and Boost libraries. Hence, you will need:
- A C++ compiler (e.g., GCC).
- A working installation of CUDA, findable [here](https://developer.nvidia.com/cuda-downloads). Installation guides are available for [Windows](https://docs.nvidia.com/cuda/cuda-installation-guide-microsoft-windows/index.html) and [Linux](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html).
- The Boost library, findable [here](https://dl.bintray.com/boostorg/release/). Note that you do not need to install the library for this project, as only the `sort` header library is necessary.

## Parameters
The file `params.h` contains the different parameters used by the HEGJoin algorithm.
- **GPUNUMDIM**: Dimensionality of the points in the input dataset.
- **NUMINDEXEDDIM**: Number of dimensions to index the data in. Should be less than or equals to **GPUNUMDIM**.
- **BLOCKSIZE**: Number of GPU threads per block.
- **GPUSTREAMS**: Number of streams used by the GPU to overlap kernel computation and data-transfers.
- **CPU_THREADS**: Number of CPU threads to use to join.
- **CPU_BATCH_SIZE**: Number of query points taken by a CPU thread
- **DTYPE** and **REAL**: Type used by the GPU and CPU, respectively, to compute the similarity join.Can be `float` or `double`, and should be the same for both parameters.
- **STATIC_SPLIT_QUERIES**: Used when choosing the static workload partitioning method. Set this value to 1 to assign work to the CPU and GPU based on the total number of queries to compute. Set this value to 0 to assign work based on the total number of candidate points to refine, as given by the grid indexing.

## Datasets
HEGJoin uses textfile datasets, formatted as follows:
- One query point per line.
- Query points' coordinates are separated by commas.
- Coordinates need to be normalized between [0, 1].
We provide in the folder *datasets* a source file to generate exponentially distributed datasets. To generate datasets, use the following commands:
```sh
$ cd datasets
$ make
```
This produces the executable `genDataset`, that you can use as follows:
```sh
$ ./genDataset dimensionality number_of_points
```
The parameter `dimensionality` corresponds to the dimensionality of the points, and `number_of_points` corresponds to the number of points to generate. For example, the command
```sh
$ ./genDataset 2 2000000
```
Produces a dataset with 2,000,000 points in 2 dimensions. This generated dataset will be named `dataset_fixed_len_pts_expo_NDIM_2_pts_2000000.txt` to reflect the number of points and their dimensionality.


## Utilisation
Once the pre-requisite libraries are installed on your computer, and when you have modified the `params.h` file according to the experiment that is going to be computed, compile the sources using:
```sh
$ make
```
This produces the executable `main`. You should re-compile the project every time the `params.h` file is modified, and we recommand using the `clean` rule of the `makefile` prior. The executable can then be used as follows:
```sh
$ ./main dataset epsilon dimensionality algorithm [static_partitioning]
```
- dataset: the input dataset (as presented in the section above).
- epsilon: the search distance *epsilon*, between [0,1].
- dimensionality: the dimensionality of the points. Must match the parameters **GPUNUMDIM** in the `params.h` file.
- algorithm: the algorithm to use to compute the similarity join.
    - 0: GPU-only algorithm.
    - 1: HEGJoin using a dynamic work partitioning approach.
    - 2: HEGJoin using a static work partitioning approach. The work is assigned following the parameter **STATIC_SPLIT_QUERIES** in the `params.h` file.
    - 3: CPU-only algorithm.
- static_partitioning: fraction of work to assign to the GPU, when using the static work partitioning approach. The remaining work is assigned to the CPU. This value should be between [0,1]. This parameter is optional. However, we recommand providing a partitioning value, as we detail in our publication *Heterogeneous CPU-GPU Epsilon Grid Joins: Static and Dynamic Work Partitioning Strategies*. *If the selected algorithm is not HEGJoin using the static work partitioning approach, this parameter will not be used.*

The algorithm might output a lot of information during the computation. We recommand piping the output into the `grep` command as follows:
```sh
$ ./main dataset epsilon dimensionality algorithm [static_partitioning] | grep "RESULT"
```
This will limit the output of the algorithm to the different results of the algorithm, including but not limited to: the total response time, the result set size, the amount of work computed by the CPU and the GPU, etc.

## Notes
We plan to provide, in the future, a complete documentation of the code to ease its understanding and eventual modifications.
