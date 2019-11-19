#include <iostream>
#include <stdio.h>
#include <string.h>
#include <vector>
#include <math.h>
#include <set>

#include "omp.h"

#include "main.h"
#include "params.h"
#include "structs.h"
#include "SortByWorkload.h"
#include "WorkQueue.h"
#include "GPU.h"

#include "Point.hpp"
#include "Util.hpp"

using std::cout;
using std::endl;

int main(int argc, char * argv[])
{

    printf("\n\n========== Hybrid-EGO ==========\n\n");

    if(NB_ARGS != argc)
    {
        printf("Expected %d args, found %d\n", NB_ARGS, argc);
        printf("Args: filename epsilon dim searchmode\n");
        return 1;
    }

    char filename[256];
    strcpy(filename, argv[FILENAME_ARG]);

    // int datasetSize = atoi(argv[DATASETSIZE_ARG]);
    DTYPE epsilon = atof(argv[EPSILON_ARG]);
    int dim = atoi(argv[DIM_ARG]);
    int searchMode = atoi(argv[SEARCHMODE_ARG]);

    if(GPUNUMDIM != dim)
    {
        printf("Error: dim should be equals to GPUNUMDIM (params.h)\n");
        return 1;
    }

    if(epsilon <= 0.0)
    {
        printf("Error: epsilon should be positive\n");
        return 1;
    }

    printf("Dataset: %s\n", filename);
    printf("Epsilon: %f\n", epsilon);
    printf("Dimensionality: %d\n", dim);
    printf("Search mode: %d\n", searchMode);

    std::vector< std::vector<DTYPE> > NDdataPoints;
    double tBeginReadDataset = omp_get_wtime();
    importNDDataset(&NDdataPoints, filename);
    double tEndReadDataset = omp_get_wtime();
    printf("Time to read the dataset: %f\n", tEndReadDataset - tBeginReadDataset);

    unsigned int DBSIZE = NDdataPoints.size();
    setQueueIndexCPU(DBSIZE);

    sortInNDBins(&NDdataPoints);

    Point * A = new Point[DBSIZE + 1];
    for(int i = 0; i < DBSIZE; ++i)
    {
        pPoint p = & A[i];
        p->id = i;
        for(int j = 0; j < NUMINDEXEDDIM; ++j)
        {
            p->x[j] = NDdataPoints[i][j];
        }
    }
    Point * B = A;

    DTYPE * minArr = new DTYPE [NUMINDEXEDDIM];
    DTYPE * maxArr = new DTYPE [NUMINDEXEDDIM];
    unsigned int * nCells = new unsigned int [NUMINDEXEDDIM];
    uint64_t totalCells = 0;
    unsigned int nNonEmptyCells = 0;

    generateNDGridDimensions(&NDdataPoints, epsilon, minArr, maxArr, nCells, &totalCells);
    printf("[GPU] ~ Total cells (including empty): %lu\n", totalCells);

    struct grid * index;
    struct gridCellLookup * gridCellLookupArr;
    unsigned int * gridCellNDMask;
    unsigned int * nNDMaskElems = new unsigned int;
    unsigned int * gridCellNDMaskOffsets = new unsigned int [NUMINDEXEDDIM * 2];
    unsigned int * indexLookupArr = new unsigned int[NDdataPoints.size()];

    populateNDGridIndexAndLookupArray(&NDdataPoints, epsilon, &gridCellLookupArr, &index,
            indexLookupArr, minArr,  nCells, totalCells, &nNonEmptyCells, &gridCellNDMask,
            gridCellNDMaskOffsets, nNDMaskElems);

    //Neighbortable storage -- the result
    neighborTableLookup * neighborTable = new neighborTableLookup [NDdataPoints.size()];
    // neighborTableLookup * neighborTable = new neighborTableLookup[DBSIZE * fraction];
    std::vector<struct neighborDataPtrs> pointersToNeighbors(DBSIZE);

    DTYPE * database = new DTYPE [DBSIZE * GPUNUMDIM];
    for(unsigned int i = 0; i < DBSIZE; ++i)
    {
        for(unsigned int j = 0; j < GPUNUMDIM; ++j)
        {
            database[i * GPUNUMDIM + j] = NDdataPoints[i][j];
        }
        // std::copy(NDdataPoints[i].begin(), NDdataPoints[i].end(), database + i * GPUNUMDIM);
    }

    DTYPE * dev_epsilon;
    DTYPE * dev_database;
    struct grid * dev_index;
    unsigned int * dev_indexLookupArr;
    struct gridCellLookup * dev_gridCellLookupArr;
    DTYPE * dev_minArr;
    unsigned int * dev_nCells;
    unsigned int * dev_nNonEmptyCells;
    unsigned int * dev_gridCellNDMask;
    unsigned int * dev_gridCellNDMaskOffsets;

    unsigned int * originPointIndex;
    unsigned int * dev_originPointIndex;

    double tStartSort = omp_get_wtime();
    sortByWorkLoad(searchMode, &DBSIZE, &epsilon, &dev_epsilon, database, &dev_database, index, &dev_index, indexLookupArr, &dev_indexLookupArr,
            gridCellLookupArr, &dev_gridCellLookupArr, minArr, &dev_minArr, nCells, &dev_nCells, &nNonEmptyCells, &dev_nNonEmptyCells,
            gridCellNDMask, &dev_gridCellNDMask, gridCellNDMaskOffsets, &dev_gridCellNDMaskOffsets, nNDMaskElems, &originPointIndex, &dev_originPointIndex,
            nullptr);
    double tEndSort = omp_get_wtime();
    double sortTime = tEndSort - tStartSort;

    uint64_t totalNeighbors = 0;
    uint64_t totalNeighborsCPU = 0;

    omp_set_nested(1);
	omp_set_dynamic(0);

    double gpuTime = 0.0;
    double egoTime = 0.0;
    double egoReorder = 0.0;
    double egoSort = 0.0;

    double tStart = omp_get_wtime();
    #pragma omp parallel num_threads(2)
    {
        int tid = omp_get_thread_num();

        if(0 == tid) // GPU part
        {
            double tBeginGPU = omp_get_wtime();
            distanceTableNDGridBatches(searchMode, &DBSIZE, &epsilon, dev_epsilon, database, dev_database, index, dev_index,
                    indexLookupArr, dev_indexLookupArr, gridCellLookupArr, dev_gridCellLookupArr, minArr, dev_minArr, nCells, dev_nCells,
                    &nNonEmptyCells, dev_nNonEmptyCells, gridCellNDMask, dev_gridCellNDMask, gridCellNDMaskOffsets, dev_gridCellNDMaskOffsets,
                    nNDMaskElems, originPointIndex, dev_originPointIndex, neighborTable, &pointersToNeighbors, &totalNeighbors);
            double tEndGPU = omp_get_wtime();
            gpuTime = tEndGPU - tBeginGPU;
        }
        else // Super-EGO part
        {
            if(searchMode != SM_GPU)
            {
                unsigned int A_sz = DBSIZE;
                unsigned int B_sz = DBSIZE;

                double tBeginEgo = omp_get_wtime();

                printf("[EGO] ~ Reordering the dimensions\n");
                double tStartReorder = omp_get_wtime();
                Util::reorderDim(A, A_sz, B, B_sz);
                double tEndReorder = omp_get_wtime();
                egoReorder = tEndReorder - tStartReorder;

                printf("[EGO] ~ EGO sorting of A\n");
                double tStartEGOSort = omp_get_wtime();
                // std::sort(sortedDatabaseTmp, sortedDatabaseTmp + (*nNonEmptyCells),
                //         [](const schedulingCell& a, const schedulingCell& b){ return a.nbPoints > b.nbPoints; });
                // auto egoSortLamba = [](const void * v1, const void * v2) -> int
                // {
                //     pPoint p1 = (pPoint)v1;
                // 	pPoint p2 = (pPoint)v2;
                //
                // 	for (int i = 0; i < GPUNUMDIM; i++)
                // 	{
                // 		int d = ((int) (p1->x[i]/Util::eps)) - ((int) (p2->x[i]/Util::eps));
                //
                // 		if (d != 0)
                // 			return d;
                // 	}
                //
                // 	return 0;
                // }
                // std::sort(A, A + A_sz, egoSortLamba);
                qsort(A, A_sz, sizeof(Point), pcmp);
                double tEndEGOSort = omp_get_wtime();
                egoSort = tEndEGOSort - tStartEGOSort;

                unsigned int * egoMapping = new unsigned int[DBSIZE];
                for(int i = 0; i < DBSIZE; ++i)
                {
                    pPoint p = &A[i];
                    egoMapping[p->id] = i;
                }

                totalNeighborsCPU = Util::multiThreadJoinWorkQueue(A, A_sz, B, B_sz, CPU_THREADS, egoMapping);

                double tEndEgo = omp_get_wtime();
                egoTime = tEndEgo - tBeginEgo;

                delete[] A;

            } // searchMode
        } // Super-EGO
    } // parallel section
    double tEnd = omp_get_wtime();

    printf("[RESULT] ~ Total result set size: %lu\n", totalNeighbors + totalNeighborsCPU);
    printf("   [RESULT] ~ Total result set size on the GPU: %lu\n", totalNeighbors);
    printf("   [RESULT] ~ Total result set size on the CPU: %lu\n", totalNeighborsCPU);

    printf("[RESULT] ~ Total execution time: %f\n", (tEnd - tStart) + sortTime);
    printf("   [RESULT] ~ Total execution time for the GPU: %f\n", gpuTime);
    printf("   [RESULT] ~ Total execution time for the CPU: %f (Reorder: %f, sort: %f)\n", egoTime, egoReorder, egoSort);

    if(egoTime < gpuTime)
    {
        printf("[RESULT] ~ The CPU ended before the GPU, with a difference of: %f\n", gpuTime - egoTime);
    }else{
        printf("[RESULT] ~ The GPU ended before the CPU, with a difference of: %f\n", egoTime - gpuTime);
    }

    NDdataPoints.clear();
    NDdataPoints.shrink_to_fit();
    pointersToNeighbors.clear();
    pointersToNeighbors.shrink_to_fit();

    delete[] minArr;
    delete[] maxArr;
    delete[] nCells;
    delete nNDMaskElems;
    delete[] gridCellNDMaskOffsets;
    delete[] indexLookupArr;
    delete[] neighborTable;
    delete[] database;

    cudaFree(dev_epsilon);
    cudaFree(dev_database);
    cudaFree(dev_index);
    cudaFree(dev_indexLookupArr);
    cudaFree(dev_gridCellLookupArr);
    cudaFree(dev_minArr);
    cudaFree(dev_nCells);
    cudaFree(dev_nNonEmptyCells);
    cudaFree(dev_gridCellNDMask);
    cudaFree(dev_gridCellNDMaskOffsets);

    delete[] originPointIndex;
    cudaFree(dev_originPointIndex);

    return 0;
}


