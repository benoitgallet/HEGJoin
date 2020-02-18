#!/bin/bash

EXPO2D2M="/data/fixed_length_expo_dist/dataset_fixed_len_pts_expo_NDIM_2_pts_2000000.txt"
EXPO3D2M="/data/fixed_length_expo_dist/dataset_fixed_len_pts_expo_NDIM_3_pts_2000000.txt"
EXPO4D2M="/data/fixed_length_expo_dist/dataset_fixed_len_pts_expo_NDIM_4_pts_2000000.txt"
EXPO6D2M="/data/fixed_length_expo_dist/dataset_fixed_len_pts_expo_NDIM_6_pts_2000000.txt"
EXPO8D2M="/data/fixed_length_expo_dist/dataset_fixed_len_pts_expo_NDIM_8_pts_2000000.txt"

sed -i '4s/.*/#define GPUNUMDIM 2/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 2/' params.h

echo '~ Expo2D2M'
sed -i '10s/.*/#define CPU_THREADS 1/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 1 Thread'
echo '## Epsilon 0.0004'
./main $EXPO2D2M 0.0004 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0004 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0004 2 2 | grep "RESULT"
echo '## Epsilon 0.0008'
./main $EXPO2D2M 0.0008 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0008 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0008 2 2 | grep "RESULT"
echo '## Epsilon 0.0012'
./main $EXPO2D2M 0.0012 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0012 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0012 2 2 | grep "RESULT"
echo '## Epsilon 0.0016'
./main $EXPO2D2M 0.0016 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0016 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0016 2 2 | grep "RESULT"
echo '## Epsilon 0.0020'
./main $EXPO2D2M 0.0020 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0020 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0020 2 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 2/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 2 Threads'
echo '## Epsilon 0.0004'
./main $EXPO2D2M 0.0004 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0004 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0004 2 2 | grep "RESULT"
echo '## Epsilon 0.0008'
./main $EXPO2D2M 0.0008 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0008 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0008 2 2 | grep "RESULT"
echo '## Epsilon 0.0012'
./main $EXPO2D2M 0.0012 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0012 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0012 2 2 | grep "RESULT"
echo '## Epsilon 0.0016'
./main $EXPO2D2M 0.0016 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0016 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0016 2 2 | grep "RESULT"
echo '## Epsilon 0.0020'
./main $EXPO2D2M 0.0020 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0020 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0020 2 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 4/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 4 Threads'
echo '## Epsilon 0.0004'
./main $EXPO2D2M 0.0004 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0004 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0004 2 2 | grep "RESULT"
echo '## Epsilon 0.0008'
./main $EXPO2D2M 0.0008 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0008 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0008 2 2 | grep "RESULT"
echo '## Epsilon 0.0012'
./main $EXPO2D2M 0.0012 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0012 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0012 2 2 | grep "RESULT"
echo '## Epsilon 0.0016'
./main $EXPO2D2M 0.0016 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0016 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0016 2 2 | grep "RESULT"
echo '## Epsilon 0.0020'
./main $EXPO2D2M 0.0020 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0020 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0020 2 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 8/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 8 Threads'
echo '## Epsilon 0.0004'
./main $EXPO2D2M 0.0004 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0004 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0004 2 2 | grep "RESULT"
echo '## Epsilon 0.0008'
./main $EXPO2D2M 0.0008 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0008 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0008 2 2 | grep "RESULT"
echo '## Epsilon 0.0012'
./main $EXPO2D2M 0.0012 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0012 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0012 2 2 | grep "RESULT"
echo '## Epsilon 0.0016'
./main $EXPO2D2M 0.0016 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0016 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0016 2 2 | grep "RESULT"
echo '## Epsilon 0.0020'
./main $EXPO2D2M 0.0020 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0020 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0020 2 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 12/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 12 Threads'
echo '## Epsilon 0.0004'
./main $EXPO2D2M 0.0004 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0004 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0004 2 2 | grep "RESULT"
echo '## Epsilon 0.0008'
./main $EXPO2D2M 0.0008 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0008 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0008 2 2 | grep "RESULT"
echo '## Epsilon 0.0012'
./main $EXPO2D2M 0.0012 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0012 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0012 2 2 | grep "RESULT"
echo '## Epsilon 0.0016'
./main $EXPO2D2M 0.0016 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0016 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0016 2 2 | grep "RESULT"
echo '## Epsilon 0.0020'
./main $EXPO2D2M 0.0020 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0020 2 2 | grep "RESULT"
# ./main $EXPO2D2M 0.0020 2 2 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

