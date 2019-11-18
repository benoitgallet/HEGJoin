#include "kernel.h"
#include "structs.h"
#include "params.h"

#include <math.h>

#include <cooperative_groups.h>

#include <thrust/execution_policy.h>
#include <thrust/binary_search.h>

#define __STDC_FORMAT_MACROS
#include <inttypes.h>

//namespace cg = cooperative_groups;
using namespace cooperative_groups;



__device__ void print(unsigned int tid, unsigned int value)
{
	if(0 == tid)
	{
		printf("threadIdx.x 0, value = %d\n", value);
	}
}



__global__ void sortByWorkLoadGlobal(
		DTYPE * database,
		DTYPE * epsilon,
		struct grid * index,
		unsigned int * indexLookupArr,
		struct gridCellLookup * gridCellLookupArr,
		DTYPE * minArr,
		unsigned int * nCells,
		unsigned int * nNonEmptyCells,
		unsigned int * gridCellNDMask,
		unsigned int * gridCellNDMaskOffsets,
		schedulingCell * sortedCells)
{

	int tid = blockIdx.x * blockDim.x + threadIdx.x;

	if(*nNonEmptyCells <= tid)
	{
		return;
	}

	unsigned int cell = gridCellLookupArr[tid].idx;
	unsigned int nbNeighborPoints = 0;
	unsigned int tmpId = indexLookupArr[ index[cell].indexmin ];

	DTYPE point[GPUNUMDIM];
	for(int i = 0; i < GPUNUMDIM; ++i)
	{
			point[i] = database[tmpId * GPUNUMDIM + i];
	}

	unsigned int nDCellIDs[NUMINDEXEDDIM];

	unsigned int rangeFilteredCellIdsMin[NUMINDEXEDDIM];
	unsigned int rangeFilteredCellIdsMax[NUMINDEXEDDIM];

	for(int n = 0; n < NUMINDEXEDDIM; n++)
	{
		nDCellIDs[n] = (point[n] - minArr[n]) / (*epsilon);
		unsigned int nDMinCellIDs = max(0, nDCellIDs[n] - 1);;
		unsigned int nDMaxCellIDs = min(nCells[n] - 1, nDCellIDs[n] + 1);

		bool foundMin = 0;
		bool foundMax = 0;

		if(thrust::binary_search(thrust::seq, gridCellNDMask + gridCellNDMaskOffsets[ (n * 2) ],
				gridCellNDMask + gridCellNDMaskOffsets[ (n * 2) + 1 ] + 1, nDMinCellIDs)){ //extra +1 here is because we include the upper bound
			foundMin = 1;
		}
		if(thrust::binary_search(thrust::seq, gridCellNDMask + gridCellNDMaskOffsets[ (n * 2) ],
				gridCellNDMask + gridCellNDMaskOffsets[ (n * 2) + 1 ] + 1, nDMaxCellIDs)){ //extra +1 here is because we include the upper bound
			foundMax = 1;
		}

		rangeFilteredCellIdsMin[n] = (1 == foundMin) ? nDMinCellIDs : (nDMinCellIDs + 1);
		rangeFilteredCellIdsMax[n] = (1 == foundMax) ? nDMaxCellIDs : (nDMinCellIDs + 1);
	}

	unsigned int indexes[NUMINDEXEDDIM];
	unsigned int loopRng[NUMINDEXEDDIM];

	for (loopRng[0] = rangeFilteredCellIdsMin[0]; loopRng[0] <= rangeFilteredCellIdsMax[0]; loopRng[0]++)
		for (loopRng[1] = rangeFilteredCellIdsMin[1]; loopRng[1] <= rangeFilteredCellIdsMax[1]; loopRng[1]++)
		#include "kernelloops.h"
		{
			for (int x = 0; x < NUMINDEXEDDIM; x++){
				indexes[x] = loopRng[x];
			}

			uint64_t cellID = getLinearID_nDimensionsGPU(indexes, nCells, NUMINDEXEDDIM);
			struct gridCellLookup tmp;
			tmp.gridLinearID = cellID;
			if (thrust::binary_search(thrust::seq, gridCellLookupArr, gridCellLookupArr + (*nNonEmptyCells), gridCellLookup(tmp)))
			{
				struct gridCellLookup * resultBinSearch = thrust::lower_bound(thrust::seq, gridCellLookupArr, gridCellLookupArr + (*nNonEmptyCells), gridCellLookup(tmp));
				unsigned int GridIndex = resultBinSearch->idx;
				nbNeighborPoints += index[GridIndex].indexmax - index[GridIndex].indexmin + 1;

			}

		}

	sortedCells[tid].nbPoints = nbNeighborPoints;
	sortedCells[tid].cellId = cell;

}



/******************************************************************************/