void generateNDGridDimensions(
        std::vector< std::vector <DTYPE> > * NDdataPoints,
        DTYPE epsilon,
        DTYPE* minArr,
        DTYPE* maxArr,
        unsigned int * nCells,
        uint64_t * totalCells)
{

    printf("\n\n*****************************  Generating grid dimensions  *****************************\n");

    printf("\nNumber of dimensions data: %d, Number of dimensions indexed: %d", GPUNUMDIM, NUMINDEXEDDIM);

    //make the min/max values for each grid dimension the first data element
    for(int j = 0; j < NUMINDEXEDDIM; j++)
    {
        minArr[j] = (*NDdataPoints)[0][j];
        maxArr[j] = (*NDdataPoints)[0][j];
    }



    for(int i = 1; i < NDdataPoints->size(); ++i)
    {
        for(int j = 0; j < NUMINDEXEDDIM; j++)
        {
            if ((*NDdataPoints)[i][j] < minArr[j])
            {
                minArr[j] = (*NDdataPoints)[i][j];
            }
            if((*NDdataPoints)[i][j] > maxArr[j])
            {
                maxArr[j] = (*NDdataPoints)[i][j];
            }
        }
    }

    printf("\n");
    for(int j = 0; j < NUMINDEXEDDIM; j++)
    {
        printf("Data Dim: %d, min/max: %f, %f\n", j, minArr[j], maxArr[j]);
    }

    //add buffer around each dim so no weirdness later with putting data into cells
    for(int j = 0; j < NUMINDEXEDDIM; j++)
    {
        minArr[j] -= epsilon;
        maxArr[j] += epsilon;
    }

    for(int j = 0; j < NUMINDEXEDDIM; j++)
    {
        printf("Appended by epsilon Dim: %d, min/max: %f, %f\n", j, minArr[j], maxArr[j]);
    }

    //calculate the number of cells:
    for(int j = 0; j < NUMINDEXEDDIM; j++)
    {
        nCells[j] = ceil((maxArr[j] - minArr[j]) / epsilon);
        printf("Number of cells dim: %d: %d\n", j, nCells[j]);
    }

    //calc total cells: num cells in each dim multiplied
    uint64_t tmpTotalCells = nCells[0];
    for(int j = 1; j < NUMINDEXEDDIM; j++)
    {
        tmpTotalCells *= nCells[j];
    }

    *totalCells = tmpTotalCells;

}


