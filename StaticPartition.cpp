#include "StaticPartition.h"
#include "params.h"

#include <cstdint>
#include <iostream>
#include <math.h>

#if QUADRO
// Do not include the number of CPU threads
// Parameters for the GPU split based on the number of candidates
    const double INTERCEPT_GPU_CANDIDATES = -12.39066;
    const double DIMENSIONALITY_GPU_CANDIDATES = 0.07716;
    const double NB_QUERIES_GPU_CANDIDATES = 0.03136;
    const double EPSILON_GPU_CANDIDATES = -0.04165;
    const double NB_CANDIDATES_GPU_CANDIDATES = 0.60094;

    // Parameters for the GPU split based on the number of query points
    const double INTERCEPT_GPU_QUERIES = -1.31374;
    const double DIMENSIONALITY_GPU_QUERIES = 0.04499;
    const double NB_QUERIES_GPU_QUERIES = 0.37642;
    const double EPSILON_GPU_QUERIES = 0.23197;

    // Parameters for the CPU split based on the number of candidates
    const double INTERCEPT_CPU_CANDIDATES = -18.20043;
    const double DIMENSIONALITY_CPU_CANDIDATES = 1.05048;
    const double NB_QUERIES_CPU_CANDIDATES = 0.27814;
    const double EPSILON_CPU_CANDIDATES = 0.09782;
    const double NB_CANDIDATES_CPU_CANDIDATES = 0.70146;

    // Parameters for the CPU split based on the number of query points
    const double INTERCEPT_CPU_QUERIES = -5.2706;
    const double DIMENSIONALITY_CPU_QUERIES = 1.0129;
    const double NB_QUERIES_CPU_QUERIES = 0.6809;
    const double EPSILON_CPU_QUERIES = 0.4172;
#else
    // Parameters for the GPU split based on the number of candidates
    const double INTERCEPT_GPU_CANDIDATES = -12.75402;
    const double DIMENSIONALITY_GPU_CANDIDATES = 0.46846;
    const double NB_QUERIES_GPU_CANDIDATES = -0.01421;
    const double EPSILON_GPU_CANDIDATES = -0.02273;
    const double NB_CANDIDATES_GPU_CANDIDATES = 0.63990;

    // Parameters for the GPU split based on the number of query points
    const double INTERCEPT_GPU_QUERIES = -0.9589;
    const double DIMENSIONALITY_GPU_QUERIES = 0.4342;
    const double NB_QUERIES_GPU_QUERIES = 0.3532;
    const double EPSILON_GPU_QUERIES = 0.2686;

    // Parameters for the CPU split based on the number of candidates, do not include the number of threads
    const double INTERCEPT_CPU_CANDIDATES = -17.74948;
    const double DIMENSIONALITY_CPU_CANDIDATES = 0.98041;
    const double NB_QUERIES_CPU_CANDIDATES = 0.43954;
    const double EPSILON_CPU_CANDIDATES = 0.16737;
    const double NB_CANDIDATES_CPU_CANDIDATES = 0.57009;

    // Parameters for the CPU split based on the number of query points, do not include the number of threads
    const double INTERCEPT_CPU_QUERIES = -7.2411;
    const double DIMENSIONALITY_CPU_QUERIES = 0.9499;
    const double NB_QUERIES_CPU_QUERIES = 0.7669;
    const double EPSILON_CPU_QUERIES = 0.4269;
#endif

double getGPUTimeCandidates(int nbQueries, DTYPE epsilon, uint64_t nbCandidates)
{
    double tmpCandidates = NB_CANDIDATES_GPU_CANDIDATES * log(nbCandidates);
    return INTERCEPT_GPU_CANDIDATES
        + (DIMENSIONALITY_GPU_CANDIDATES * log(GPUNUMDIM))
        + (NB_QUERIES_GPU_CANDIDATES * log(nbQueries))
        + (EPSILON_GPU_CANDIDATES * log(epsilon))
        + (tmpCandidates);
}

double getGPUTimeQueries(int nbQueries, DTYPE epsilon)
{
    return INTERCEPT_GPU_QUERIES
        + (DIMENSIONALITY_GPU_QUERIES * log(GPUNUMDIM))
        + (NB_QUERIES_GPU_QUERIES * log(nbQueries))
        + (EPSILON_GPU_QUERIES * log(epsilon));
}

double getCPUTimeCandidates(int nbQueries, DTYPE epsilon, uint64_t nbCandidates)
{
    double tmpCandidates = NB_CANDIDATES_CPU_CANDIDATES * log(nbCandidates);
    // return INTERCEPT_CPU_CANDIDATES
    //     + DIMENSIONALITY_CPU_CANDIDATES * GPUNUMDIM
    //     + NB_QUERIES_CPU_CANDIDATES * nbQueries
    //     + EPSILON_CPU_CANDIDATES * log(epsilon)
    //     + tmpCandidates
    //     + NB_THREADS_CPU_CANDIDATES * CPU_THREADS;
    return INTERCEPT_CPU_CANDIDATES
        + (DIMENSIONALITY_CPU_CANDIDATES * log(GPUNUMDIM))
        + (NB_QUERIES_CPU_CANDIDATES * log(nbQueries))
        + (EPSILON_CPU_CANDIDATES * log(epsilon))
        + (tmpCandidates);
}

double getCPUTimeQueries(int nbQueries, DTYPE epsilon)
{
    // return INTERCEPT_CPU_QUERIES
    //     + DIMENSIONALITY_CPU_QUERIES * GPUNUMDIM
    //     + NB_QUERIES_CPU_QUERIES * nbQueries
    //     + EPSILON_CPU_QUERIES * log(epsilon)
    //     + NB_THREADS_CPU_QUERIES * CPU_THREADS;
    return INTERCEPT_CPU_QUERIES
        + (DIMENSIONALITY_CPU_QUERIES * log(GPUNUMDIM))
        + (NB_QUERIES_CPU_QUERIES * log(nbQueries))
        + (EPSILON_CPU_QUERIES * log(epsilon));
}