sed -i '4s/.*/#define GPUNUMDIM 3/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 3/' params.h

echo '~ Expo3D2M'
sed -i '10s/.*/#define CPU_THREADS 1/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 1 Thread'
echo '## Epsilon 0.001'
./main $EXPO3D2M 0.001 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.001 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.001 3 2 | grep "RESULT"
echo '## Epsilon 0.002'
./main $EXPO3D2M 0.002 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.002 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.002 3 2 | grep "RESULT"
echo '## Epsilon 0.003'
./main $EXPO3D2M 0.003 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.003 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.003 3 2 | grep "RESULT"
echo '## Epsilon 0.004'
./main $EXPO3D2M 0.004 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.004 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.004 3 2 | grep "RESULT"
echo '## Epsilon 0.005'
./main $EXPO3D2M 0.005 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.005 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.005 3 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 2/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 2 Threads'
echo '## Epsilon 0.001'
./main $EXPO3D2M 0.001 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.001 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.001 3 2 | grep "RESULT"
echo '## Epsilon 0.002'
./main $EXPO3D2M 0.002 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.002 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.002 3 2 | grep "RESULT"
echo '## Epsilon 0.003'
./main $EXPO3D2M 0.003 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.003 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.003 3 2 | grep "RESULT"
echo '## Epsilon 0.004'
./main $EXPO3D2M 0.004 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.004 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.004 3 2 | grep "RESULT"
echo '## Epsilon 0.005'
./main $EXPO3D2M 0.005 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.005 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.005 3 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 4/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 4 Threads'
echo '## Epsilon 0.001'
./main $EXPO3D2M 0.001 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.001 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.001 3 2 | grep "RESULT"
echo '## Epsilon 0.002'
./main $EXPO3D2M 0.002 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.002 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.002 3 2 | grep "RESULT"
echo '## Epsilon 0.003'
./main $EXPO3D2M 0.003 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.003 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.003 3 2 | grep "RESULT"
echo '## Epsilon 0.004'
./main $EXPO3D2M 0.004 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.004 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.004 3 2 | grep "RESULT"
echo '## Epsilon 0.005'
./main $EXPO3D2M 0.005 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.005 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.005 3 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 8/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 8 Threads'
echo '## Epsilon 0.001'
./main $EXPO3D2M 0.001 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.001 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.001 3 2 | grep "RESULT"
echo '## Epsilon 0.002'
./main $EXPO3D2M 0.002 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.002 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.002 3 2 | grep "RESULT"
echo '## Epsilon 0.003'
./main $EXPO3D2M 0.003 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.003 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.003 3 2 | grep "RESULT"
echo '## Epsilon 0.004'
./main $EXPO3D2M 0.004 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.004 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.004 3 2 | grep "RESULT"
echo '## Epsilon 0.005'
./main $EXPO3D2M 0.005 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.005 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.005 3 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 12/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 12 Threads'
echo '## Epsilon 0.001'
./main $EXPO3D2M 0.001 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.001 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.001 3 2 | grep "RESULT"
echo '## Epsilon 0.002'
./main $EXPO3D2M 0.002 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.002 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.002 3 2 | grep "RESULT"
echo '## Epsilon 0.003'
./main $EXPO3D2M 0.003 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.003 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.003 3 2 | grep "RESULT"
echo '## Epsilon 0.004'
./main $EXPO3D2M 0.004 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.004 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.004 3 2 | grep "RESULT"
echo '## Epsilon 0.005'
./main $EXPO3D2M 0.005 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.005 3 2 | grep "RESULT"
# ./main $EXPO3D2M 0.005 3 2 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

sed -i '4s/.*/#define GPUNUMDIM 4/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 4/' params.h