//TODO use the unicomp pattern
__global__ void sortByWorkLoadUnicomp(
		DTYPE * database,
		DTYPE * epsilon,
		struct grid * index,
		unsigned int * indexLookupArr,
		struct gridCellLookup * gridCellLookupArr,
		DTYPE* minArr,
		unsigned int * nCells,
		unsigned int * nNonEmptyCells,
		unsigned int * gridCellNDMask,
		unsigned int * gridCellNDMaskOffsets,
		schedulingCell * sortedCells)
{

	int tid = blockIdx.x * blockDim.x + threadIdx.x;

	if(*nNonEmptyCells <= tid)
	{
		return;
	}

	int cell = gridCellLookupArr[tid].idx;
	int nbNeighborPoints = 0;
	int tmpId = indexLookupArr[ index[cell].indexmin ];

	DTYPE point[NUMINDEXEDDIM];

	unsigned int nDCellIDs[NUMINDEXEDDIM];

	unsigned int rangeFilteredCellIdsMin[NUMINDEXEDDIM];
	unsigned int rangeFilteredCellIdsMax[NUMINDEXEDDIM];

	for(int n = 0; n < NUMINDEXEDDIM; n++)
	{
		point[n] = database[tmpId * NUMINDEXEDDIM + n];
		nDCellIDs[n] = (point[n] - minArr[n]) / (*epsilon);
		unsigned int nDMinCellIDs = max(0, nDCellIDs[n] - 1);;
		unsigned int nDMaxCellIDs = min(nCells[n] - 1, nDCellIDs[n] + 1);

		bool foundMin = 0;
		bool foundMax = 0;

		if(thrust::binary_search(thrust::seq, gridCellNDMask + gridCellNDMaskOffsets[ (n * 2) ],
				gridCellNDMask + gridCellNDMaskOffsets[ (n * 2) + 1 ] + 1, nDMinCellIDs)){ //extra +1 here is because we include the upper bound
			foundMin = 1;
		}
		if(thrust::binary_search(thrust::seq, gridCellNDMask + gridCellNDMaskOffsets[ (n * 2) ],
				gridCellNDMask + gridCellNDMaskOffsets[ (n * 2) + 1 ] + 1, nDMaxCellIDs)){ //extra +1 here is because we include the upper bound
			foundMax = 1;
		}

		if (1 == foundMin && 1 == foundMax){
			rangeFilteredCellIdsMin[n] = nDMinCellIDs;
			rangeFilteredCellIdsMax[n] = nDMaxCellIDs;
			//printf("\nmin and max");
		}
		else if (1 == foundMin && 0 == foundMax){
			rangeFilteredCellIdsMin[n] = nDMinCellIDs;
			rangeFilteredCellIdsMax[n] = nDMinCellIDs + 1;
			//printf("\nmin not max");
		}
		else if (0 == foundMin && 1 == foundMax){
			rangeFilteredCellIdsMin[n] = nDMinCellIDs + 1;
			rangeFilteredCellIdsMax[n] = nDMaxCellIDs;
			//printf("\nmax not min");
		}
		else{
			//printf("\nneither");
			rangeFilteredCellIdsMin[n] = nDMinCellIDs + 1;
			rangeFilteredCellIdsMax[n] = nDMinCellIDs + 1;
		}
	}

	unsigned int indexes[NUMINDEXEDDIM];
	unsigned int loopRng[NUMINDEXEDDIM];

	for (loopRng[0] = rangeFilteredCellIdsMin[0]; loopRng[0] <= rangeFilteredCellIdsMax[0]; loopRng[0]++)
		for (loopRng[1] = rangeFilteredCellIdsMin[1]; loopRng[1] <= rangeFilteredCellIdsMax[1]; loopRng[1]++)
		#include "kernelloops.h"
		{
			for (int x = 0; x < NUMINDEXEDDIM; x++){
				indexes[x] = loopRng[x];
			}

			uint64_t cellID = getLinearID_nDimensionsGPU(indexes, nCells, NUMINDEXEDDIM);
			struct gridCellLookup tmp;
			tmp.gridLinearID = cellID;
			if (thrust::binary_search(thrust::seq, gridCellLookupArr, gridCellLookupArr + (*nNonEmptyCells), gridCellLookup(tmp)))
			{
				struct gridCellLookup * resultBinSearch = thrust::lower_bound(thrust::seq, gridCellLookupArr, gridCellLookupArr + (*nNonEmptyCells), gridCellLookup(tmp));
				unsigned int GridIndex = resultBinSearch->idx;
				nbNeighborPoints += index[GridIndex].indexmax - index[GridIndex].indexmin + 1;
			}

		}

	sortedCells[tid].nbPoints = nbNeighborPoints;
	sortedCells[tid].cellId = cell;

}



/******************************************************************************/



__global__ void sortByWorkLoadLidUnicomp(
		DTYPE* database,
		DTYPE* epsilon,
		struct grid * index,
		unsigned int * indexLookupArr,
		struct gridCellLookup * gridCellLookupArr,
		DTYPE* minArr,
		unsigned int * nCells,
		unsigned int * nNonEmptyCells,
		unsigned int * gridCellNDMask,
		unsigned int * gridCellNDMaskOffsets,
		schedulingCell * sortedCells)
{

	int tid = blockIdx.x * blockDim.x + threadIdx.x;

	if(*nNonEmptyCells <= tid)
	{
		return;
	}

	int cell = gridCellLookupArr[tid].idx;
	int nbNeighborPoints = 0;
	int tmpId = indexLookupArr[ index[cell].indexmin ];

	DTYPE point[NUMINDEXEDDIM];

	unsigned int nDCellIDs[NUMINDEXEDDIM];

	unsigned int rangeFilteredCellIdsMin[NUMINDEXEDDIM];
	unsigned int rangeFilteredCellIdsMax[NUMINDEXEDDIM];

	for(int n = 0; n < NUMINDEXEDDIM; n++)
	{
		point[n] = database[tmpId * NUMINDEXEDDIM + n];
		nDCellIDs[n] = (point[n] - minArr[n]) / (*epsilon);
		unsigned int nDMinCellIDs = max(0, nDCellIDs[n] - 1);;
		unsigned int nDMaxCellIDs = min(nCells[n] - 1, nDCellIDs[n] + 1);

		bool foundMin = 0;
		bool foundMax = 0;

		if(thrust::binary_search(thrust::seq, gridCellNDMask + gridCellNDMaskOffsets[ (n * 2) ],
				gridCellNDMask + gridCellNDMaskOffsets[ (n * 2) + 1 ] + 1, nDMinCellIDs)){ //extra +1 here is because we include the upper bound
			foundMin = 1;
		}
		if(thrust::binary_search(thrust::seq, gridCellNDMask + gridCellNDMaskOffsets[ (n * 2) ],
				gridCellNDMask + gridCellNDMaskOffsets[ (n * 2) + 1 ] + 1, nDMaxCellIDs)){ //extra +1 here is because we include the upper bound
			foundMax = 1;
		}

		if (1 == foundMin && 1 == foundMax){
			rangeFilteredCellIdsMin[n] = nDMinCellIDs;
			rangeFilteredCellIdsMax[n] = nDMaxCellIDs;
			//printf("\nmin and max");
		}
		else if (1 == foundMin && 0 == foundMax){
			rangeFilteredCellIdsMin[n] = nDMinCellIDs;
			rangeFilteredCellIdsMax[n] = nDMinCellIDs + 1;
			//printf("\nmin not max");
		}
		else if (0 == foundMin && 1 == foundMax){
			rangeFilteredCellIdsMin[n] = nDMinCellIDs + 1;
			rangeFilteredCellIdsMax[n] = nDMaxCellIDs;
			//printf("\nmax not min");
		}
		else{
			//printf("\nneither");
			rangeFilteredCellIdsMin[n] = nDMinCellIDs + 1;
			rangeFilteredCellIdsMax[n] = nDMinCellIDs + 1;
		}
	}

	unsigned int indexes[NUMINDEXEDDIM];
	unsigned int loopRng[NUMINDEXEDDIM];

	for (int x = 0; x < NUMINDEXEDDIM; x++){
		indexes[x] = nDCellIDs[x];
	}

	uint64_t originCellID = getLinearID_nDimensionsGPU(indexes, nCells, NUMINDEXEDDIM);

	for (loopRng[0] = rangeFilteredCellIdsMin[0]; loopRng[0] <= rangeFilteredCellIdsMax[0]; loopRng[0]++)
		for (loopRng[1] = rangeFilteredCellIdsMin[1]; loopRng[1] <= rangeFilteredCellIdsMax[1]; loopRng[1]++)
		#include "kernelloops.h"
		{
			for (int x = 0; x < NUMINDEXEDDIM; x++){
				indexes[x] = loopRng[x];
			}

			uint64_t cellID = getLinearID_nDimensionsGPU(indexes, nCells, NUMINDEXEDDIM);
			if(originCellID <= cellID)
			{
				struct gridCellLookup tmp;
				tmp.gridLinearID = cellID;
				if (thrust::binary_search(thrust::seq, gridCellLookupArr, gridCellLookupArr + (*nNonEmptyCells), gridCellLookup(tmp)))
				{
					struct gridCellLookup * resultBinSearch = thrust::lower_bound(thrust::seq, gridCellLookupArr, gridCellLookupArr + (*nNonEmptyCells), gridCellLookup(tmp));
					unsigned int GridIndex = resultBinSearch->idx;
					nbNeighborPoints += index[GridIndex].indexmax - index[GridIndex].indexmin + 1;
				}
			}

		}

	sortedCells[tid].nbPoints = nbNeighborPoints;
	sortedCells[tid].cellId = cell;

}



