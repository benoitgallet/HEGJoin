#ifndef WORK_QUEUE_H
#define WORK_QUEUE_H

#include <utility>

std::pair<unsigned int, unsigned int> getBatchFromQueue(
        unsigned int DBSIZE,
        unsigned int batchSize);

std::pair<unsigned int, unsigned int> getBatchFromQueueCPU(
        unsigned int DBSIZE,
        unsigned int batchSize);

void setQueueIndex(unsigned int index);

void setQueueIndexCPU(unsigned int index);

void displayIndexes();

void setWorkQueueReady();

bool getWorkQueueReady();

void setMaxNeighbors(unsigned int maxNeighbors);

unsigned int getMaxNeighbors();

#endif
