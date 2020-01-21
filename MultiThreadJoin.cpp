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

uint64_t Util::multiThreadJoinWorkQueue(
	unsigned int searchMode,
	pPoint A, int A_sz,
	pPoint B, int B_sz,
	unsigned int * egoMapping,
	unsigned int * originPointIndex,
	neighborTableLookup * neighborTable)
{
	uint64_t * results = new uint64_t[CPU_THREADS];
	unsigned int * nbQueries = new unsigned int[CPU_THREADS];
	for(int i = 0; i < CPU_THREADS; ++i)
	{
		results[i] = 0;
		nbQueries[i] = 0;
	}

	// std::vector<int> resultVector[CPU_THREADS];

	double tStart = omp_get_wtime();
	if(searchMode == SM_HYBRID)
	{
		#pragma omp parallel num_threads(CPU_THREADS)
		{
			unsigned int tid = omp_get_thread_num();
			// std::vector<int> resultVector;
			std::pair<unsigned int, unsigned int> cpuBatch;
			// Point * batch = new Point[CPU_BATCH_SIZE];

			unsigned int * tmpBuffer = new unsigned int[getMaxNeighbors()];
			unsigned int * nbNeighbors = new unsigned int;

			do
			{
				cpuBatch = getBatchFromQueueCPU(A_sz, CPU_BATCH_SIZE);
			}while(cpuBatch.second < cpuBatch.first);

			do
			{
				// printf("[EGO | T_%d] ~ Begin: %d, end: %d\n", tid, cpuBatch.first, cpuBatch.second);
				nbQueries[tid] += cpuBatch.second - cpuBatch.first;
				// unsigned int batchIndex = 0;
				// for(int i = cpuBatch.first; i < cpuBatch.second; ++i)
				// {
				// 	unsigned int index = egoMapping[ originPointIndex[i] ];
				// 	batch[batchIndex] = A[index];
				// 	batchIndex++;
				// }
				// Util::egoJoinV2(A, 0, A_sz - 1, batch, 0, CPU_BATCH_SIZE - 1, 0, &resultVector);
				for(unsigned int i = cpuBatch.first; i < cpuBatch.second; ++i)
				{
					(*nbNeighbors) = 0;
					unsigned int index = egoMapping[ originPointIndex[i] ];
					// Util::egoJoinV2(A, 0, A_sz - 1, B, index, index, 0, &(resultVector[tid]));
					Util::egoJoinV2(A, 0, A_sz - 1, B, index, index, 0, tmpBuffer, nbNeighbors);

					unsigned int tmpIndex = originPointIndex[i];
					neighborTable[tmpIndex].pointID = i;
					neighborTable[tmpIndex].indexmin = 0;
					neighborTable[tmpIndex].indexmax = (*nbNeighbors) - 1;
					neighborTable[tmpIndex].dataPtr = new int[(*nbNeighbors)];
					std::copy(tmpBuffer, tmpBuffer + (*nbNeighbors), neighborTable[tmpIndex].dataPtr);

					results[tid] += (*nbNeighbors);
				}

				cpuBatch = getBatchFromQueueCPU(A_sz, CPU_BATCH_SIZE);
			}while(0 != cpuBatch.second);

			// results[tid] += resultVector[tid].size() / 2;

			// resultVector[tid].clear();
			// resultVector[tid].shrink_to_fit();

			delete[] tmpBuffer;
		}
	}
	else // only use the CPU, not the GPU
	{
		#pragma omp parallel num_threads(CPU_THREADS)
		{
			unsigned int tid = omp_get_thread_num();
			// std::vector<int> resultVector;
			std::pair<unsigned int, unsigned int> cpuBatch;

			unsigned int * tmpBuffer = new unsigned int[getMaxNeighbors()];
			unsigned int * nbNeighbors = new unsigned int;

			do
			{
				nbQueries[tid] += cpuBatch.second - cpuBatch.first;

				for(unsigned int i = cpuBatch.first; i < cpuBatch.second; ++i)
				{
					(*nbNeighbors) = 0;
					unsigned int index = egoMapping[ originPointIndex[i] ];

					// Util::egoJoinV2(A, 0, A_sz - 1, B, index, index, 0, &(resultVector[tid]));
					Util::egoJoinV2(A, 0, A_sz - 1, B, index, index, 0, tmpBuffer, nbNeighbors);

					unsigned int tmpIndex = originPointIndex[i];
					neighborTable[tmpIndex].pointID = index;
					neighborTable[tmpIndex].indexmin = 0;
					neighborTable[tmpIndex].indexmax = (*nbNeighbors) - 1;
					neighborTable[tmpIndex].dataPtr = new int[(*nbNeighbors)];
					std::copy(tmpBuffer, tmpBuffer + (*nbNeighbors), neighborTable[tmpIndex].dataPtr);

					results[tid] += (*nbNeighbors);
				}

				cpuBatch = getBatchFromQueue(A_sz, CPU_BATCH_SIZE);
			}while(0 != cpuBatch.second);

			// results[tid] += resultVector[tid].size() / 2;

			// resultVector[tid].clear();
			// resultVector[tid].shrink_to_fit();

			delete[] tmpBuffer;
		}
	}
	double tEnd = omp_get_wtime();

	uint64_t result = 0;
	unsigned int nbQueriesTotal = 0;
	for(int i = 0; i < CPU_THREADS; ++i)
	{
		result += results[i];
		nbQueriesTotal += nbQueries[i];
	}

	// for(int i = 0; i < CPU_THREADS; i++)
	// {
	// 	for(int j = 0; j < resultVector[i].size(); j += 2)
	// 	{
	// 		printf("[EGO] ~ Query %d, neighbor %d\n", resultVector[i][j], resultVector[i][j + 1]);
	// 	}
	// }

	printf("[EGO | RESULT] ~ Query points computed by Super-EGO: %d\n", nbQueriesTotal);
	printf("[EGO | RESULT] ~ Compute time for Super-EGO: %f\n", tEnd - tStart);

	delete[] results;
	delete[] nbQueries;

	return result;
}