/******************************************************************************/



__device__ uint64_t getLinearID_nDimensionsGPU(
		unsigned int * indexes,
		unsigned int * dimLen,
		unsigned int nDimensions)
{
    uint64_t offset = 0;
	uint64_t multiplier = 1;

	for (int i = 0; i < nDimensions; i++)
	{
		offset += (uint64_t) indexes[i] * multiplier;
		multiplier *= dimLen[i];
	}

	return offset;
}



/******************************************************************************/



__forceinline__ __device__ void evalPoint(
		unsigned int* indexLookupArr,
		int k,
		DTYPE* database,
		DTYPE* epsilon,
		DTYPE* point,
		unsigned int* cnt,
		int* pointIDKey,
		int* pointInDistVal,
		int pointIdx,
		bool differentCell)
{
	// unsigned int tid = blockIdx.x * BLOCKSIZE + threadIdx.x;

	DTYPE runningTotalDist = 0;
	unsigned int dataIdx = indexLookupArr[k];

	for(int l = 0; l < GPUNUMDIM; l++){
		runningTotalDist += ( database[dataIdx * GPUNUMDIM + l] - point[l])
				* (database[dataIdx * GPUNUMDIM + l] - point[l] );
	}

	if(sqrt(runningTotalDist) <= (*epsilon)){
	//if(runningTotalDist <= ((*epsilon) * (*epsilon))){
		unsigned int idx = atomicAdd(cnt, int(1));
		pointIDKey[idx] = pointIdx; // --> HERE
		pointInDistVal[idx] = dataIdx;

		if(differentCell)
		{
			unsigned int idx = atomicAdd(cnt, int(1));
			pointIDKey[idx] = dataIdx;
			// pointIDKey[tid] = dataIdx;
			pointInDistVal[idx] = pointIdx;
			// pointInDistVal[tid] = pointIdx;
		}
	}
}



/******************************************************************************/



__device__ void evaluateCell(
		unsigned int* nCells,
		unsigned int* indexes,
		struct gridCellLookup * gridCellLookupArr,
		unsigned int* nNonEmptyCells,
		DTYPE* database, DTYPE* epsilon,
		struct grid * index,
		unsigned int * indexLookupArr,
		DTYPE* point, unsigned int* cnt,
		int* pointIDKey,
		int* pointInDistVal,
		int pointIdx,
		bool differentCell,
		unsigned int* nDCellIDs)
{
	//compare the linear ID with the gridCellLookupArr to determine if the cell is non-empty: this can happen because one point says
	//a cell in a particular dimension is non-empty, but that's because it was related to a different point (not adjacent to the query point)
	uint64_t calcLinearID = getLinearID_nDimensionsGPU(indexes, nCells, NUMINDEXEDDIM);

	struct gridCellLookup tmp;
	tmp.gridLinearID = calcLinearID;
	//find if the cell is non-empty
	if(thrust::binary_search(thrust::seq, gridCellLookupArr, gridCellLookupArr + (*nNonEmptyCells), gridCellLookup(tmp)))
	{
		//compute the neighbors for the adjacent non-empty cell
		struct gridCellLookup * resultBinSearch = thrust::lower_bound(thrust::seq, gridCellLookupArr, gridCellLookupArr + (*nNonEmptyCells), gridCellLookup(tmp));
		unsigned int GridIndex = resultBinSearch->idx;

		for(int k = index[GridIndex].indexmin; k <= index[GridIndex].indexmax; k++){
			evalPoint(indexLookupArr, k, database, epsilon, point, cnt, pointIDKey, pointInDistVal, pointIdx, differentCell);
		}
	}
}



/******************************************************************************/



__forceinline__ __device__ void evalPointUnicompOrigin(
		unsigned int* indexLookupArr,
		int k,
		DTYPE* database,
		DTYPE* epsilon,
		DTYPE* point,
		unsigned int* cnt,
		int* pointIDKey,
		int* pointInDistVal,
		int pointIdx)
{
	DTYPE runningTotalDist = 0;
	unsigned int dataIdx = indexLookupArr[k];

	for (int l = 0; l < GPUNUMDIM; l++)
	{
		runningTotalDist += (database[dataIdx * GPUNUMDIM + l] - point[l]) * (database[dataIdx * GPUNUMDIM + l] - point[l]);
	}

	if (sqrt(runningTotalDist) <= (*epsilon)){
	//if(runningTotalDist <= ((*epsilon) * (*epsilon))){
		unsigned int idx = atomicAdd(cnt, int(1));
		// assert(idx < 2000000);
		pointIDKey[idx] = pointIdx; // --> HERE
		pointInDistVal[idx] = dataIdx;
	}
}



/******************************************************************************/



__device__ void evaluateCellUnicompOrigin(
		unsigned int* nCells,
		unsigned int* indexes,
		struct gridCellLookup * gridCellLookupArr,
		unsigned int* nNonEmptyCells,
		DTYPE* database, DTYPE* epsilon,
		struct grid * index,
		unsigned int * indexLookupArr,
		DTYPE* point, unsigned int* cnt,
		int* pointIDKey,
		int* pointInDistVal,
		int pointIdx,
		unsigned int* nDCellIDs,
		unsigned int nbThreads,
		unsigned int numThread)
{
	//compare the linear ID with the gridCellLookupArr to determine if the cell is non-empty: this can happen because one point says
	//a cell in a particular dimension is non-empty, but that's because it was related to a different point (not adjacent to the query point)
	uint64_t calcLinearID = getLinearID_nDimensionsGPU(indexes, nCells, NUMINDEXEDDIM);

	struct gridCellLookup tmp;
	tmp.gridLinearID = calcLinearID;
	//find if the cell is non-empty
	if (thrust::binary_search(thrust::seq, gridCellLookupArr, gridCellLookupArr + (*nNonEmptyCells), gridCellLookup(tmp)))
	{
		//compute the neighbors for the adjacent non-empty cell
		struct gridCellLookup * resultBinSearch = thrust::lower_bound(thrust::seq, gridCellLookupArr, gridCellLookupArr + (*nNonEmptyCells), gridCellLookup(tmp));
		unsigned int GridIndex = resultBinSearch->idx;

		int begin = index[GridIndex].indexmin;
		int end = index[GridIndex].indexmax;
		int nbElem = end - begin + 1;
		if(numThread < nbElem)
		{
			int size = nbElem / nbThreads;
			int oneMore = nbElem - (size * nbThreads);
			if(nbElem == (size * nbThreads))
			{
				begin += size * numThread;
				end = begin + size - 1;
			}else{
				begin += numThread * size + ((numThread < oneMore)?numThread:oneMore);
				end = begin + size - 1 + (numThread < oneMore);
			}

			for(int k = begin; k <= end; k++)
			{
				evalPointUnicompOrigin(indexLookupArr, k, database, epsilon, point, cnt, pointIDKey, pointInDistVal, pointIdx);
			}
		}
	}
}



