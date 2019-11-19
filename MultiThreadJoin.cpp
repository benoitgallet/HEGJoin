//Copyright (c) 2013, Dmitri V. Kalashnikov. All rights reserved.
//This copyright notice should remain at the top of this file.
//

#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <cstdint>
#include "omp.h"

#include "Point.hpp"
#include "Util.hpp"

#include "params.h"
#include "WorkQueue.h"

uint64_t Util::multiThreadJoinWorkQueue(pPoint A, int A_sz, pPoint B, int B_sz, int num_threads, unsigned int * egoMapping, unsigned int * originPointIndex)
{
	uint64_t * results = new uint64_t[CPU_THREADS];
	unsigned int * nbQueries = new unsigned int[CPU_THREADS];
	for(int i = 0; i < CPU_THREADS; ++i)
	{
		results[i] = 0;
		nbQueries[i] = 0;
	}

	double tStart = omp_get_wtime();
	#pragma omp parallel num_threads(CPU_THREADS)
	{
		unsigned int tid = omp_get_thread_num();

		std::vector<int> resultVector;

		std::pair<unsigned int, unsigned int> cpuBatch;
		// unsigned int * batch = new unsigned int[CPU_BATCH_SIZE];
		Point * batch = new Point[CPU_BATCH_SIZE];
		do
		{
			cpuBatch = getBatchFromQueueCPU(A_sz, CPU_BATCH_SIZE);
		}while(cpuBatch.second < cpuBatch.first);

		do
		{
			nbQueries[tid] += cpuBatch.second - cpuBatch.first;
			for(int i = cpuBatch.first; i < cpuBatch.second; ++i)
			{
				unsigned int index = egoMapping[ originPointIndex[i] ];
				&batch[i] = &A[index];
				Util::egoJoinV2(A, 0, A_sz - 1, batch, 0, CPU_BATCH_SIZE - 1, 0, &resultVector);
			}
			// for(int i = cpuBatch.first; i < cpuBatch.second; ++i)
			// {
			// 	unsigned int index = egoMapping[ originPointIndex[i] ];
			// 	Util::egoJoinV2(A, 0, A_sz - 1, B, index, index, 0, &resultVector);
			// }

			cpuBatch = getBatchFromQueueCPU(A_sz, CPU_BATCH_SIZE);
		}while(0 != cpuBatch.second);

		results[tid] += resultVector.size();

		delete[] batch;
		resultVector.clear();
		resultVector.shrink_to_fit();
	}
	double tEnd = omp_get_wtime();

	uint64_t result = 0;
	unsigned int nbQueriesTotal = 0;
	for(int i = 0; i < CPU_THREADS; ++i)
	{
		result += results[i];
		nbQueriesTotal += nbQueries[i];
	}

	printf("[EGO | RESULT] ~ Query points computed by Super-EGO: %d\n", nbQueriesTotal);
	printf("[EGO | RESULT] ~ Compute time for Super-EGO: %f\n", tEnd - tStart);

	delete[] results;

	return result;
}
