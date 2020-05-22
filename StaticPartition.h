#ifndef STATIC_PARTITION_H
#define STATIC_PARTITION_H

double getGPUTimeCandidates(int nbQueries, DTYPE epsilon, uint64_t nbCandidates);

double getGPUTimeQueries(int nbQueries, DTYPE epsilon);

double getCPUTimeCandidates(int nbQueries, DTYPE epsilon, uint64_t nbCandidates);

double getCPUTimeQueries(int nbQueries, DTYPE epsilon);

#endif