echo '~ Expo4D2M'
sed -i '10s/.*/#define CPU_THREADS 1/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 1 Thread'
echo '## Epsilon 0.002'
./main $EXPO4D2M 0.002 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.002 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.002 4 2 | grep "RESULT"
echo '## Epsilon 0.004'
./main $EXPO4D2M 0.004 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.004 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.004 4 2 | grep "RESULT"
echo '## Epsilon 0.006'
./main $EXPO4D2M 0.006 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.006 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.006 4 2 | grep "RESULT"
echo '## Epsilon 0.008'
./main $EXPO4D2M 0.008 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.008 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.008 4 2 | grep "RESULT"
echo '## Epsilon 0.010'
./main $EXPO4D2M 0.010 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.010 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.010 4 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 2/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 2 Threads'
echo '## Epsilon 0.002'
./main $EXPO4D2M 0.002 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.002 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.002 4 2 | grep "RESULT"
echo '## Epsilon 0.004'
./main $EXPO4D2M 0.004 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.004 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.004 4 2 | grep "RESULT"
echo '## Epsilon 0.006'
./main $EXPO4D2M 0.006 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.006 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.006 4 2 | grep "RESULT"
echo '## Epsilon 0.008'
./main $EXPO4D2M 0.008 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.008 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.008 4 2 | grep "RESULT"
echo '## Epsilon 0.010'
./main $EXPO4D2M 0.010 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.010 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.010 4 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 4/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 4 Threads'
echo '## Epsilon 0.002'
./main $EXPO4D2M 0.002 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.002 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.002 4 2 | grep "RESULT"
echo '## Epsilon 0.004'
./main $EXPO4D2M 0.004 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.004 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.004 4 2 | grep "RESULT"
echo '## Epsilon 0.006'
./main $EXPO4D2M 0.006 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.006 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.006 4 2 | grep "RESULT"
echo '## Epsilon 0.008'
./main $EXPO4D2M 0.008 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.008 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.008 4 2 | grep "RESULT"
echo '## Epsilon 0.010'
./main $EXPO4D2M 0.010 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.010 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.010 4 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 8/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 8 Threads'
echo '## Epsilon 0.002'
./main $EXPO4D2M 0.002 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.002 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.002 4 2 | grep "RESULT"
echo '## Epsilon 0.004'
./main $EXPO4D2M 0.004 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.004 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.004 4 2 | grep "RESULT"
echo '## Epsilon 0.006'
./main $EXPO4D2M 0.006 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.006 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.006 4 2 | grep "RESULT"
echo '## Epsilon 0.008'
./main $EXPO4D2M 0.008 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.008 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.008 4 2 | grep "RESULT"
echo '## Epsilon 0.010'
./main $EXPO4D2M 0.010 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.010 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.010 4 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 12/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 12 Threads'
echo '## Epsilon 0.002'
./main $EXPO4D2M 0.002 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.002 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.002 4 2 | grep "RESULT"
echo '## Epsilon 0.004'
./main $EXPO4D2M 0.004 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.004 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.004 4 2 | grep "RESULT"
echo '## Epsilon 0.006'
./main $EXPO4D2M 0.006 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.006 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.006 4 2 | grep "RESULT"
echo '## Epsilon 0.008'
./main $EXPO4D2M 0.008 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.008 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.008 4 2 | grep "RESULT"
echo '## Epsilon 0.010'
./main $EXPO4D2M 0.010 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.010 4 2 | grep "RESULT"
# ./main $EXPO4D2M 0.010 4 2 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

sed -i '4s/.*/#define GPUNUMDIM 6/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 6/' params.h

