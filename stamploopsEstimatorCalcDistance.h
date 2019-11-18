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
            unsigned int idx = atomicAdd(cnt, int(2));
        }
    }
}