/******************************************************************************/



__forceinline__ __device__ void evalPointUnicompAdjacent(
		unsigned int* indexLookupArr,
		int k,
		DTYPE* database,
		DTYPE* epsilon,
		DTYPE* point,
		unsigned int* cnt,
		int* pointIDKey,
		int* pointInDistVal,
		int pointIdx)
{
	DTYPE runningTotalDist = 0;
	unsigned int dataIdx = indexLookupArr[k];

	for (int l = 0; l < GPUNUMDIM; l++)
	{
		runningTotalDist += (database[dataIdx * GPUNUMDIM + l] - point[l]) * (database[dataIdx * GPUNUMDIM + l] - point[l]);
	}

	if (sqrt(runningTotalDist) <= (*epsilon)){
	//if(runningTotalDist <= ((*epsilon) * (*epsilon))){
		unsigned int idx = atomicAdd(cnt, int(2));
		pointIDKey[idx] = pointIdx;
		pointInDistVal[idx] = dataIdx;
		pointIDKey[idx + 1] = dataIdx;
		pointInDistVal[idx + 1] = pointIdx;
	}
}



/******************************************************************************/



__device__ void evaluateCellUnicompAdjacent(
		unsigned int* nCells,
		unsigned int* indexes,
		struct gridCellLookup * gridCellLookupArr,
		unsigned int* nNonEmptyCells,
		DTYPE* database, DTYPE* epsilon,
		struct grid * index,
		unsigned int * indexLookupArr,
		DTYPE* point, unsigned int* cnt,
		int* pointIDKey,
		int* pointInDistVal,
		int pointIdx,
		unsigned int* nDCellIDs,
		unsigned int nbThreads,
		unsigned int numThread)
{
	//compare the linear ID with the gridCellLookupArr to determine if the cell is non-empty: this can happen because one point says
	//a cell in a particular dimension is non-empty, but that's because it was related to a different point (not adjacent to the query point)
	uint64_t calcLinearID = getLinearID_nDimensionsGPU(indexes, nCells, NUMINDEXEDDIM);

	struct gridCellLookup tmp;
	tmp.gridLinearID = calcLinearID;
	//find if the cell is non-empty
	if (thrust::binary_search(thrust::seq, gridCellLookupArr, gridCellLookupArr + (*nNonEmptyCells), gridCellLookup(tmp)))
	{
		//compute the neighbors for the adjacent non-empty cell
		struct gridCellLookup * resultBinSearch = thrust::lower_bound(thrust::seq, gridCellLookupArr, gridCellLookupArr + (*nNonEmptyCells), gridCellLookup(tmp));
		unsigned int GridIndex = resultBinSearch->idx;

		int begin = index[GridIndex].indexmin;
		int end = index[GridIndex].indexmax;
		int nbElem = end - begin + 1;
		if(numThread < nbElem)
		{
			int size = nbElem / nbThreads;
			int oneMore = nbElem - (size * nbThreads);
			if(nbElem == (size * nbThreads))
			{
				begin += size * numThread;
				end = begin + size - 1;
			}else{
				begin += numThread * size + ((numThread < oneMore)?numThread:oneMore);
				end = begin + size - 1 + (numThread < oneMore);
			}

			for(int k = begin; k <= end; k++)
			{
				evalPointUnicompAdjacent(indexLookupArr, k, database, epsilon, point, cnt, pointIDKey, pointInDistVal, pointIdx);
			}
		}
	}
}



/******************************************************************************/



// used to represent the head of the "queue" when sampling the dataset
__device__ int counterEstimator = 0;

