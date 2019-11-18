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

uint64_t Util::multiThreadJoinWorkQueue(pPoint A, int A_sz, pPoint B, int B_sz, int num_threads, unsigned int * egoMapping)
{
	uint64_t * results = new uint64_t[CPU_THREADS];
	for(int i = 0; i < CPU_THREADS; ++i)
	{
		results[i] = 0;
	}

	double tStart = omp_get_wtime();
	#pragma omp parallel num_threads(CPU_THREADS)
	{
		unsigned int tid = omp_get_thread_num();

		std::vector<int> * resultVector();

		std::pair<unsigned int, unsigned int> cpuBatch;
		unsigned int * batch = new unsigned int[CPU_BATCH_SIZE];
		do
		{
			cpuBatch = getBatchFromQueueCPU(A_sz, CPU_BATCH_SIZE);
		}while(cpuBatch.first < cpuBatch.second);

		do
		{
			for(int i = 0; i < CPU_BATCH_SIZE; ++i)
			{
				unsigned int index = egoMapping[cpuBatch.first + i];
				Util::egoJoinV2(A, 0, A_sz - 1, B, index, index, 0, resultVector);
			}

			cpuBatch = getBatchFromQueueCPU(A_sz, CPU_BATCH_SIZE);
		}while(0 != cpuBatch.second);

		results[tid] += resultVector.size();

		delete[] batch;
		resultVector.clear();
		resultVector.shrink_to_fit();
	}
	double tEnd = omp_get_wtime();

	printf("[RESULT] ~ Compute time for Super-EGO: %f\n", tEnd - tStart);

	uint64_t result = 0;
	for(int i = 0; i < CPU_THREADS; ++i)
	{
		result += results[i];
	}

	delete[] results;

	return result;
}
