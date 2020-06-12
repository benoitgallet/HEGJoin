#include "StaticPartition.h"
#include "params.h"

#include <cstdint>
#include <iostream>
#include <math.h>

#if QUADRO
// Do not include the number of CPU threads
// Parameters for the GPU split based on the number of candidates
    const double INTERCEPT_GPU_CANDIDATES = -460.841;
    const double DIMENSIONALITY_GPU_CANDIDATES = 13.2635;
    const double NB_QUERIES_GPU_CANDIDATES = 3.9332;
    const double EPSILON_GPU_CANDIDATES = 0.9368;
    const double NB_CANDIDATES_GPU_CANDIDATES = 17.2651;

    // Parameters for the GPU split based on the number of query points
    const double INTERCEPT_GPU_QUERIES = -142.599;
    const double DIMENSIONALITY_GPU_QUERIES = 12.339;
    const double NB_QUERIES_GPU_QUERIES = 13.847;
    const double EPSILON_GPU_QUERIES = 8.798;

    // Parameters for the CPU split based on the number of candidates
    const double INTERCEPT_CPU_CANDIDATES = -3410.61;
    const double DIMENSIONALITY_CPU_CANDIDATES = 145.08;
    const double NB_QUERIES_CPU_CANDIDATES = 49.22;
    const double EPSILON_CPU_CANDIDATES = 20.52;
    const double NB_CANDIDATES_CPU_CANDIDATES = 110.73;

    // Parameters for the CPU split based on the number of query points
    const double INTERCEPT_CPU_QUERIES = -1369.65;
    const double DIMENSIONALITY_CPU_QUERIES = 139.16;
    const double NB_QUERIES_CPU_QUERIES = 112.79;
    const double EPSILON_CPU_QUERIES = 70.94;
#else
    // Parameters for the GPU split based on the number of candidates
    const double INTERCEPT_GPU_CANDIDATES = -12.75402;
    const double DIMENSIONALITY_GPU_CANDIDATES = 0.468458;
    const double NB_QUERIES_GPU_CANDIDATES = -0.01421392;
    const double EPSILON_GPU_CANDIDATES = -0.02273103;
    const double NB_CANDIDATES_GPU_CANDIDATES = 0.6399043;

    // Parameters for the GPU split based on the number of query points
    const double INTERCEPT_GPU_QUERIES = -0.9589096;
    const double DIMENSIONALITY_GPU_QUERIES = 0.4342037;
    const double NB_QUERIES_GPU_QUERIES = 0.3532161;
    const double EPSILON_GPU_QUERIES = 0.2686324;

    // Parameters for the CPU split based on the number of candidates, do not include the number of threads
    const double INTERCEPT_CPU_CANDIDATES = -17.74948;
    const double DIMENSIONALITY_CPU_CANDIDATES = 0.9804137;
    const double NB_QUERIES_CPU_CANDIDATES = 0.4395403;
    const double EPSILON_CPU_CANDIDATES = 0.1673653;
    const double NB_CANDIDATES_CPU_CANDIDATES = 0.5700943;

    // Parameters for the CPU split based on the number of query points, do not include the number of threads
    const double INTERCEPT_CPU_QUERIES = -7.241144;
    const double DIMENSIONALITY_CPU_QUERIES = 0.9498964;
    const double NB_QUERIES_CPU_QUERIES = 0.7668858;
    const double EPSILON_CPU_QUERIES = 0.4269427;
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