__global__ void kernelNDGridIndexBatchEstimatorAdaptive(
		unsigned int sampleBegin,
		unsigned int sampleEnd,
		unsigned int * N,
		unsigned int * sampleOffset,
		DTYPE * database,
		DTYPE * sortedDatabase,
		unsigned int * originPointIndex,
		DTYPE * epsilon,
		struct grid * index,
		unsigned int * indexLookupArr,
		struct gridCellLookup * gridCellLookupArr,
		DTYPE * minArr,
		unsigned int * nCells,
		unsigned int * cnt,
		unsigned int * nNonEmptyCells,
		unsigned int * gridCellNDMask,
		unsigned int * gridCellNDMaskOffsets)
{

	unsigned int tid = blockIdx.x * BLOCKSIZE + threadIdx.x;

	if((*N) <= tid)
	{
		return;
	}

	//make a local copy of the point
	DTYPE point[GPUNUMDIM];
	for (int i = 0; i < GPUNUMDIM; i++)
	{
			point[i] = database[ originPointIndex[tid] * GPUNUMDIM + i ];
	}

	//calculate the coords of the Cell for the point
	//and the min/max ranges in each dimension
	unsigned int nDCellIDs[NUMINDEXEDDIM];
	unsigned int rangeFilteredCellIdsMin[NUMINDEXEDDIM];
	unsigned int rangeFilteredCellIdsMax[NUMINDEXEDDIM];

	for (int i = 0; i < NUMINDEXEDDIM; i++)
	{

		nDCellIDs[i] = (point[i] - minArr[i]) / (*epsilon);
		unsigned int nDMinCellIDs = max(0, nDCellIDs[i] - 1); //boundary conditions (don't go beyond cell 0)
		unsigned int nDMaxCellIDs = min(nCells[i] - 1, nDCellIDs[i] + 1); //boundary conditions (don't go beyond the maximum number of cells)


		///////////////////////////
		//Take the intersection of the ranges for each dimension between
		//the point and the filtered set of cells in each dimension
		//Ranges in a given dimension that have points in them that are non-empty in a dimension will be tested
		///////////////////////////

		//compare the point's range of cell IDs in each dimension to the filter mask
		//only 2 possible values (you always find the middle point in the range), because that's the cell of the point itself
		bool foundMin = 0;
		bool foundMax = 0;

		//we go throgh each dimension and compare the range of the query points min/max cell ids to the filtered ones
		//find out which ones in the range exist based on the min/max
		//then determine the appropriate ranges

		if(thrust::binary_search(thrust::seq, gridCellNDMask + gridCellNDMaskOffsets[ (i * 2) ],
				gridCellNDMask + gridCellNDMaskOffsets[ (i * 2) + 1 ] + 1, nDMinCellIDs)){ //extra +1 here is because we include the upper bound
			foundMin = 1;
		}
		if(thrust::binary_search(thrust::seq, gridCellNDMask + gridCellNDMaskOffsets[ (i * 2) ],
				gridCellNDMask + gridCellNDMaskOffsets[ (i * 2) + 1 ] + 1, nDMaxCellIDs)){ //extra +1 here is because we include the upper bound
			foundMax = 1;
		}

		// cases:
		// found the min and max
		// found the min and not max
		//found the max and not the min
		//you don't find the min or max -- then only check the mid
		//you always find the mid because it's in the cell of the point you're looking for

		rangeFilteredCellIdsMin[i] = (1 == foundMin) ? nDMinCellIDs : (nDMinCellIDs + 1);
		rangeFilteredCellIdsMax[i] = (1 == foundMax) ? nDMaxCellIDs : (nDMinCellIDs + 1);
	}

	///////////////////////////////////////
	//End taking intersection
	//////////////////////////////////////

	unsigned int indexes[NUMINDEXEDDIM];
	unsigned int loopRng[NUMINDEXEDDIM];

	for (loopRng[0] = rangeFilteredCellIdsMin[0]; loopRng[0] <= rangeFilteredCellIdsMax[0]; loopRng[0]++)
		for (loopRng[1] = rangeFilteredCellIdsMin[1]; loopRng[1] <= rangeFilteredCellIdsMax[1]; loopRng[1]++)
		#include "kernelloops.h"
		{ //beginning of loop body

			for (int x = 0; x < NUMINDEXEDDIM; ++x)
			{
				indexes[x] = loopRng[x];
			}

			uint64_t calcLinearID = getLinearID_nDimensionsGPU(indexes, nCells, NUMINDEXEDDIM);
			//compare the linear ID with the gridCellLookupArr to determine if the cell is non-empty: this can happen because one point says
			//a cell in a particular dimension is non-empty, but that's because it was related to a different point (not adjacent to the query point)

			struct gridCellLookup tmp;
			tmp.gridLinearID = calcLinearID;

			if (thrust::binary_search(thrust::seq, gridCellLookupArr, gridCellLookupArr + (*nNonEmptyCells), gridCellLookup(tmp)))
			{
				//in the GPU implementation we go directly to computing neighbors so that we don't need to
				//store a buffer of the cells to check
				//cellsToCheck->push_back(calcLinearID);

				//HERE WE COMPUTE THE NEIGHBORS FOR THE CELL
				//XXXXXXXXXXXXXXXXXXXXXXXXX

				struct gridCellLookup * resultBinSearch = thrust::lower_bound(thrust::seq, gridCellLookupArr, gridCellLookupArr+(*nNonEmptyCells), gridCellLookup(tmp));
				unsigned int GridIndex = resultBinSearch->idx;

				for (int k = index[GridIndex].indexmin; k <= index[GridIndex].indexmax; ++k)
				{
					DTYPE runningTotalDist = 0;
					unsigned int dataIdx = indexLookupArr[k];

					for (int l = 0; l < GPUNUMDIM; ++l)
					{
						runningTotalDist += (database[dataIdx * GPUNUMDIM + l]  - point[l])
								* (database[dataIdx * GPUNUMDIM + l] - point[l]);
					}

					if (sqrt(runningTotalDist) <= (*epsilon))
					{
						unsigned int idx = atomicAdd(cnt, int(1));
					}
				}
			}
		} //end loop body

}



__global__ void kernelNDGridIndexBatchEstimatorUnicompAdaptive(
		unsigned int sampleBegin,
		unsigned int sampleEnd,
		unsigned int * N,
		unsigned int * sampleOffset,
		DTYPE * database,
		DTYPE * sortedDatabase,
		DTYPE * epsilon,
		struct grid * index,
		unsigned int * indexLookupArr,
		struct gridCellLookup * gridCellLookupArr,
		DTYPE * minArr,
		unsigned int * nCells,
		unsigned int * cnt,
		unsigned int * nNonEmptyCells,
		unsigned int * gridCellNDMask,
		unsigned int * gridCellNDMaskOffsets)
{

	unsigned int tid = blockIdx.x * BLOCKSIZE + threadIdx.x;

	if((*N) <= tid)
	{
		return;
	}

	#if SORT_BY_WORKLOAD
		unsigned int pointID = atomicAdd(&counterEstimator, int(1));
		pointID = pointID * (*sampleOffset) * GPUNUMDIM;
	#else
		unsigned int pointID = tid  * (*sampleOffset) * GPUNUMDIM;
	#endif

	//make a local copy of the point
	DTYPE point[GPUNUMDIM];
	for (int i = 0; i < GPUNUMDIM; ++i){
		#if SORT_BY_WORKLOAD
			point[i] = sortedDatabase[pointID + i];
		#else
			point[i] = database[pointID + i];
		#endif
	}

	//calculate the coords of the Cell for the point
	//and the min/max ranges in each dimension
	unsigned int nDCellIDs[NUMINDEXEDDIM];

	unsigned int rangeFilteredCellIdsMin[NUMINDEXEDDIM];
	unsigned int rangeFilteredCellIdsMax[NUMINDEXEDDIM];

	for (int i = 0; i < NUMINDEXEDDIM; ++i)
	{
		nDCellIDs[i] = (point[i] - minArr[i]) / (*epsilon);
		unsigned int nDMinCellIDs = max(0, nDCellIDs[i] - 1); //boundary conditions (don't go beyond cell 0)
		unsigned int nDMaxCellIDs = min(nCells[i] - 1, nDCellIDs[i] + 1); //boundary conditions (don't go beyond the maximum number of cells)


		///////////////////////////
		//Take the intersection of the ranges for each dimension between
		//the point and the filtered set of cells in each dimension
		//Ranges in a given dimension that have points in them that are non-empty in a dimension will be tested
		///////////////////////////

		//compare the point's range of cell IDs in each dimension to the filter mask
		//only 2 possible values (you always find the middle point in the range), because that's the cell of the point itself
		bool foundMin = 0;
		bool foundMax = 0;

		//we go throgh each dimension and compare the range of the query points min/max cell ids to the filtered ones
		//find out which ones in the range exist based on the min/max
		//then determine the appropriate ranges

		if(thrust::binary_search(thrust::seq, gridCellNDMask + gridCellNDMaskOffsets[ (i * 2) ],
				gridCellNDMask + gridCellNDMaskOffsets[ (i * 2) + 1 ] + 1, nDMinCellIDs)){ //extra +1 here is because we include the upper bound
			foundMin=1;
		}
		if(thrust::binary_search(thrust::seq, gridCellNDMask + gridCellNDMaskOffsets[ (i * 2) ],
				gridCellNDMask + gridCellNDMaskOffsets[ (i * 2) + 1 ] + 1, nDMaxCellIDs)){ //extra +1 here is because we include the upper bound
			foundMax=1;
		}

		// cases:
		// found the min and max
		// found the min and not max
		// found the max and not the min
		// you don't find the min or max -- then only check the mid
		// you always find the mid because it's in the cell of the point you're looking for

		rangeFilteredCellIdsMin[i] = (1 == foundMin) ? nDMinCellIDs : (nDMinCellIDs + 1);
		rangeFilteredCellIdsMax[i] = (1 == foundMax) ? nDMaxCellIDs : (nDMinCellIDs + 1);
	}

	///////////////////////////////////////
	//End taking intersection
	//////////////////////////////////////

	unsigned int indexes[NUMINDEXEDDIM];
	unsigned int loopRng[NUMINDEXEDDIM];

	for(int i = 0; i < NUMINDEXEDDIM; ++i)
	{
		indexes[i] = nDCellIDs[i];
	}

	#include "stamploopsEstimator.h"

}



