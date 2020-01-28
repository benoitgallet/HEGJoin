#ifndef SORT_BY_WORKLOAD_H
#define SORT_BY_WORKLOAD_H

#include "params.h"
#include "structs.h"

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
        unsigned int ** dev_originPointIndex,
        bool * isSortByWLDone,
        int * nbPointsPreComputed);

#endif
