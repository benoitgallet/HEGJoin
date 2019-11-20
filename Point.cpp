//Copyright (c) 2013, Dmitri V. Kalashnikov. All rights reserved.
//This copyright notice should remain at the top of this file.
//

#include "Point.hpp"

#include "params.h"

REAL Point::eps;

//-------------------------------------------
Point::Point()
{
    ;
	//relPoint = new DynArray<Point*>;
}

//-------------------------------------------
/*void Point::print()
{
	printf("[");

	for (int i = 0; i < NUM_DIM; i++)
		printf("%f, ", x[i]);

	printf("]");
} */

//-------------------------------------------
/*void Point::print2()
{
	print();

	printf(" -> ");

	for (int i = 0; i < relPoint->cur_sz; i++)
	{
		relPoint->arr[i]->print();
	}
} */

//-------------------------------------------
bool Point::operator<(Point const &p)
{
	// for (int i = 0; i < GPUNUMDIM; i++)
	// {
	// 	if ( (int) (x[i] / eps) < (int)(p.x[i] / eps) ) return true;
	// 	if ( (int) (x[i] / eps) > (int)(p.x[i] / eps) ) return false;
	// }
    //
	// return false;
    for (int i = 0; i < GPUNUMDIM; i++)
	{
		int d = ((int) (x[i] / eps)) - ((int) (p.x[i] / eps));

		if (d != 0)
			return d;
	}

	return 0;
}

//-------------------------------------------
bool Point::operator<=(Point const &p)
{
	for (int i = 0; i < GPUNUMDIM; i++)
	{
		if ( (int) (x[i] / eps) < (int)(p.x[i] / eps) ) return true;
		if ( (int) (x[i] / eps) > (int)(p.x[i] / eps) ) return false;
	}

	return true;
}