__global__ void kernelNDGridIndexBatchEstimatorLidUnicompAdaptive(
		unsigned int sampleBegin,
		unsigned int sampleEnd,
		unsigned int * N,
		unsigned int * sampleOffset,
		DTYPE * database,
		DTYPE * sortedDatabase,
		DTYPE * epsilon,
		struct grid * index,
		unsigned int * indexLookupArr,
		struct gridCellLookup * gridCellLookupArr,
		DTYPE * minArr,
		unsigned int * nCells,
		unsigned int * cnt,
		unsigned int * nNonEmptyCells,
		unsigned int * gridCellNDMask,
		unsigned int * gridCellNDMaskOffsets)
{

	unsigned int tid = blockIdx.x * BLOCKSIZE + threadIdx.x;

	if((*N) <= tid)
	{
		return;
	}

	#if SORT_BY_WORKLOAD
		unsigned int pointID = atomicAdd(&counterEstimator, int(1));
		// pointID = pointID * (*sampleOffset) * GPUNUMDIM;
		pointID = pointID * (*sampleOffset / 1.25) * GPUNUMDIM;
	#else
		unsigned int pointID = tid  * (*sampleOffset) * GPUNUMDIM;
	#endif

	//make a local copy of the point
	DTYPE point[GPUNUMDIM];
	for (int i = 0; i < GPUNUMDIM; ++i){
		#if SORT_BY_WORKLOAD
			point[i] = sortedDatabase[pointID + i];
		#else
			point[i] = database[pointID + i];
		#endif
	}

	//calculate the coords of the Cell for the point
	//and the min/max ranges in each dimension
	unsigned int nDCellIDs[NUMINDEXEDDIM];

	unsigned int rangeFilteredCellIdsMin[NUMINDEXEDDIM];
	unsigned int rangeFilteredCellIdsMax[NUMINDEXEDDIM];

	for (int i = 0; i < NUMINDEXEDDIM; ++i)
	{
		nDCellIDs[i] = (point[i] - minArr[i]) / (*epsilon);
		unsigned int nDMinCellIDs = max(0, nDCellIDs[i] - 1); //boundary conditions (don't go beyond cell 0)
		unsigned int nDMaxCellIDs = min(nCells[i] - 1, nDCellIDs[i] + 1); //boundary conditions (don't go beyond the maximum number of cells)


		///////////////////////////
		//Take the intersection of the ranges for each dimension between
		//the point and the filtered set of cells in each dimension
		//Ranges in a given dimension that have points in them that are non-empty in a dimension will be tested
		///////////////////////////

		//compare the point's range of cell IDs in each dimension to the filter mask
		//only 2 possible values (you always find the middle point in the range), because that's the cell of the point itself
		bool foundMin = 0;
		bool foundMax = 0;

		//we go throgh each dimension and compare the range of the query points min/max cell ids to the filtered ones
		//find out which ones in the range exist based on the min/max
		//then determine the appropriate ranges

		if(thrust::binary_search(thrust::seq, gridCellNDMask + gridCellNDMaskOffsets[ (i * 2) ],
				gridCellNDMask + gridCellNDMaskOffsets[ (i * 2) + 1 ] + 1, nDMinCellIDs)){ //extra +1 here is because we include the upper bound
			foundMin=1;
		}
		if(thrust::binary_search(thrust::seq, gridCellNDMask + gridCellNDMaskOffsets[ (i * 2) ],
				gridCellNDMask + gridCellNDMaskOffsets[ (i * 2) + 1 ] + 1, nDMaxCellIDs)){ //extra +1 here is because we include the upper bound
			foundMax=1;
		}

		// cases:
		// found the min and max
		// found the min and not max
		//found the max and not the min
		//you don't find the min or max -- then only check the mid
		//you always find the mid because it's in the cell of the point you're looking for

		rangeFilteredCellIdsMin[i] = (1 == foundMin) ? nDMinCellIDs : (nDMinCellIDs + 1);
		rangeFilteredCellIdsMax[i] = (1 == foundMax) ? nDMaxCellIDs : (nDMinCellIDs + 1);
	}

	///////////////////////////////////////
	//End taking intersection
	//////////////////////////////////////

	unsigned int indexes[NUMINDEXEDDIM];
	unsigned int loopRng[NUMINDEXEDDIM];

	uint64_t cellID = getLinearID_nDimensionsGPU(nDCellIDs, nCells, NUMINDEXEDDIM);

	for (loopRng[0] = rangeFilteredCellIdsMin[0]; loopRng[0] <= rangeFilteredCellIdsMax[0]; loopRng[0]++)
		for (loopRng[1] = rangeFilteredCellIdsMin[1]; loopRng[1] <= rangeFilteredCellIdsMax[1]; loopRng[1]++)
		#include "kernelloops.h"
		{ //beginning of loop body

			for (int x = 0; x < NUMINDEXEDDIM; ++x)
			{
				indexes[x] = loopRng[x];
			}

			uint64_t calcLinearID = getLinearID_nDimensionsGPU(indexes, nCells, NUMINDEXEDDIM);
			//compare the linear ID with the gridCellLookupArr to determine if the cell is non-empty: this can happen because one point says
			//a cell in a particular dimension is non-empty, but that's because it was related to a different point (not adjacent to the query point)

			// condition for the linear id unicomp pattern
			if(cellID <= calcLinearID)
			{
				struct gridCellLookup tmp;
				tmp.gridLinearID = calcLinearID;

				if (thrust::binary_search(thrust::seq, gridCellLookupArr, gridCellLookupArr + (*nNonEmptyCells), gridCellLookup(tmp)))
				{
					//in the GPU implementation we go directly to computing neighbors so that we don't need to
					//store a buffer of the cells to check
					//cellsToCheck->push_back(calcLinearID);

					//HERE WE COMPUTE THE NEIGHBORS FOR THE CELL
					//XXXXXXXXXXXXXXXXXXXXXXXXX

					struct gridCellLookup * resultBinSearch = thrust::lower_bound(thrust::seq, gridCellLookupArr, gridCellLookupArr+(*nNonEmptyCells), gridCellLookup(tmp));
					unsigned int GridIndex = resultBinSearch->idx;

					for (int k = index[GridIndex].indexmin; k <= index[GridIndex].indexmax; ++k)
					{
						DTYPE runningTotalDist = 0;
						unsigned int dataIdx = indexLookupArr[k];

						for (int l = 0; l < GPUNUMDIM; ++l)
						{
							runningTotalDist += (database[dataIdx * GPUNUMDIM + l]  - point[l])
									* (database[dataIdx * GPUNUMDIM + l] - point[l]);
						}

						if (sqrt(runningTotalDist) <= (*epsilon))
						{
							unsigned int idx = atomicAdd(cnt, int(2));
						}
					}
				}
			}
		} //end loop body

}



