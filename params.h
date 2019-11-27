#ifndef PARAMS_H
#define PARAMS_H

#define GPUNUMDIM 6
#define NUMINDEXEDDIM 6

#define BLOCKSIZE 256

#define GPUSTREAMS 3
#define CPU_THREADS 16

// Number of query points taken by a CPU thread at once
#define CPU_BATCH_SIZE 64

// Note: Super-EGO does not work using double precision
// TODO should merge the two variables together
#define DTYPE double // precision used by the GPU component
#define REAL double  // precision used by Super-EGO

// Used by Super-EGO
#define MINLEN 32

// Cell-access patterns (avoid double distance calculations)
#define UNICOMP 0
#define LID_UNICOMP 0

// Limits the output produced by the GPU when computing
// 0 to limit, 1 to output everything
#define SILENT_GPU 1


/*******************************************************************************/
/*                 Code should not be modified below this line                 */
/*******************************************************************************/


#define NB_ARGS 5
#define FILENAME_ARG 1
// #define DATASETSIZE_ARG 2
#define EPSILON_ARG 2
#define DIM_ARG 3
#define SEARCHMODE_ARG 4

#define SM_GPU 0
#define SM_HYBRID 1
#define SM_CPU 2

#endif
