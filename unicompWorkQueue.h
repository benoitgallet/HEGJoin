if(nDCellIDs[0] & 1) {
    for(loopRng[0] = nDMinCellIDs[0]; loopRng[0] <= nDMaxCellIDs[0]; loopRng[0]++) {
        if(loopRng[0] != nDCellIDs[0])
        {
            indexes[0] = loopRng[0];
            for(int i = 1; i < NUMINDEXEDDIM; i++)
            {
                indexes[i] = nDCellIDs[i];
            }
            evaluateCell(nCells, indexes, gridCellLookupArr, nNonEmptyCells, database, epsilon, index,
                indexLookupArr, point, cnt, pointIDKey, pointInDistVal, originPointIndex[pointId], true, nDCellIDs);
        }
    }
}
#if NUMINDEXEDDIM >= 2
if(nDCellIDs[1] & 1) {
    for(loopRng[0] = nDMinCellIDs[0]; loopRng[0] <= nDMaxCellIDs[0]; loopRng[0]++)
    for(loopRng[1] = nDMinCellIDs[1]; loopRng[1] <= nDMaxCellIDs[1]; loopRng[1]++) {
        if(loopRng[1] != nDCellIDs[1])
        {
            indexes[0] = loopRng[0];
            indexes[1] = loopRng[1];
            for(int i = 2; i < NUMINDEXEDDIM; i++)
            {
                indexes[i] = nDCellIDs[i];
            }
            evaluateCell(nCells, indexes, gridCellLookupArr, nNonEmptyCells, database, epsilon, index,
                indexLookupArr, point, cnt, pointIDKey, pointInDistVal, originPointIndex[pointId], true, nDCellIDs);
        }
    }
}
#endif
#if NUMINDEXEDDIM >= 3
if(nDCellIDs[2] & 1) {
    for(loopRng[0] = nDMinCellIDs[0]; loopRng[0] <= nDMaxCellIDs[0]; loopRng[0]++)
    for(loopRng[1] = nDMinCellIDs[1]; loopRng[1] <= nDMaxCellIDs[1]; loopRng[1]++)
    for(loopRng[2] = nDMinCellIDs[2]; loopRng[2] <= nDMaxCellIDs[2]; loopRng[2]++) {
        if(loopRng[2] != nDCellIDs[2])
        {
            indexes[0] = loopRng[0];
            indexes[1] = loopRng[1];
            indexes[2] = loopRng[2];
            for(int i = 3; i < NUMINDEXEDDIM; i++)
            {
                indexes[i] = nDCellIDs[i];
            }
            evaluateCell(nCells, indexes, gridCellLookupArr, nNonEmptyCells, database, epsilon, index,
                indexLookupArr, point, cnt, pointIDKey, pointInDistVal, originPointIndex[pointId], true, nDCellIDs);
        }
    }
}
#endif
#if NUMINDEXEDDIM >= 4
if(nDCellIDs[3] & 1) {
    for(loopRng[0] = nDMinCellIDs[0]; loopRng[0] <= nDMaxCellIDs[0]; loopRng[0]++)
    for(loopRng[1] = nDMinCellIDs[1]; loopRng[1] <= nDMaxCellIDs[1]; loopRng[1]++)
    for(loopRng[2] = nDMinCellIDs[2]; loopRng[2] <= nDMaxCellIDs[2]; loopRng[2]++)
    for(loopRng[3] = nDMinCellIDs[3]; loopRng[3] <= nDMaxCellIDs[3]; loopRng[3]++) {
        if(loopRng[3] != nDCellIDs[3])
        {
            indexes[0] = loopRng[0];
            indexes[1] = loopRng[1];
            indexes[2] = loopRng[2];
            indexes[3] = loopRng[3];
            for(int i = 4; i < NUMINDEXEDDIM; i++)
            {
                indexes[i] = nDCellIDs[i];
            }
            evaluateCell(nCells, indexes, gridCellLookupArr, nNonEmptyCells, database, epsilon, index,
                indexLookupArr, point, cnt, pointIDKey, pointInDistVal, originPointIndex[pointId], true, nDCellIDs);
        }
    }
}
#endif
#if NUMINDEXEDDIM >= 5
if(nDCellIDs[4] & 1) {
    for(loopRng[0] = nDMinCellIDs[0]; loopRng[0] <= nDMaxCellIDs[0]; loopRng[0]++)
    for(loopRng[1] = nDMinCellIDs[1]; loopRng[1] <= nDMaxCellIDs[1]; loopRng[1]++)
    for(loopRng[2] = nDMinCellIDs[2]; loopRng[2] <= nDMaxCellIDs[2]; loopRng[2]++)
    for(loopRng[3] = nDMinCellIDs[3]; loopRng[3] <= nDMaxCellIDs[3]; loopRng[3]++)
    for(loopRng[4] = nDMinCellIDs[4]; loopRng[4] <= nDMaxCellIDs[4]; loopRng[4]++) {
        if(loopRng[4] != nDCellIDs[4])
        {
            indexes[0] = loopRng[0];
            indexes[1] = loopRng[1];
            indexes[2] = loopRng[2];
            indexes[3] = loopRng[3];
            indexes[4] = loopRng[4];
            for(int i = 5; i < NUMINDEXEDDIM; i++)
            {
                indexes[i] = nDCellIDs[i];
            }
            evaluateCell(nCells, indexes, gridCellLookupArr, nNonEmptyCells, database, epsilon, index,
                indexLookupArr, point, cnt, pointIDKey, pointInDistVal, originPointIndex[pointId], true, nDCellIDs);
        }
    }
}
#endif
#if NUMINDEXEDDIM >= 6
if(nDCellIDs[5] & 1) {
    for(loopRng[0] = nDMinCellIDs[0]; loopRng[0] <= nDMaxCellIDs[0]; loopRng[0]++)
    for(loopRng[1] = nDMinCellIDs[1]; loopRng[1] <= nDMaxCellIDs[1]; loopRng[1]++)
    for(loopRng[2] = nDMinCellIDs[2]; loopRng[2] <= nDMaxCellIDs[2]; loopRng[2]++)
    for(loopRng[3] = nDMinCellIDs[3]; loopRng[3] <= nDMaxCellIDs[3]; loopRng[3]++)
    for(loopRng[4] = nDMinCellIDs[4]; loopRng[4] <= nDMaxCellIDs[4]; loopRng[4]++)
    for(loopRng[5] = nDMinCellIDs[5]; loopRng[5] <= nDMaxCellIDs[5]; loopRng[5]++) {
        if(loopRng[5] != nDCellIDs[5])
        {
            indexes[0] = loopRng[0];
            indexes[1] = loopRng[1];
            indexes[2] = loopRng[2];
            indexes[3] = loopRng[3];
            indexes[4] = loopRng[4];
            indexes[5] = loopRng[5];
            for(int i = 6; i < NUMINDEXEDDIM; i++)
            {
                indexes[i] = nDCellIDs[i];
            }
            evaluateCell(nCells, indexes, gridCellLookupArr, nNonEmptyCells, database, epsilon, index,
                indexLookupArr, point, cnt, pointIDKey, pointInDistVal, originPointIndex[pointId], true, nDCellIDs);
        }
    }
}
#endif
#if NUMINDEXEDDIM >= 7
if(nDCellIDs[6] & 1) {
    for(loopRng[0] = nDMinCellIDs[0]; loopRng[0] <= nDMaxCellIDs[0]; loopRng[0]++)
    for(loopRng[1] = nDMinCellIDs[1]; loopRng[1] <= nDMaxCellIDs[1]; loopRng[1]++)
    for(loopRng[2] = nDMinCellIDs[2]; loopRng[2] <= nDMaxCellIDs[2]; loopRng[2]++)
    for(loopRng[3] = nDMinCellIDs[3]; loopRng[3] <= nDMaxCellIDs[3]; loopRng[3]++)
    for(loopRng[4] = nDMinCellIDs[4]; loopRng[4] <= nDMaxCellIDs[4]; loopRng[4]++)
    for(loopRng[5] = nDMinCellIDs[5]; loopRng[5] <= nDMaxCellIDs[5]; loopRng[5]++)
    for(loopRng[6] = nDMinCellIDs[6]; loopRng[6] <= nDMaxCellIDs[6]; loopRng[6]++) {
        if(loopRng[6] != nDCellIDs[6])
        {
            indexes[0] = loopRng[0];
            indexes[1] = loopRng[1];
            indexes[2] = loopRng[2];
            indexes[3] = loopRng[3];
            indexes[4] = loopRng[4];
            indexes[5] = loopRng[5];
            indexes[6] = loopRng[6];
            for(int i = 7; i < NUMINDEXEDDIM; i++)
            {
                indexes[i] = nDCellIDs[i];
            }
            evaluateCell(nCells, indexes, gridCellLookupArr, nNonEmptyCells, database, epsilon, index,
                indexLookupArr, point, cnt, pointIDKey, pointInDistVal, originPointIndex[pointId], true, nDCellIDs);
        }
    }
}
#endif
#if NUMINDEXEDDIM >= 8
if(nDCellIDs[7] & 1) {
    for(loopRng[0] = nDMinCellIDs[0]; loopRng[0] <= nDMaxCellIDs[0]; loopRng[0]++)
    for(loopRng[1] = nDMinCellIDs[1]; loopRng[1] <= nDMaxCellIDs[1]; loopRng[1]++)
    for(loopRng[2] = nDMinCellIDs[2]; loopRng[2] <= nDMaxCellIDs[2]; loopRng[2]++)
    for(loopRng[3] = nDMinCellIDs[3]; loopRng[3] <= nDMaxCellIDs[3]; loopRng[3]++)
    for(loopRng[4] = nDMinCellIDs[4]; loopRng[4] <= nDMaxCellIDs[4]; loopRng[4]++)
    for(loopRng[5] = nDMinCellIDs[5]; loopRng[5] <= nDMaxCellIDs[5]; loopRng[5]++)
    for(loopRng[6] = nDMinCellIDs[6]; loopRng[6] <= nDMaxCellIDs[6]; loopRng[6]++)
    for(loopRng[7] = nDMinCellIDs[7]; loopRng[7] <= nDMaxCellIDs[7]; loopRng[7]++) {
        if(loopRng[7] != nDCellIDs[7])
        {
            for(int i = 0; i < 8; i++)
            {
                indexes[i] = loopRng[i];
            }
            for(int i = 8; i < NUMINDEXEDDIM; i++)
            {
                indexes[i] = nDCellIDs[i];
            }
            evaluateCell(nCells, indexes, gridCellLookupArr, nNonEmptyCells, database, epsilon, index,
                indexLookupArr, point, cnt, pointIDKey, pointInDistVal, originPointIndex[pointId], true, nDCellIDs);
        }
    }
}
#endif
#if NUMINDEXEDDIM >= 9
if(nDCellIDs[8] & 1) {
    for(loopRng[0] = nDMinCellIDs[0]; loopRng[0] <= nDMaxCellIDs[0]; loopRng[0]++)
    for(loopRng[1] = nDMinCellIDs[1]; loopRng[1] <= nDMaxCellIDs[1]; loopRng[1]++)
    for(loopRng[2] = nDMinCellIDs[2]; loopRng[2] <= nDMaxCellIDs[2]; loopRng[2]++)
    for(loopRng[3] = nDMinCellIDs[3]; loopRng[3] <= nDMaxCellIDs[3]; loopRng[3]++)
    for(loopRng[4] = nDMinCellIDs[4]; loopRng[4] <= nDMaxCellIDs[4]; loopRng[4]++)
    for(loopRng[5] = nDMinCellIDs[5]; loopRng[5] <= nDMaxCellIDs[5]; loopRng[5]++)
    for(loopRng[6] = nDMinCellIDs[6]; loopRng[6] <= nDMaxCellIDs[6]; loopRng[6]++)
    for(loopRng[7] = nDMinCellIDs[7]; loopRng[7] <= nDMaxCellIDs[7]; loopRng[7]++)
    for(loopRng[8] = nDMinCellIDs[8]; loopRng[8] <= nDMaxCellIDs[8]; loopRng[8]++) {
        if(loopRng[8] != nDCellIDs[8])
        {
            for(int i = 0; i < 9; i++)
            {
                indexes[i] = loopRng[i];
            }
            for(int i = 9; i < NUMINDEXEDDIM; i++)
            {
                indexes[i] = nDCellIDs[i];
            }
            evaluateCell(nCells, indexes, gridCellLookupArr, nNonEmptyCells, database, epsilon, index,
                indexLookupArr, point, cnt, pointIDKey, pointInDistVal, originPointIndex[pointId], true, nDCellIDs);
        }
    }
}
#endif
#if NUMINDEXEDDIM >= 10
if(nDCellIDs[9] & 1) {
    for(loopRng[0] = nDMinCellIDs[0]; loopRng[0] <= nDMaxCellIDs[0]; loopRng[0]++)
    for(loopRng[1] = nDMinCellIDs[1]; loopRng[1] <= nDMaxCellIDs[1]; loopRng[1]++)
    for(loopRng[2] = nDMinCellIDs[2]; loopRng[2] <= nDMaxCellIDs[2]; loopRng[2]++)
    for(loopRng[3] = nDMinCellIDs[3]; loopRng[3] <= nDMaxCellIDs[3]; loopRng[3]++)
    for(loopRng[4] = nDMinCellIDs[4]; loopRng[4] <= nDMaxCellIDs[4]; loopRng[4]++)
    for(loopRng[5] = nDMinCellIDs[5]; loopRng[5] <= nDMaxCellIDs[5]; loopRng[5]++)
    for(loopRng[6] = nDMinCellIDs[6]; loopRng[6] <= nDMaxCellIDs[6]; loopRng[6]++)
    for(loopRng[7] = nDMinCellIDs[7]; loopRng[7] <= nDMaxCellIDs[7]; loopRng[7]++)
    for(loopRng[8] = nDMinCellIDs[8]; loopRng[8] <= nDMaxCellIDs[8]; loopRng[8]++)
    for(loopRng[9] = nDMinCellIDs[9]; loopRng[9] <= nDMaxCellIDs[9]; loopRng[9]++) {
        if(loopRng[9] != nDCellIDs[9])
        {
            for(int i = 0; i < 10; i++)
            {
                indexes[i] = loopRng[i];
            }
            for(int i = 10; i < NUMINDEXEDDIM; i++)
            {
                indexes[i] = nDCellIDs[i];
            }
            evaluateCell(nCells, indexes, gridCellLookupArr, nNonEmptyCells, database, epsilon, index,
                indexLookupArr, point, cnt, pointIDKey, pointInDistVal, originPointIndex[pointId], true, nDCellIDs);
        }
    }
}
#endif
