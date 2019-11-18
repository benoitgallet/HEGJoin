//Copyright (c) 2013, Dmitri V. Kalashnikov. All rights reserved.
//This copyright notice should remain at the top of this file.
//

#ifndef UTIL_HPP
#define UTIL_HPP

#include <vector>
#include <stdlib.h>
#include <unistd.h>

#include "params.h"

#define U_QUIT  -1
#define U_OK     1

class CellRect;
int pcmp(const void *v1, const void *v2);

class Util
{
public:
	//-- EGO --
	static REAL eps;
	static REAL eps2;

    //-- scanning ranges for SimpleJoin--
    static int r1[GPUNUMDIM + 1][2];
    static int r2[GPUNUMDIM + 1][2];
    static int r3[GPUNUMDIM + 1][2];

	//static pPoint A;
	//static pPoint B;

	// static resCont* multiThreadJoin(pPoint A, int A_sz, pPoint B, int B_sz, int num_threads);
	static uint64_t multiThreadJoinWorkQueue(pPoint A, int A_sz, pPoint B, int B_sz, int num_threads, unsigned int * egoMapping);
	// static void egoJoin(pPoint A, int frA, int toA, pPoint B, int frB, int toB, int start_dim, pThreadParam param);
	static uint64_t egoJoinV2(pPoint A, int frA, int toA, pPoint B, int frB, int toB, int start_dim, std::vector<int> * result);
	// static void simpleJoin (pPoint A, int frA, int toA, pPoint B, int frB, int toB, resCont *result);
	static void simpleJoin3(pPoint A, int frA, int toA, pPoint B, int frB, int toB, std::vector<int> * result);
    // static void simpleJoin2(pPoint A, int frA, int toA, pPoint B, int frB, int toB, resCont *result, int i);
	static void simpleJoin4(pPoint A, int frA, int toA, pPoint B, int frB, int toB, int m, std::vector<int> * result);
    static void reorderDim(pPoint A, int A_sz, pPoint B, int B_sz);

	static REAL rnd();
};


#endif
