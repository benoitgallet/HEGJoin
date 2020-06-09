#include "StaticPartition.h"
#include "params.h"

#include <cstdint>
#include <iostream>
#include <math.h>

#if QUADRO
// Do not include the number of CPU threads
// Parameters for the GPU split based on the number of candidates
    const double INTERCEPT_GPU_CANDIDATES = -9.92272;
    const double DIMENSIONALITY_GPU_CANDIDATES = 0.02419;
    const double NB_QUERIES_GPU_CANDIDATES = 0.00000000829262;
    const double EPSILON_GPU_CANDIDATES = 0.06437;
    const double NB_CANDIDATES_GPU_CANDIDATES = 0.54194;

    // Parameters for the GPU split based on the number of query points
    const double INTERCEPT_GPU_QUERIES = 5.91701;
    const double DIMENSIONALITY_GPU_QUERIES = -0.06135;
    const double NB_QUERIES_GPU_QUERIES = 0.0000000728596;
    const double EPSILON_GPU_QUERIES = 0.51727;

    // Parameters for the CPU split based on the number of candidates
    const double INTERCEPT_CPU_CANDIDATES = -16.24919;
    const double DIMENSIONALITY_CPU_CANDIDATES = 0.29583;
    const double NB_QUERIES_CPU_CANDIDATES = 0.0000000374503;
    const double EPSILON_CPU_CANDIDATES = -0.01821;
    const double NB_CANDIDATES_CPU_CANDIDATES = 0.76488;
    // const double NB_THREADS_CPU_CANDIDATES = -0.04741;

    // Parameters for the CPU split based on the number of query points
    const double INTERCEPT_CPU_QUERIES = 6.10668;
    const double DIMENSIONALITY_CPU_QUERIES = 0.17410;
    const double NB_QUERIES_CPU_QUERIES = 0.000000128579;
    const double EPSILON_CPU_QUERIES = 0.62099;
    // const double NB_THREADS_CPU_QUERIES = -0.04741;
#else
    // Parameters for the GPU split based on the number of candidates
    const double INTERCEPT_GPU_CANDIDATES = -10.45666;
    const double DIMENSIONALITY_GPU_CANDIDATES = 0.097;
    const double NB_QUERIES_GPU_CANDIDATES = 0.00000000124;
    const double EPSILON_GPU_CANDIDATES = 0.13525;
    const double NB_CANDIDATES_GPU_CANDIDATES = 0.58134;

    // Parameters for the GPU split based on the number of query points
    const double INTERCEPT_GPU_QUERIES = 6.53458;
    const double DIMENSIONALITY_GPU_QUERIES = 0.00536;
    const double NB_QUERIES_GPU_QUERIES = 0.0000000705051;
    const double EPSILON_GPU_QUERIES = 0.62107;

    // Parameters for the CPU split based on the number of candidates
    // const double INTERCEPT_CPU_CANDIDATES = -14.24209;
    // const double DIMENSIONALITY_CPU_CANDIDATES = 0.31092;
    // const double NB_QUERIES_CPU_CANDIDATES = 0.0000000595963;
    // const double EPSILON_CPU_CANDIDATES = -0.05180;
    // const double NB_CANDIDATES_CPU_CANDIDATES = 0.69389;
    // const double NB_THREADS_CPU_CANDIDATES = -0.04741;

    // Parameters for the CPU split based on the number of candidates, do not include the number of threads
    const double INTERCEPT_CPU_CANDIDATES = -14.92362;
    const double DIMENSIONALITY_CPU_CANDIDATES = 0.31328;
    const double NB_QUERIES_CPU_CANDIDATES = 0.0000000681354;
    const double EPSILON_CPU_CANDIDATES = -0.06796;
    const double NB_CANDIDATES_CPU_CANDIDATES = 0.65749;

    // Parameters for the CPU split based on the number of query points
    // const double INTERCEPT_CPU_QUERIES = 6.03884;
    // const double DIMENSIONALITY_CPU_QUERIES = 0.20140;
    // const double NB_QUERIES_CPU_QUERIES = 0.000000142267;
    // const double EPSILON_CPU_QUERIES = 0.52808;
    // const double NB_THREADS_CPU_QUERIES = -0.04741;

    // Parameters for the CPU split based on the number of query points, do not include the number of threads
    const double INTERCEPT_CPU_QUERIES = 4.2934;
    const double DIMENSIONALITY_CPU_QUERIES = 0.20950;
    const double NB_QUERIES_CPU_QUERIES = 0.000000146469;
    const double EPSILON_CPU_QUERIES = 0.48150;
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