/******************************************************************************/



// __device__ int counter = 0;

// Global memory kernel - Initial version ("GPU")
__global__ void kernelNDGridIndexGlobal(
		unsigned int * batchBegin,
		unsigned int * N,
		unsigned int * offset,
		unsigned int * batchNum,
		DTYPE * database,
		DTYPE * sortedCells,
		unsigned int * originPointIndex,
		DTYPE * epsilon,
		struct grid * index,
		unsigned int * indexLookupArr,
		struct gridCellLookup * gridCellLookupArr,
		DTYPE * minArr,
		unsigned int * nCells,
		unsigned int * cnt,
		unsigned int * nNonEmptyCells,
		unsigned int * gridCellNDMask,
		unsigned int * gridCellNDMaskOffsets,
		int * pointIDKey,
		int * pointInDistVal)
{

	unsigned int tid = (blockIdx.x * BLOCKSIZE + threadIdx.x);

	if (*N <= tid)
	{
		return;
	}

	unsigned int pointId = atomicAdd(batchBegin, int(1));

	//make a local copy of the point
	DTYPE point[GPUNUMDIM];
	for (int i = 0; i < GPUNUMDIM; i++)
	{
		point[i] = database[ originPointIndex[pointId] * GPUNUMDIM + i ];
	}

	//calculate the coords of the Cell for the point
	//and the min/max ranges in each dimension
	unsigned int nDCellIDs[NUMINDEXEDDIM];
	unsigned int rangeFilteredCellIdsMin[NUMINDEXEDDIM];
	unsigned int rangeFilteredCellIdsMax[NUMINDEXEDDIM];

	for (int i = 0; i < NUMINDEXEDDIM; i++)
	{
		nDCellIDs[i] = (point[i] - minArr[i]) / (*epsilon);
		unsigned int nDMinCellIDs = max(0, nDCellIDs[i] - 1); //boundary conditions (don't go beyond cell 0)
		unsigned int nDMaxCellIDs = min(nCells[i] - 1, nDCellIDs[i] + 1); //boundary conditions (don't go beyond the maximum number of cells)

		//compare the point's range of cell IDs in each dimension to the filter mask
		//only 2 possible values (you always find the middle point in the range), because that's the cell of the point itself
		bool foundMin = 0;
		bool foundMax = 0;

		if(thrust::binary_search(thrust::seq, gridCellNDMask + gridCellNDMaskOffsets[(i * 2)],
				gridCellNDMask + gridCellNDMaskOffsets[(i * 2) + 1] + 1, nDMinCellIDs)){ //extra +1 here is because we include the upper bound
			foundMin = 1;
		}
		if(thrust::binary_search(thrust::seq, gridCellNDMask + gridCellNDMaskOffsets[(i * 2)],
				gridCellNDMask + gridCellNDMaskOffsets[(i * 2) + 1] + 1, nDMaxCellIDs)){ //extra +1 here is because we include the upper bound
			foundMax = 1;
		}

		rangeFilteredCellIdsMin[i] = (1 == foundMin) ? nDMinCellIDs : (nDMinCellIDs + 1);
		rangeFilteredCellIdsMax[i] = (1 == foundMax) ? nDMaxCellIDs : (nDMinCellIDs + 1);
	}

	unsigned int indexes[NUMINDEXEDDIM];
	unsigned int loopRng[NUMINDEXEDDIM];

	for (loopRng[0] = rangeFilteredCellIdsMin[0]; loopRng[0] <= rangeFilteredCellIdsMax[0]; loopRng[0]++)
		for (loopRng[1] = rangeFilteredCellIdsMin[1]; loopRng[1] <= rangeFilteredCellIdsMax[1]; loopRng[1]++)
		#include "kernelloops.h"
		{ //beginning of loop body

			for (int x = 0; x < NUMINDEXEDDIM; x++)
			{
				indexes[x] = loopRng[x];
			}

			evaluateCell(nCells, indexes, gridCellLookupArr, nNonEmptyCells, database, epsilon, index,
					indexLookupArr, point, cnt, pointIDKey, pointInDistVal, originPointIndex[pointId], false, nDCellIDs);

		} //end loop body

}





// Global memory kernel - Unicomp version ("Unicomp")
__global__ void kernelNDGridIndexGlobalUnicomp(
		unsigned int * batchBegin,
		unsigned int * N,
		unsigned int * offset,
		unsigned int * batchNum,
		DTYPE * database,
		DTYPE * sortedCells,
		unsigned int * originPointIndex,
		DTYPE * epsilon,
		struct grid * index,
		unsigned int * indexLookupArr,
		struct gridCellLookup * gridCellLookupArr,
		DTYPE * minArr,
		unsigned int * nCells,
		unsigned int * cnt,
		unsigned int * nNonEmptyCells,
		unsigned int * gridCellNDMask,
		unsigned int * gridCellNDMaskOffsets,
		int * pointIDKey,
		int * pointInDistVal)
{

	unsigned int tid = (blockIdx.x * BLOCKSIZE + threadIdx.x);

	if (*N <= tid)
	{
		return;
	}

	unsigned int pointId = atomicAdd(batchBegin, int(1));

	//make a local copy of the point
	DTYPE point[GPUNUMDIM];
	for (int i = 0; i < GPUNUMDIM; i++)
	{
		point[i] = sortedCells[pointId * GPUNUMDIM + i];
	}

	//calculate the coords of the Cell for the point
	//and the min/max ranges in each dimension
	unsigned int nDCellIDs[NUMINDEXEDDIM];
	unsigned int rangeFilteredCellIdsMin[NUMINDEXEDDIM];
	unsigned int rangeFilteredCellIdsMax[NUMINDEXEDDIM];

	for (int i = 0; i < NUMINDEXEDDIM; i++)
	{
		nDCellIDs[i] = (point[i] - minArr[i]) / (*epsilon);
		unsigned int nDMinCellIDs = max(0, nDCellIDs[i] - 1); //boundary conditions (don't go beyond cell 0)
		unsigned int nDMaxCellIDs = min(nCells[i] - 1, nDCellIDs[i] + 1); //boundary conditions (don't go beyond the maximum number of cells)

		//compare the point's range of cell IDs in each dimension to the filter mask
		//only 2 possible values (you always find the middle point in the range), because that's the cell of the point itself
		bool foundMin = 0;
		bool foundMax = 0;

		if(thrust::binary_search(thrust::seq, gridCellNDMask + gridCellNDMaskOffsets[(i * 2)],
				gridCellNDMask + gridCellNDMaskOffsets[(i * 2) + 1] + 1, nDMinCellIDs)){ //extra +1 here is because we include the upper bound
			foundMin = 1;
		}
		if(thrust::binary_search(thrust::seq, gridCellNDMask + gridCellNDMaskOffsets[(i * 2)],
				gridCellNDMask + gridCellNDMaskOffsets[(i * 2) + 1] + 1, nDMaxCellIDs)){ //extra +1 here is because we include the upper bound
			foundMax = 1;
		}

		rangeFilteredCellIdsMin[i] = (1 == foundMin) ? nDMinCellIDs : (nDMinCellIDs + 1);
		rangeFilteredCellIdsMax[i] = (1 == foundMax) ? nDMaxCellIDs : (nDMinCellIDs + 1);
	}

	///////////////////////////////////////
	//End taking intersection
	//////////////////////////////////////

    unsigned int indexes[NUMINDEXEDDIM];
    unsigned int loopRng[NUMINDEXEDDIM];

	for(int i = 0; i < NUMINDEXEDDIM; i++)
	{
		indexes[i] = nDCellIDs[i];
	}

	evaluateCell(nCells, indexes, gridCellLookupArr, nNonEmptyCells, database, epsilon,
			index, indexLookupArr, point, cnt, pointIDKey, pointInDistVal, originPointIndex[pointId], false, nDCellIDs);
	#include "unicompWorkQueue.h"

}





