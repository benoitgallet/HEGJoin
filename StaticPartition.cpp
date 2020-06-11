#include "StaticPartition.h"
#include "params.h"

#include <cstdint>
#include <iostream>
#include <math.h>

#if QUADRO
// Do not include the number of CPU threads
// Parameters for the GPU split based on the number of candidates
    const double INTERCEPT_GPU_CANDIDATES = -11.80523;
    const double DIMENSIONALITY_GPU_CANDIDATES = -0.01075433;
    const double NB_QUERIES_GPU_CANDIDATES = 0.1284542;
    const double EPSILON_GPU_CANDIDATES = 31.7827;
    const double NB_CANDIDATES_GPU_CANDIDATES = 0.5256226;

    // Parameters for the GPU split based on the number of query points
    const double INTERCEPT_GPU_QUERIES = -3.236487;
    const double DIMENSIONALITY_GPU_QUERIES = -0.1660775;
    const double NB_QUERIES_GPU_QUERIES = 0.399735;
    const double EPSILON_GPU_QUERIES = 183.9834;

    // Parameters for the CPU split based on the number of candidates
    const double INTERCEPT_CPU_CANDIDATES = -18.8191;
    const double DIMENSIONALITY_CPU_CANDIDATES = 0.3673868;
    const double NB_QUERIES_CPU_CANDIDATES = 0.08318612;
    const double EPSILON_CPU_CANDIDATES = -54.58217;
    const double NB_CANDIDATES_CPU_CANDIDATES = 0.8304813;

    // Parameters for the CPU split based on the number of query points
    const double INTERCEPT_CPU_QUERIES = -5.28053;
    const double DIMENSIONALITY_CPU_QUERIES = 0.1219769;
    const double NB_QUERIES_CPU_QUERIES = 0.5118084;
    const double EPSILON_CPU_QUERIES = 185.8942;
#else
    // Parameters for the GPU split based on the number of candidates
    const double INTERCEPT_GPU_CANDIDATES = -12.54757;
    const double DIMENSIONALITY_GPU_CANDIDATES = 0.136548;
    const double NB_QUERIES_GPU_CANDIDATES = 0.0006730338;
    const double EPSILON_GPU_CANDIDATES = -5.012166;
    const double NB_CANDIDATES_GPU_CANDIDATES = 0.6305365;

    // Parameters for the GPU split based on the number of query points
    const double INTERCEPT_GPU_QUERIES = -2.268519;
    const double DIMENSIONALITY_GPU_QUERIES = -0.04977766;
    const double NB_QUERIES_GPU_QUERIES = 0.3261012;
    const double EPSILON_GPU_QUERIES = 177.5677;

    // Parameters for the CPU split based on the number of candidates, do not include the number of threads
    const double INTERCEPT_CPU_CANDIDATES = -18.57735;
    const double DIMENSIONALITY_CPU_CANDIDATES = 0.3872055;
    const double NB_QUERIES_CPU_CANDIDATES = 0.1686795;
    const double EPSILON_CPU_CANDIDATES = -62.87518;
    const double NB_CANDIDATES_CPU_CANDIDATES = 0.7334402;

    // Parameters for the CPU split based on the number of query points, do not include the number of threads
    const double INTERCEPT_CPU_QUERIES = -6.62075;
    const double DIMENSIONALITY_CPU_QUERIES = 0.1704715;
    const double NB_QUERIES_CPU_QUERIES = 0.5472176;
    const double EPSILON_CPU_QUERIES = 149.5017;
#endif

double getGPUTimeCandidates(int nbQueries, DTYPE epsilon, uint64_t nbCandidates)
{
    double tmpCandidates = NB_CANDIDATES_GPU_CANDIDATES * log(nbCandidates);
    return INTERCEPT_GPU_CANDIDATES
        + DIMENSIONALITY_GPU_CANDIDATES * GPUNUMDIM
        + NB_QUERIES_GPU_CANDIDATES * nbQueries
        + EPSILON_GPU_CANDIDATES * log(epsilon)
        + tmpCandidates;
}

double getGPUTimeQueries(int nbQueries, DTYPE epsilon)
{
    return INTERCEPT_GPU_QUERIES
        + DIMENSIONALITY_GPU_QUERIES * GPUNUMDIM
        + NB_QUERIES_GPU_QUERIES * nbQueries
        + EPSILON_GPU_QUERIES * log(epsilon);
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
        + DIMENSIONALITY_CPU_CANDIDATES * GPUNUMDIM
        + NB_QUERIES_CPU_CANDIDATES * nbQueries
        + EPSILON_CPU_CANDIDATES * log(epsilon)
        + tmpCandidates;
}

double getCPUTimeQueries(int nbQueries, DTYPE epsilon)
{
    // return INTERCEPT_CPU_QUERIES
    //     + DIMENSIONALITY_CPU_QUERIES * GPUNUMDIM
    //     + NB_QUERIES_CPU_QUERIES * nbQueries
    //     + EPSILON_CPU_QUERIES * log(epsilon)
    //     + NB_THREADS_CPU_QUERIES * CPU_THREADS;
    return INTERCEPT_CPU_QUERIES
        + DIMENSIONALITY_CPU_QUERIES * GPUNUMDIM
        + NB_QUERIES_CPU_QUERIES * nbQueries
        + EPSILON_CPU_QUERIES * log(epsilon);
}
