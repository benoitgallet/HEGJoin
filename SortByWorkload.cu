#include "SortByWorkload.h"
#include "structs.h"
#include "params.h"
#include "kernel.h"
#include "WorkQueue.h"

#include <iostream>
#include <algorithm>

#include "omp.h"

#include <cuda_runtime.h>
#include <cuda.h>

using std::cout;
using std::endl;

void sortByWorkLoad(
        unsigned int searchMode,
        unsigned int * DBSIZE,
        DTYPE * epsilon,
        DTYPE ** dev_epsilon,
        DTYPE * database,
        DTYPE ** dev_database,
        struct grid * index,
        struct grid ** dev_index,
        unsigned int * indexLookupArr,
        unsigned int ** dev_indexLookupArr,
        struct gridCellLookup * gridCellLookupArr,
        struct gridCellLookup ** dev_gridCellLookupArr,
        DTYPE * minArr,
        DTYPE ** dev_minArr,
        unsigned int * nCells,
        unsigned int ** dev_nCells,
        unsigned int * nNonEmptyCells,
        unsigned int ** dev_nNonEmptyCells,
        // unsigned int * gridCellNDMask,
        // unsigned int ** dev_gridCellNDMask,
        // unsigned int * gridCellNDMaskOffsets,
        // unsigned int ** dev_gridCellNDMaskOffsets,
        // unsigned int * nNDMaskElems,
        unsigned int ** originPointIndex,
        unsigned int ** dev_originPointIndex,
        DTYPE ** dev_sortedDatabase)
{

    cudaError_t errCode;

    struct schedulingCell * sortedDatabaseTmp = new schedulingCell[sizeof(struct schedulingCell) * (*nNonEmptyCells)];
    struct schedulingCell * dev_sortedDatabaseTmp;

    cudaEvent_t startKernel, endKernel;
    cudaEventCreate(&startKernel);
    cudaEventCreate(&endKernel);

    // Memory allocations needed by the GPU

    double tStartAllocGPU = omp_get_wtime();

    // errCode = cudaMalloc( (void**)dev_epsilon, sizeof(DTYPE));
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: Alloc epsilon -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }

    // errCode = cudaMalloc( (void**)dev_database, sizeof(DTYPE) * (GPUNUMDIM) * (*DBSIZE));
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: Alloc database -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }

    // errCode = cudaMalloc( (void**)dev_index, sizeof(struct grid) * (*nNonEmptyCells));
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: Alloc grid index -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }

    // errCode = cudaMalloc( (void**)dev_indexLookupArr, sizeof(unsigned int) * (*DBSIZE));
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: lookup array allocation -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }

    // errCode = cudaMalloc( (void**)dev_gridCellLookupArr, sizeof(struct gridCellLookup) * (*nNonEmptyCells));
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: copy grid cell lookup array allocation -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }

    // errCode = cudaMalloc((void**)dev_minArr, sizeof(DTYPE) * (NUMINDEXEDDIM));
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: Alloc minArr -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }

    // errCode = cudaMalloc((void**)dev_nCells, sizeof(unsigned int) * (NUMINDEXEDDIM));
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: Alloc nCells -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }

    // errCode = cudaMalloc((void**)dev_nNonEmptyCells, sizeof(unsigned int));
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: Alloc nNonEmptyCells -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }

    // errCode = cudaMalloc((void**)dev_gridCellNDMask, sizeof(unsigned int) * (*nNDMaskElems));
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: Alloc gridCellNDMask -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }
    //
    // errCode = cudaMalloc((void**)dev_gridCellNDMaskOffsets, sizeof(unsigned int) * (2 * NUMINDEXEDDIM));
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: Alloc gridCellNDMaskOffsets -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }

    errCode = cudaMalloc((void**)&dev_sortedDatabaseTmp, sizeof(struct schedulingCell) * (*nNonEmptyCells));
    if(errCode != cudaSuccess)
    {
        cout << "[SORT] ~ Error: Alloc sortedSet -- error with code " << errCode << '\n';
        cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
        cout.flush();
    }

    errCode = cudaMalloc((void**)dev_originPointIndex, (*DBSIZE) * sizeof(unsigned int));
    if(errCode != cudaSuccess)
    {
        cout << "[SORT] ~ Error: Alloc point index -- error with code " << errCode << '\n';
        cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
        cout.flush();
    }

    double tEndAllocGPU = omp_get_wtime();
    cout << "[SORT] ~ Time to allocate on the GPU: " << tEndAllocGPU - tStartAllocGPU << '\n';
    cout.flush();


    // Memory copies needed by the GPU


    double tStartCopyGPU = omp_get_wtime();

    // errCode = cudaMemcpy( (*dev_epsilon), epsilon, sizeof(DTYPE), cudaMemcpyHostToDevice );
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: epsilon copy to device -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }

    // errCode = cudaMemcpy( (*dev_database), database, sizeof(DTYPE) * (GPUNUMDIM) * (*DBSIZE), cudaMemcpyHostToDevice );
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: database copy to device -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }

    // errCode = cudaMemcpy( (*dev_index), index, sizeof(struct grid) * (*nNonEmptyCells), cudaMemcpyHostToDevice );
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: grid index copy to device -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }
    //
    // errCode = cudaMemcpy( (*dev_indexLookupArr), indexLookupArr, sizeof(unsigned int) * (*DBSIZE), cudaMemcpyHostToDevice);
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: copy lookup array to device -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }
    //
    // errCode = cudaMemcpy( (*dev_gridCellLookupArr), gridCellLookupArr, sizeof(struct gridCellLookup) * (*nNonEmptyCells), cudaMemcpyHostToDevice );
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: copy grid cell lookup array to device -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }

    // errCode = cudaMemcpy( (*dev_minArr), minArr, sizeof(DTYPE) * (NUMINDEXEDDIM), cudaMemcpyHostToDevice );
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: Copy minArr to device -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }

    // errCode = cudaMemcpy( (*dev_nCells), nCells, sizeof(unsigned int) * (NUMINDEXEDDIM), cudaMemcpyHostToDevice );
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: Copy nCells to device -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }

    // errCode = cudaMemcpy( (*dev_nNonEmptyCells), nNonEmptyCells, sizeof(unsigned int), cudaMemcpyHostToDevice );
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: nNonEmptyCells copy to device -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }

    // errCode = cudaMemcpy( (*dev_gridCellNDMask), gridCellNDMask, sizeof(unsigned int)*(*nNDMaskElems), cudaMemcpyHostToDevice );
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: Copy gridCellNDMask to device -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }
    //
    // errCode = cudaMemcpy( (*dev_gridCellNDMaskOffsets), gridCellNDMaskOffsets, sizeof(unsigned int) * (2 * NUMINDEXEDDIM), cudaMemcpyHostToDevice );
	// if(errCode != cudaSuccess)
    // {
	// 	cout << "[SORT] ~ Error: Copy gridCellNDMaskOffsets to device -- error with code " << errCode << '\n';
    //     cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
    //     cout.flush();
	// }

    double tEndCopyGPU = omp_get_wtime();
    cout << "[SORT] ~ Time to copy to the GPU: " << tEndCopyGPU - tStartCopyGPU << '\n';
    cout.flush();




    // Beginning of the sorting section
    double tStartSortingCells = omp_get_wtime();

    int nbBlock = ((*nNonEmptyCells) / BLOCKSIZE) + 1;
    cout << "[SORT] ~ Using " << nbBlock << " blocks of " << BLOCKSIZE << " threads to sort on the GPU\n";
    cout.flush();

    cudaEventRecord(startKernel);
    #if UNICOMP
        sortByWorkLoadUnicomp<<<nbBlock, BLOCKSIZE>>>((*dev_database), (*dev_epsilon), (*dev_index),
                (*dev_indexLookupArr), (*dev_gridCellLookupArr), (*dev_minArr), (*dev_nCells),
                (*dev_nNonEmptyCells), /*(*dev_gridCellNDMask), (*dev_gridCellNDMaskOffsets),*/
                dev_sortedDatabaseTmp);
    #elif LID_UNICOMP
        sortByWorkLoadLidUnicomp<<<nbBlock, BLOCKSIZE>>>((*dev_database), (*dev_epsilon), (*dev_index),
                (*dev_indexLookupArr), (*dev_gridCellLookupArr), (*dev_minArr), (*dev_nCells),
                (*dev_nNonEmptyCells), /*(*dev_gridCellNDMask), (*dev_gridCellNDMaskOffsets),*/
                dev_sortedDatabaseTmp);
    #else
        cout << "[SORT] ~ Not using a cell access pattern to sort by workload\n";
        sortByWorkLoadGlobal<<<nbBlock, BLOCKSIZE>>>((*dev_database), (*dev_epsilon), (*dev_index),
                (*dev_indexLookupArr), (*dev_gridCellLookupArr), (*dev_minArr), (*dev_nCells),
                (*dev_nNonEmptyCells), /*(*dev_gridCellNDMask), (*dev_gridCellNDMaskOffsets),*/
                dev_sortedDatabaseTmp);
    #endif
    cudaEventRecord(endKernel);

    errCode = cudaGetLastError();
    cout << "[SORT] ~ SORTING KERNEL LAUNCH RETURN: " << errCode << '\n';
    cout.flush();

    cudaDeviceSynchronize();

    errCode = cudaMemcpy(sortedDatabaseTmp, dev_sortedDatabaseTmp, sizeof(struct schedulingCell) * (*nNonEmptyCells), cudaMemcpyDeviceToHost);
    if(errCode != cudaSuccess)
    {
        cout << "[SORT] ~ Error: copy sorted cells from the GPU -- error with code " << errCode << '\n';
        cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
        cout.flush();
    }

    cudaEventSynchronize(endKernel);
    float timeKernel = 0;
    cudaEventElapsedTime(&timeKernel, startKernel, endKernel);
    cout << "[SORT] ~ Kernel time to sort by workload: " << timeKernel << '\n';
    cout.flush();

    double tBeginSort = omp_get_wtime();
    std::sort(sortedDatabaseTmp, sortedDatabaseTmp + (*nNonEmptyCells),
            [](const schedulingCell& a, const schedulingCell& b){ return a.nbPoints > b.nbPoints; });
    double tEndSort = omp_get_wtime();
    printf("[SORT] ~ Time to call std::sort = %f\n", tEndSort - tBeginSort);

    (*originPointIndex) = new unsigned int [(*DBSIZE)];

    // unsigned int maxNeighbor = 0;
    // unsigned int minNeighbor = (*DBSIZE);
    unsigned int maxNeighbor = sortedDatabaseTmp[0].nbPoints;
    unsigned int minNeighbor = sortedDatabaseTmp[(*nNonEmptyCells) - 1].nbPoints;
    cout << "max = " << maxNeighbor << '\n';
    cout << "min = " << minNeighbor << '\n';
    uint64_t accNeighbor = 0;

    unsigned int * nbNeighborPoints = new unsigned int[(*DBSIZE)];

    int prec = 0;
    for(int i = 0; i < (*nNonEmptyCells); ++i)
    {
        int cellId = sortedDatabaseTmp[i].cellId;
        int nbNeighbor = index[cellId].indexmax - index[cellId].indexmin + 1;

        // some stats about the number of neighbor
        accNeighbor += (nbNeighbor * sortedDatabaseTmp[i].nbPoints);

        for(int j = 0; j < nbNeighbor; ++j)
        {
            int tmpId = indexLookupArr[ index[cellId].indexmin + j ];
            nbNeighborPoints[tmpId] = nbNeighbor;
            (*originPointIndex)[prec + j] = tmpId;
        }
        prec += nbNeighbor;
    }

    // Setting some stuff for the CPU so it can begin immediately
    // and allocate buffers to store temp results
    // However, this value is way overestimated as it is set to the max,
    // while the CPU computes from the end of the queue.
    setMaxNeighbors(maxNeighbor);
    setWorkQueueReady();

    errCode = cudaMemcpy( (*dev_originPointIndex), (*originPointIndex), (*DBSIZE) * sizeof(unsigned int), cudaMemcpyHostToDevice);
    if(errCode != cudaSuccess)
    {
        cout << "[SORT] ~ Error: point index copy -- error with code " << errCode << '\n';
        cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
        cout.flush();
    }

    cudaFree(dev_sortedDatabaseTmp);

    unsigned int decileMark = (*nNonEmptyCells) / 10;
    cout << "[SORT] ~ Total number of candidate points to refine: " << accNeighbor << '\n';
    cout << "[SORT] ~ Number of candidates: min = " << minNeighbor << ", median = " << sortedDatabaseTmp[(*nNonEmptyCells) / 2].nbPoints << ", max = " << maxNeighbor << ", avg = " << accNeighbor / (*DBSIZE) << '\n';
    cout << "[SORT] ~ Deciles number of candidates: \n";
    for(int i = 1; i < 10; ++i)
    {
        cout << "   [SORT] ~ " << i * 10 << "% = " << sortedDatabaseTmp[decileMark * i].nbPoints << '\n';
    }
    cout.flush();

    delete[] sortedDatabaseTmp;

    double tEndSortingCells = omp_get_wtime();

    cout << "[SORT] ~ Time to sort the cells by workload and copy to the GPU: " << tEndSortingCells - tStartSortingCells << '\n';
    cout.flush();

    cout << "\n\n\n";
    for(unsigned int i = 0; i < (*DBSIZE); ++i)
    {
        cout << nbNeighborPoints[i] << '\n';
    }
    cout << "\n\n\n";

    delete[] nbNeighborPoints;

}