// Global memory kernel - Linear ID comparison (Need to find a name : L-Unicomp ? Lin-Unicomp ? LId-Unicomp ?)
__global__ void kernelNDGridIndexGlobalLinearIDUnicomp(
		unsigned int * batchBegin,
		unsigned int * N,
		unsigned int * offset,
		unsigned int * batchNum,
		DTYPE * database,
		DTYPE * sortedCells,
		unsigned int * originPointIndex,
		DTYPE * epsilon,
		struct grid * index,
		unsigned int * indexLookupArr,
		struct gridCellLookup * gridCellLookupArr,
		DTYPE * minArr,
		unsigned int * nCells,
		unsigned int * cnt,
		unsigned int * nNonEmptyCells,
		unsigned int * gridCellNDMask,
		unsigned int * gridCellNDMaskOffsets,
		int * pointIDKey,
		int * pointInDistVal)
{

	unsigned int tid = (blockIdx.x * BLOCKSIZE + threadIdx.x);

	if (*N <= tid)
	{
		return;
	}

	unsigned int pointId = atomicAdd(batchBegin, int(1));

	//make a local copy of the point
	DTYPE point[GPUNUMDIM];
	for (int i = 0; i < GPUNUMDIM; i++)
	{
		point[i] = sortedCells[pointId * GPUNUMDIM + i];
	}

	//calculate the coords of the Cell for the point
	//and the min/max ranges in each dimension
	unsigned int nDCellIDs[NUMINDEXEDDIM];
	unsigned int rangeFilteredCellIdsMin[NUMINDEXEDDIM];
	unsigned int rangeFilteredCellIdsMax[NUMINDEXEDDIM];

	for (int i = 0; i < NUMINDEXEDDIM; i++)
	{
		nDCellIDs[i] = (point[i] - minArr[i]) / (*epsilon);
		unsigned int nDMinCellIDs = max(0, nDCellIDs[i] - 1); //boundary conditions (don't go beyond cell 0)
		unsigned int nDMaxCellIDs = min(nCells[i] - 1, nDCellIDs[i] + 1); //boundary conditions (don't go beyond the maximum number of cells)

		//compare the point's range of cell IDs in each dimension to the filter mask
		//only 2 possible values (you always find the middle point in the range), because that's the cell of the point itself
		bool foundMin = 0;
		bool foundMax = 0;

		if(thrust::binary_search(thrust::seq, gridCellNDMask + gridCellNDMaskOffsets[(i * 2)],
				gridCellNDMask + gridCellNDMaskOffsets[(i * 2) + 1] + 1, nDMinCellIDs)){ //extra +1 here is because we include the upper bound
			foundMin = 1;
		}
		if(thrust::binary_search(thrust::seq, gridCellNDMask + gridCellNDMaskOffsets[(i * 2)],
				gridCellNDMask + gridCellNDMaskOffsets[(i * 2) + 1] + 1, nDMaxCellIDs)){ //extra +1 here is because we include the upper bound
			foundMax = 1;
		}

		rangeFilteredCellIdsMin[i] = (1 == foundMin) ? nDMinCellIDs : (nDMinCellIDs + 1);
		rangeFilteredCellIdsMax[i] = (1 == foundMax) ? nDMaxCellIDs : (nDMinCellIDs + 1);
	}

	///////////////////////////////////////
	//End taking intersection
	//////////////////////////////////////

	unsigned int indexes[NUMINDEXEDDIM];
	unsigned int loopRng[NUMINDEXEDDIM];

	uint64_t cellID = getLinearID_nDimensionsGPU(nDCellIDs, nCells, NUMINDEXEDDIM);
	for(int i = 0; i < NUMINDEXEDDIM; i++) {
		indexes[i] = nDCellIDs[i];
	}

	evaluateCellUnicompOrigin(nCells, indexes, gridCellLookupArr, nNonEmptyCells, database, epsilon, index, indexLookupArr,
			point, cnt, pointIDKey, pointInDistVal, originPointIndex[pointId], nDCellIDs, 1, 0);

	// cuts a third of the iterations, that are not necessary, in 2D
	// rangeFilteredCellIdsMin[NUMINDEXEDDIM - 1] = max(rangeFilteredCellIdsMin[NUMINDEXEDDIM - 1],
	// 													nDCellIDs[NUMINDEXEDDIM - 1]);

	for (loopRng[0] = rangeFilteredCellIdsMin[0]; loopRng[0] <= rangeFilteredCellIdsMax[0]; loopRng[0]++)
		for (loopRng[1] = rangeFilteredCellIdsMin[1]; loopRng[1] <= rangeFilteredCellIdsMax[1]; loopRng[1]++)
		#include "kernelloops.h"
		{ //beginning of loop body

			for (int x = 0; x < NUMINDEXEDDIM; x++)
			{
				indexes[x] = loopRng[x];
			}

			uint64_t neighborID = getLinearID_nDimensionsGPU(indexes, nCells, NUMINDEXEDDIM);
			if(cellID < neighborID)
			{
				evaluateCellUnicompAdjacent(nCells, indexes, gridCellLookupArr, nNonEmptyCells, database, epsilon, index, indexLookupArr,
						point, cnt, pointIDKey, pointInDistVal, originPointIndex[pointId], nDCellIDs, 1, 0);
			}

		} //end loop body

}