struct cmpStruct
{
    cmpStruct(std::vector< std::vector<DTYPE> > points) {this->points = points;}
    bool operator() (int a, int b)
    {
        return points[a][0] < points[b][0];
    }

    std::vector< std::vector<DTYPE> > points;
};


void populateNDGridIndexAndLookupArray(
        std::vector<std::vector <DTYPE> > * NDdataPoints,
        DTYPE epsilon,
        struct gridCellLookup ** gridCellLookupArr,
        struct grid ** index,
        unsigned int * indexLookupArr,
        DTYPE* minArr,
        unsigned int * nCells,
        uint64_t totalCells,
        unsigned int * nNonEmptyCells,
        unsigned int ** gridCellNDMask,
        unsigned int * gridCellNDMaskOffsets,
        unsigned int * nNDMaskElems)
{

    /////////////////////////////////
    // Populate grid lookup array
    // and corresponding indicies in the lookup array
    /////////////////////////////////
    printf("\n\n*****************************  Populating Grid Index and lookup array  *****************************\n");
    // printf("\nSize of dataset: %lu", NDdataPoints->size());


    ///////////////////////////////
    // First, we need to figure out how many non-empty cells there will be
    // For memory allocation
    // Need to do a scan of the dataset and calculate this
    // Also need to keep track of the list of uniquie linear grid cell IDs for inserting into the grid
    ///////////////////////////////
    std::set<uint64_t> uniqueGridCellLinearIds;
    std::vector<uint64_t>uniqueGridCellLinearIdsVect; //for random access

    for (int i = 0; i < NDdataPoints->size(); ++i)
    {
        unsigned int tmpNDCellIdx[NUMINDEXEDDIM];
        for (int j = 0; j < NUMINDEXEDDIM; j++)
        {
            tmpNDCellIdx[j] = (((*NDdataPoints)[i][j] - minArr[j]) / epsilon);
        }
        uint64_t linearID = getLinearID_nDimensions(tmpNDCellIdx, nCells, NUMINDEXEDDIM);
        uniqueGridCellLinearIds.insert(linearID);

    }

    // printf("uniqueGridCellLinearIds: %d",uniqueGridCellLinearIds.size());

    //copy the set to the vector (sets can't do binary searches -- no random access)
    std::copy(uniqueGridCellLinearIds.begin(), uniqueGridCellLinearIds.end(), std::back_inserter(uniqueGridCellLinearIdsVect));


    ///////////////////////////////////////////////


    std::vector<uint64_t> * gridElemIDs;
    gridElemIDs = new std::vector<uint64_t>[uniqueGridCellLinearIds.size()];

    //Create ND array mask:
    //This mask determines which cells in each dimension has points in them.
    std::set<unsigned int> NDArrMask[NUMINDEXEDDIM];

    std::vector<uint64_t>::iterator lower;


    for (int i = 0; i < NDdataPoints->size(); i++)
    {
        unsigned int tmpNDCellID[NUMINDEXEDDIM];
        for (int j = 0; j < NUMINDEXEDDIM; j++)
        {
            tmpNDCellID[j] = (((*NDdataPoints)[i][j] - minArr[j]) / epsilon);

            //add value to the ND array mask
            NDArrMask[j].insert(tmpNDCellID[j]);
        }

        //get the linear id of the cell
        uint64_t linearID = getLinearID_nDimensions(tmpNDCellID, nCells, NUMINDEXEDDIM);
        //printf("\nlinear id: %d",linearID);
        //if (linearID > totalCells){

        //	printf("\n\nERROR Linear ID is: %lu, total cells is only: %lu\n\n", linearID, totalCells);
        //}

        //find the index in gridElemIds that corresponds to this grid cell linear id

        lower = std::lower_bound(uniqueGridCellLinearIdsVect.begin(), uniqueGridCellLinearIdsVect.end(), linearID);
        uint64_t gridIdx = lower - uniqueGridCellLinearIdsVect.begin();
        gridElemIDs[gridIdx].push_back(i);
    }




    ///////////////////////////////
    //Here we fill a temporary index with points, and then copy the non-empty cells to the actual index
    ///////////////////////////////

    struct grid * tmpIndex = new grid[uniqueGridCellLinearIdsVect.size()];

    int cnt = 0;



    //populate temp index and lookup array

    for (int i = 0; i < uniqueGridCellLinearIdsVect.size(); i++)
    {
        tmpIndex[i].indexmin = cnt;
        for (int j = 0; j < gridElemIDs[i].size(); j++)
        {
            if ((NDdataPoints->size() - 1) < j)
            {
                printf("\n\n***ERROR Value of a data point is larger than the dataset! %d\n\n", j);
                return;
            }
            indexLookupArr[cnt] = gridElemIDs[i][j];
            cnt++;
        }
        tmpIndex[i].indexmax = cnt - 1;
    }

    // printf("\nExiting grid populate method early!");
    // return;

    printf("\nFull cells: %d (%f, fraction full)", (unsigned int)uniqueGridCellLinearIdsVect.size(), uniqueGridCellLinearIdsVect.size() * 1.0 / double(totalCells));
    printf("\nEmpty cells: %ld (%f, fraction empty)", totalCells - (unsigned int)uniqueGridCellLinearIdsVect.size(), (totalCells - uniqueGridCellLinearIdsVect.size() * 1.0) / double(totalCells));

    *nNonEmptyCells = uniqueGridCellLinearIdsVect.size();


    printf("\nSize of index that would be sent to GPU (GiB) -- (if full index sent), excluding the data lookup arr: %f", (double)sizeof(struct grid) * (totalCells) / (1024.0 * 1024.0 * 1024.0));
    printf("\nSize of compressed index to be sent to GPU (GiB) , excluding the data and grid lookup arr: %f", (double)sizeof(struct grid) * (uniqueGridCellLinearIdsVect.size() * 1.0) / (1024.0 * 1024.0 * 1024.0));


    /////////////////////////////////////////
    //copy the tmp index into the actual index that only has the non-empty cells

    //allocate memory for the index that will be sent to the GPU
    *index = new grid[uniqueGridCellLinearIdsVect.size()];
    *gridCellLookupArr = new struct gridCellLookup[uniqueGridCellLinearIdsVect.size()];

    cmpStruct theStruct(*NDdataPoints);

    for (int i = 0; i < uniqueGridCellLinearIdsVect.size(); i++)
    {
        (*index)[i].indexmin = tmpIndex[i].indexmin;
        (*index)[i].indexmax = tmpIndex[i].indexmax;
        (*gridCellLookupArr)[i].idx = i;
        (*gridCellLookupArr)[i].gridLinearID = uniqueGridCellLinearIdsVect[i];
    }

    printf("\nWhen copying from entire index to compressed index: number of non-empty cells: %lu", uniqueGridCellLinearIdsVect.size());

    //copy NDArrMask from set to an array

    //find the total size and allocate the array

    unsigned int cntNDOffsets = 0;
    unsigned int cntNonEmptyNDMask = 0;
    for (int i = 0; i < NUMINDEXEDDIM; i++)
    {
        cntNonEmptyNDMask += NDArrMask[i].size();
    }
    *gridCellNDMask = new unsigned int[cntNonEmptyNDMask];

    *nNDMaskElems = cntNonEmptyNDMask;


    //copy the offsets to the array
    for (int i = 0; i < NUMINDEXEDDIM; i++)
    {
        //Min
        gridCellNDMaskOffsets[(i * 2)] = cntNDOffsets;
        for (std::set<unsigned int>::iterator it = NDArrMask[i].begin(); it != NDArrMask[i].end(); ++it)
        {
            (*gridCellNDMask)[cntNDOffsets] = *it;
            cntNDOffsets++;
        }
        //max
        gridCellNDMaskOffsets[(i * 2) + 1]  =cntNDOffsets - 1;
    }

    delete [] tmpIndex;
}


uint64_t getLinearID_nDimensions(
        unsigned int * indexes,
        unsigned int * dimLen,
        unsigned int nDimensions)
{
    uint64_t index = 0;
    uint64_t multiplier = 1;
    for (int i = 0; i < nDimensions; i++)
    {
        index += (uint64_t)indexes[i] * multiplier;
        multiplier *= dimLen[i];
    }

    return index;
}
