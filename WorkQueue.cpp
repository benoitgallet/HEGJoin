#include <utility>
#include <stdio.h>

#include "WorkQueue.h"

// template <typename T>
// inline T min(T a, T b)
// {
//     return (a < b) ? a : b;
// }
//
// // template <typename T>
// // inline T max(T a, T b)
// // {
// //     return (a > b) ? a : b;
// // }
// unsigned int max(unsigned int a, unsigned int b)
// {
//     // return (a > b) ? a : b;
//     if(a < b)
//     {
//         return b;
//     }
//     return a;
// }

unsigned int queueIndex = 0;
unsigned int queueIndexCPU = 0;

bool gpuOffset = false;

std::pair<unsigned int, unsigned int> getBatchFromQueue(
    unsigned int DBSIZE,
    unsigned int batchSize)
{
    unsigned int begin, end;
    if(gpuOffset)
    {
        #pragma omp critical
        {
            if(queueIndex < DBSIZE && queueIndex < queueIndexCPU && queueIndex != queueIndexCPU)
            {
                begin = queueIndex;
                end = min(begin + batchSize, queueIndexCPU);
                queueIndex = end;
            }else{
                begin = 0;
                end = 0;
                queueIndex = DBSIZE;
            }
        }
    }else{
        begin = 1;
        end = 0;
    }
    return std::make_pair(begin, end);
}

std::pair<unsigned int, unsigned int> getBatchFromQueueCPU(
    unsigned int DBSIZE,
    unsigned int batchSize)
{
    unsigned int begin, end;
    if(gpuOffset)
    {
        #pragma omp critical
        {
            if(0 < queueIndexCPU && queueIndex < queueIndexCPU && queueIndex != queueIndexCPU)
            {
                begin = max(queueIndex, queueIndexCPU - batchSize);
                end = queueIndexCPU;
                queueIndexCPU = begin;
                displayIndexes();
            }else{
                begin = 0;
                end = 0;
                queueIndexCPU = 0;
            }
        }
    }else{
        begin = 1;
        end = 0;
    }
    return std::make_pair(begin, end);
}

void setQueueIndex(unsigned int index)
{
    queueIndex = index;
    gpuOffset = true;
}

void setQueueIndexCPU(unsigned int index)
{
    queueIndexCPU = index;
}

void displayIndexes()
{
    printf("[QUEUE] ~ GPU index: %d, CPU index: %d\n", queueIndex, queueIndexCPU);
}
