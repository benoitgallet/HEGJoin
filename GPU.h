#ifndef GPU_H
#define GPU_H

#include "structs.h"
#include "params.h"

#include <vector>

// #include <thrust/host_vector.h>
// #include <thrust/device_vector.h>
// #include <thrust/sort.h>
// #include <thrust/device_ptr.h>
// #include <thrust/system/cuda/execution_policy.h> // for streams for thrust (added with Thrust v1.8)
//
// #include <thrust/copy.h>
// #include <thrust/fill.h>
// #include <thrust/sequence.h>

void gridIndexingGPU(
    unsigned int * DBSIZE,
    uint64_t totalCells,
    DTYPE * database,
    DTYPE ** dev_database,
    DTYPE * epsilon,
    DTYPE ** dev_epsilon,
    DTYPE * minArr,
    DTYPE ** dev_minArr,
    struct grid ** index,
    struct grid ** dev_index,
    unsigned int * indexLookupArr,
    unsigned int ** dev_indexLookupArr,
    struct gridCellLookup ** gridCellLookupArr,
    struct gridCellLookup ** dev_gridCellLookupArr,
    unsigned int * nNonEmptyCells,
    unsigned int ** dev_nNonEmptyCells,
    unsigned int * nCells,
    unsigned int ** dev_nCells);

void distanceTableNDGridBatches(
        int searchMode,
        unsigned int * DBSIZE,
        DTYPE * epsilon,
        DTYPE * dev_epsilon,
        DTYPE * database,
        DTYPE * dev_database,
        struct grid * index,
        struct grid * dev_index,
        unsigned int * indexLookupArr,
        unsigned int * dev_indexLookupArr,
        struct gridCellLookup * gridCellLookupArr,
        struct gridCellLookup * dev_gridCellLookupArr,
        DTYPE * minArr,
        DTYPE * dev_minArr,
        unsigned int * nCells,
        unsigned int * dev_nCells,
        unsigned int * nNonEmptyCells,
        unsigned int * dev_nNonEmptyCells,
        // unsigned int * gridCellNDMask,
        // unsigned int * dev_gridCellNDMask,
        // unsigned int * gridCellNDMaskOffsets,
        // unsigned int * dev_gridCellNDMaskOffsets,
        // unsigned int * nNDMaskElems,
        unsigned int * originPointIndex,
        unsigned int * dev_originPointIndex,
        struct neighborTableLookup * neighborTable,
        std::vector<struct neighborDataPtrs> * pointersToNeighbors,
        uint64_t * totalNeighbors);

unsigned long long callGPUBatchEst(
        unsigned int * DBSIZE,
        unsigned int sampleBegin,
        unsigned int sampleEnd,
        DTYPE * dev_database,
        DTYPE * dev_sortedDatabase,
        unsigned int * dev_originPointIndex,
        DTYPE * dev_epsilon,
        struct grid * dev_grid,
    	unsigned int * dev_indexLookupArr,
        struct gridCellLookup * dev_gridCellLookupArr,
        DTYPE * dev_minArr,
    	unsigned int * dev_nCells,
        unsigned int * dev_nNonEmptyCells,
        // unsigned int * dev_gridCellNDMask,
    	// unsigned int * dev_gridCellNDMaskOffsets,
        unsigned int * retNumBatches,
        unsigned int * retGPUBufferSize);

unsigned long long callGPUBatchEstTest(
        unsigned int * DBSIZE,
        unsigned int sampleBegin,
        unsigned int sampleEnd,
        DTYPE * dev_database,
        DTYPE * dev_sortedDatabase,
        unsigned int * dev_originPointIndex,
        DTYPE * dev_epsilon,
        struct grid * dev_grid,
    	unsigned int * dev_indexLookupArr,
        struct gridCellLookup * dev_gridCellLookupArr,
        DTYPE * dev_minArr,
    	unsigned int * dev_nCells,
        unsigned int * dev_nNonEmptyCells,
        // unsigned int * dev_gridCellNDMask,
    	// unsigned int * dev_gridCellNDMaskOffsets,
        unsigned int * retNumBatches,
        unsigned int * retGPUBufferSize);

void constructNeighborTableKeyValueWithPtrs(
        int * pointIDKey,
        int * pointInDistValue,
        struct neighborTableLookup * neighborTable,
        int * pointersToNeighbors,
        unsigned int * cnt);

void warmUpGPU();

#endif