echo '~ Expo6D2M'
sed -i '10s/.*/#define CPU_THREADS 1/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 1 Thread'
echo '## Epsilon 0.003'
./main $EXPO6D2M 0.003 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.003 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.003 6 2 | grep "RESULT"
echo '## Epsilon 0.006'
./main $EXPO6D2M 0.006 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.006 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.006 6 2 | grep "RESULT"
echo '## Epsilon 0.009'
./main $EXPO6D2M 0.009 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.009 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.009 6 2 | grep "RESULT"
echo '## Epsilon 0.012'
./main $EXPO6D2M 0.012 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.012 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.012 6 2 | grep "RESULT"
echo '## Epsilon 0.015'
./main $EXPO6D2M 0.015 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.015 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.015 6 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 2/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 2 Threads'
echo '## Epsilon 0.003'
./main $EXPO6D2M 0.003 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.003 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.003 6 2 | grep "RESULT"
echo '## Epsilon 0.006'
./main $EXPO6D2M 0.006 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.006 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.006 6 2 | grep "RESULT"
echo '## Epsilon 0.009'
./main $EXPO6D2M 0.009 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.009 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.009 6 2 | grep "RESULT"
echo '## Epsilon 0.012'
./main $EXPO6D2M 0.012 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.012 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.012 6 2 | grep "RESULT"
echo '## Epsilon 0.015'
./main $EXPO6D2M 0.015 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.015 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.015 6 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 4/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 4 Threads'
echo '## Epsilon 0.003'
./main $EXPO6D2M 0.003 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.003 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.003 6 2 | grep "RESULT"
echo '## Epsilon 0.006'
./main $EXPO6D2M 0.006 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.006 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.006 6 2 | grep "RESULT"
echo '## Epsilon 0.009'
./main $EXPO6D2M 0.009 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.009 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.009 6 2 | grep "RESULT"
echo '## Epsilon 0.012'
./main $EXPO6D2M 0.012 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.012 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.012 6 2 | grep "RESULT"
echo '## Epsilon 0.015'
./main $EXPO6D2M 0.015 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.015 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.015 6 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 8/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 8 Threads'
echo '## Epsilon 0.003'
./main $EXPO6D2M 0.003 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.003 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.003 6 2 | grep "RESULT"
echo '## Epsilon 0.006'
./main $EXPO6D2M 0.006 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.006 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.006 6 2 | grep "RESULT"
echo '## Epsilon 0.009'
./main $EXPO6D2M 0.009 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.009 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.009 6 2 | grep "RESULT"
echo '## Epsilon 0.012'
./main $EXPO6D2M 0.012 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.012 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.012 6 2 | grep "RESULT"
echo '## Epsilon 0.015'
./main $EXPO6D2M 0.015 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.015 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.015 6 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 12/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 12 Threads'
echo '## Epsilon 0.003'
./main $EXPO6D2M 0.003 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.003 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.003 6 2 | grep "RESULT"
echo '## Epsilon 0.006'
./main $EXPO6D2M 0.006 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.006 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.006 6 2 | grep "RESULT"
echo '## Epsilon 0.009'
./main $EXPO6D2M 0.009 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.009 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.009 6 2 | grep "RESULT"
echo '## Epsilon 0.012'
./main $EXPO6D2M 0.012 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.012 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.012 6 2 | grep "RESULT"
echo '## Epsilon 0.015'
./main $EXPO6D2M 0.015 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.015 6 2 | grep "RESULT"
# ./main $EXPO6D2M 0.015 6 2 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

sed -i '4s/.*/#define GPUNUMDIM 8/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 8/' params.h

echo '~ Expo8D2M'
sed -i '10s/.*/#define CPU_THREADS 1/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 1 Thread'
echo '## Epsilon 0.003'
./main $EXPO8D2M 0.003 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.003 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.003 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.006'
./main $EXPO8D2M 0.006 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.006 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.006 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.009'
./main $EXPO8D2M 0.009 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.009 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.009 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.012'
./main $EXPO8D2M 0.012 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.012 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.012 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.015'
./main $EXPO8D2M 0.015 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.015 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.015 8 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 2/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 2 Threads'
echo '## Epsilon 0.003'
./main $EXPO8D2M 0.003 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.003 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.003 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.006'
./main $EXPO8D2M 0.006 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.006 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.006 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.009'
./main $EXPO8D2M 0.009 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.009 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.009 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.012'
./main $EXPO8D2M 0.012 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.012 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.012 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.015'
./main $EXPO8D2M 0.015 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.015 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.015 8 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 4/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 4 Threads'
echo '## Epsilon 0.003'
./main $EXPO8D2M 0.003 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.003 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.003 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.006'
./main $EXPO8D2M 0.006 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.006 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.006 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.009'
./main $EXPO8D2M 0.009 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.009 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.009 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.012'
./main $EXPO8D2M 0.012 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.012 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.012 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.015'
./main $EXPO8D2M 0.015 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.015 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.015 8 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 8/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 8 Threads'
echo '## Epsilon 0.003'
./main $EXPO8D2M 0.003 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.003 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.003 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.006'
./main $EXPO8D2M 0.006 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.006 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.006 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.009'
./main $EXPO8D2M 0.009 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.009 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.009 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.012'
./main $EXPO8D2M 0.012 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.012 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.012 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.015'
./main $EXPO8D2M 0.015 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.015 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.015 8 2 | grep "RESULT"

echo
echo

sed -i '10s/.*/#define CPU_THREADS 12/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
echo '# 12 Threads'
echo '## Epsilon 0.003'
./main $EXPO8D2M 0.003 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.003 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.003 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.006'
./main $EXPO8D2M 0.006 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.006 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.006 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.009'
./main $EXPO8D2M 0.009 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.009 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.009 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.012'
./main $EXPO8D2M 0.012 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.012 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.012 8 2 | grep "RESULT"
echo
echo '## Epsilon 0.015'
./main $EXPO8D2M 0.015 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.015 8 2 | grep "RESULT"
# ./main $EXPO8D2M 0.015 8 2 | grep "RESULT"
