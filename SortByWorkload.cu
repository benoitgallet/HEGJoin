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
        unsigned int ** originPointIndex,
        unsigned int ** dev_originPointIndex)
        // bool * isSortByWLDone,
        // unsigned int * nbPointsPreComputed,
        // CPU_State * cpuState)
{

    double tStartSortingCells = omp_get_wtime();

    cudaError_t errCode;

    struct schedulingCell * sortedDatabaseTmp = new schedulingCell[sizeof(struct schedulingCell) * (*nNonEmptyCells)];
    struct schedulingCell * dev_sortedDatabaseTmp;

    cudaEvent_t startKernel, endKernel;
    cudaEventCreate(&startKernel);
    cudaEventCreate(&endKernel);

    errCode = cudaMalloc((void**)&dev_sortedDatabaseTmp, sizeof(struct schedulingCell) * (*nNonEmptyCells));
    if(errCode != cudaSuccess)
    {
        cout << "[SORT] ~ Error: Alloc sortedSet -- error with code " << errCode << '\n';
        cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
        cout.flush();
    }

    // Beginning of the sorting section
    int nbBlock = ((*nNonEmptyCells) / BLOCKSIZE) + 1;
    cout << "[SORT] ~ Using " << nbBlock << " blocks of " << BLOCKSIZE << " threads to sort on the GPU\n";
    cout.flush();

    cudaEventRecord(startKernel);
    #if UNICOMP
        sortByWorkLoadUnicomp<<<nbBlock, BLOCKSIZE>>>((*dev_database), (*dev_epsilon), (*dev_index),
                (*dev_indexLookupArr), (*dev_gridCellLookupArr), (*dev_minArr), (*dev_nCells),
                (*dev_nNonEmptyCells), dev_sortedDatabaseTmp);
    #elif LID_UNICOMP
        sortByWorkLoadLidUnicomp<<<nbBlock, BLOCKSIZE>>>((*dev_database), (*dev_epsilon), (*dev_index),
                (*dev_indexLookupArr), (*dev_gridCellLookupArr), (*dev_minArr), (*dev_nCells),
                (*dev_nNonEmptyCells), dev_sortedDatabaseTmp);
    #else
        cout << "[SORT] ~ Not using a cell access pattern to sort by workload\n";
        sortByWorkLoadGlobal<<<nbBlock, BLOCKSIZE>>>((*dev_database), (*dev_epsilon), (*dev_index),
                (*dev_indexLookupArr), (*dev_gridCellLookupArr), (*dev_minArr), (*dev_nCells),
                (*dev_nNonEmptyCells), dev_sortedDatabaseTmp);
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

    #pragma omp critical
    {
        (*isSortByWLDone) = true;
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

    unsigned int maxNeighbor = sortedDatabaseTmp[0].nbPoints;
    unsigned int minNeighbor = sortedDatabaseTmp[(*nNonEmptyCells) - 1].nbPoints;
    // cout << "max = " << maxNeighbor << '\n';
    // cout << "min = " << minNeighbor << '\n';
    uint64_t accNeighbor = 0;

    // unsigned int * nbNeighborPoints = new unsigned int[(*DBSIZE)];

    // unsigned int nbQueriesPreComputed;
    // bool cpuComputing = true;
    // #pragma omp critical
    // {
    //     if((*cpuState) < CPU_State::computing)
    //     {
    //         nbQueriesPreComputed = 0;
    //         cpuComputing = false;
    //     }
    // }
    //
    // while(cpuComputing)
    // {
    //     #pragma omp critical
    //     {
    //         cpuComputing = (CPU_State::computing == (*cpuState));
    //     }
    // }
    //
    //     // while((*cpuState) != CPU_State::doneComputing){}
    // #pragma omp critical
    // {
    //     nbQueriesPreComputed = (*nbPointsPreComputed);
    // }

    // (*originPointIndex) = new unsigned int [(*DBSIZE) - nbQueriesPreComputed];
    (*originPointIndex) = new unsigned int [(*DBSIZE)];

    int prec = 0;
    for(int i = 0; i < (*nNonEmptyCells); ++i)
    {
        int cellId = sortedDatabaseTmp[i].cellId;
        int nbNeighbor = index[cellId].indexmax - index[cellId].indexmin + 1;
        int nbPointsSkipped = 0;

        accNeighbor += (nbNeighbor * sortedDatabaseTmp[i].nbPoints);

        for(int j = 0; j < nbNeighbor; ++j)
        {
            int tmpId = indexLookupArr[ index[cellId].indexmin + j ];
            (*originPointIndex)[prec + j] = tmpId;
            // if(nbQueriesPreComputed < tmpId)
            // {
            //     (*originPointIndex)[prec + j] = tmpId;
            // }
            // else{
            //     nbPointsSkipped++;
            // }
        }
        prec += nbNeighbor;
        // prec += (nbNeighbor - nbPointsSkipped);
    }

    // Setting some stuff for the CPU so it can begin immediately
    // and allocate buffers to store temp results
    // However, this value is way overestimated as it is set to the max,
    // while the CPU computes from the end of the queue.
    setMaxNeighbors(maxNeighbor);
    setWorkQueueReady();

    errCode = cudaMalloc((void**)dev_originPointIndex, ((*DBSIZE) - nbQueriesPreComputed) * sizeof(unsigned int));
    if(errCode != cudaSuccess)
    {
        cout << "[SORT] ~ Error: Alloc point index -- error with code " << errCode << '\n';
        cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
        cout.flush();
    }

    errCode = cudaMemcpy( (*dev_originPointIndex), (*originPointIndex), ((*DBSIZE) - nbQueriesPreComputed) * sizeof(unsigned int), cudaMemcpyHostToDevice);
    if(errCode != cudaSuccess)
    {
        cout << "[SORT] ~ Error: point index copy -- error with code " << errCode << '\n';
        cout << "[SORT] ~   Details: " << cudaGetErrorString(errCode) << '\n';
        cout.flush();
    }

    unsigned int decileMark = (*nNonEmptyCells) / 10;
    cout << "[SORT] ~ Total number of candidate points to refine: " << accNeighbor << '\n';
    cout << "[SORT] ~ Number of candidates: min = " << minNeighbor << ", median = " << sortedDatabaseTmp[(*nNonEmptyCells) / 2].nbPoints << ", max = " << maxNeighbor << ", avg = " << accNeighbor / (*DBSIZE) << '\n';
    cout << "[SORT] ~ Deciles number of candidates: \n";
    for(int i = 1; i < 10; ++i)
    {
        cout << "   [SORT] ~ " << i * 10 << "% = " << sortedDatabaseTmp[decileMark * i].nbPoints << '\n';
    }
    cout.flush();

    cudaFree(dev_sortedDatabaseTmp);

    delete[] sortedDatabaseTmp;
    // delete[] nbNeighborPoints;

    double tEndSortingCells = omp_get_wtime();

    cout << "[SORT] ~ Time to sort the cells by workload and copy to the GPU: " << tEndSortingCells - tStartSortingCells << '\n';
    cout.flush();

}
