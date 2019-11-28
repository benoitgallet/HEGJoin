#!/bin/bash

EXPO8D2M="/data/fixed_length_expo_dist/dataset_fixed_len_pts_expo_NDIM_8_pts_2000000.txt"
EXPO8D10M="/data/fixed_length_expo_dist/dataset_fixed_len_pts_expo_NDIM_8_pts_10000000.txt"

sed -i '4s/.*/#define GPUNUMDIM 8/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 8/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo '~ EXPO8D2M'
echo '# GPU'
echo '## Epsilon 0.003'
./main $EXPO8D2M 0.003 8 0 | grep "RESULT"
./main $EXPO8D2M 0.003 8 0 | grep "RESULT"
./main $EXPO8D2M 0.003 8 0 | grep "RESULT"
echo '## Epsilon 0.006'
./main $EXPO8D2M 0.006 8 0 | grep "RESULT"
./main $EXPO8D2M 0.006 8 0 | grep "RESULT"
./main $EXPO8D2M 0.006 8 0 | grep "RESULT"
echo '## Epsilon 0.009'
./main $EXPO8D2M 0.009 8 0 | grep "RESULT"
./main $EXPO8D2M 0.009 8 0 | grep "RESULT"
./main $EXPO8D2M 0.009 8 0 | grep "RESULT"
echo '## Epsilon 0.012'
./main $EXPO8D2M 0.012 8 0 | grep "RESULT"
./main $EXPO8D2M 0.012 8 0 | grep "RESULT"
./main $EXPO8D2M 0.012 8 0 | grep "RESULT"
echo '## Epsilon 0.015'
./main $EXPO8D2M 0.015 8 0 | grep "RESULT"
./main $EXPO8D2M 0.015 8 0 | grep "RESULT"
./main $EXPO8D2M 0.015 8 0 | grep "RESULT"

echo

echo '# Hybrid'
echo '## Epsilon 0.003'
./main $EXPO8D2M 0.003 8 1 | grep "RESULT"
./main $EXPO8D2M 0.003 8 1 | grep "RESULT"
./main $EXPO8D2M 0.003 8 1 | grep "RESULT"
echo '## Epsilon 0.006'
./main $EXPO8D2M 0.006 8 1 | grep "RESULT"
./main $EXPO8D2M 0.006 8 1 | grep "RESULT"
./main $EXPO8D2M 0.006 8 1 | grep "RESULT"
echo '## Epsilon 0.009'
./main $EXPO8D2M 0.009 8 1 | grep "RESULT"
./main $EXPO8D2M 0.009 8 1 | grep "RESULT"
./main $EXPO8D2M 0.009 8 1 | grep "RESULT"
echo '## Epsilon 0.012'
./main $EXPO8D2M 0.012 8 1 | grep "RESULT"
./main $EXPO8D2M 0.012 8 1 | grep "RESULT"
./main $EXPO8D2M 0.012 8 1 | grep "RESULT"
echo '## Epsilon 0.015'
./main $EXPO8D2M 0.015 8 1 | grep "RESULT"
./main $EXPO8D2M 0.015 8 1 | grep "RESULT"
./main $EXPO8D2M 0.015 8 1 | grep "RESULT"

echo

echo '# Super-EGO'
echo '## Epsilon 0.003'
./main $EXPO8D2M 0.003 8 2 | grep "RESULT"
./main $EXPO8D2M 0.003 8 2 | grep "RESULT"
./main $EXPO8D2M 0.003 8 2 | grep "RESULT"
echo '## Epsilon 0.006'
./main $EXPO8D2M 0.006 8 2 | grep "RESULT"
./main $EXPO8D2M 0.006 8 2 | grep "RESULT"
./main $EXPO8D2M 0.006 8 2 | grep "RESULT"
echo '## Epsilon 0.009'
./main $EXPO8D2M 0.009 8 2 | grep "RESULT"
./main $EXPO8D2M 0.009 8 2 | grep "RESULT"
./main $EXPO8D2M 0.009 8 2 | grep "RESULT"
echo '## Epsilon 0.012'
./main $EXPO8D2M 0.012 8 2 | grep "RESULT"
./main $EXPO8D2M 0.012 8 2 | grep "RESULT"
./main $EXPO8D2M 0.012 8 2 | grep "RESULT"
echo '## Epsilon 0.015'
./main $EXPO8D2M 0.015 8 2 | grep "RESULT"
./main $EXPO8D2M 0.015 8 2 | grep "RESULT"
./main $EXPO8D2M 0.015 8 2 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ EXPO8D10M'
echo '# GPU'
echo '## Epsilon 0.002'
./main $EXPO8D10M 0.002 8 0 | grep "RESULT"
./main $EXPO8D10M 0.002 8 0 | grep "RESULT"
./main $EXPO8D10M 0.002 8 0 | grep "RESULT"
echo '## Epsilon 0.004'
./main $EXPO8D10M 0.004 8 0 | grep "RESULT"
./main $EXPO8D10M 0.004 8 0 | grep "RESULT"
./main $EXPO8D10M 0.004 8 0 | grep "RESULT"
echo '## Epsilon 0.006'
./main $EXPO8D10M 0.006 8 0 | grep "RESULT"
./main $EXPO8D10M 0.006 8 0 | grep "RESULT"
./main $EXPO8D10M 0.006 8 0 | grep "RESULT"
echo '## Epsilon 0.008'
./main $EXPO8D10M 0.008 8 0 | grep "RESULT"
./main $EXPO8D10M 0.008 8 0 | grep "RESULT"
./main $EXPO8D10M 0.008 8 0 | grep "RESULT"
echo '## Epsilon 0.010'
./main $EXPO8D10M 0.010 8 0 | grep "RESULT"
./main $EXPO8D10M 0.010 8 0 | grep "RESULT"
./main $EXPO8D10M 0.010 8 0 | grep "RESULT"

echo

echo '# Hybrid'
echo '## Epsilon 0.002'
./main $EXPO8D10M 0.002 8 1 | grep "RESULT"
./main $EXPO8D10M 0.002 8 1 | grep "RESULT"
./main $EXPO8D10M 0.002 8 1 | grep "RESULT"
echo '## Epsilon 0.004'
./main $EXPO8D10M 0.004 8 1 | grep "RESULT"
./main $EXPO8D10M 0.004 8 1 | grep "RESULT"
./main $EXPO8D10M 0.004 8 1 | grep "RESULT"
echo '## Epsilon 0.006'
./main $EXPO8D10M 0.006 8 1 | grep "RESULT"
./main $EXPO8D10M 0.006 8 1 | grep "RESULT"
./main $EXPO8D10M 0.006 8 1 | grep "RESULT"
echo '## Epsilon 0.008'
./main $EXPO8D10M 0.008 8 1 | grep "RESULT"
./main $EXPO8D10M 0.008 8 1 | grep "RESULT"
./main $EXPO8D10M 0.008 8 1 | grep "RESULT"
echo '## Epsilon 0.010'
./main $EXPO8D10M 0.010 8 1 | grep "RESULT"
./main $EXPO8D10M 0.010 8 1 | grep "RESULT"
./main $EXPO8D10M 0.010 8 1 | grep "RESULT"

echo

echo '# Super-EGO'
echo '## Epsilon 0.002'
./main $EXPO8D10M 0.002 8 2 | grep "RESULT"
./main $EXPO8D10M 0.002 8 2 | grep "RESULT"
./main $EXPO8D10M 0.002 8 2 | grep "RESULT"
echo '## Epsilon 0.004'
./main $EXPO8D10M 0.004 8 2 | grep "RESULT"
./main $EXPO8D10M 0.004 8 2 | grep "RESULT"
./main $EXPO8D10M 0.004 8 2 | grep "RESULT"
echo '## Epsilon 0.006'
./main $EXPO8D10M 0.006 8 2 | grep "RESULT"
./main $EXPO8D10M 0.006 8 2 | grep "RESULT"
./main $EXPO8D10M 0.006 8 2 | grep "RESULT"
echo '## Epsilon 0.008'
./main $EXPO8D10M 0.008 8 2 | grep "RESULT"
./main $EXPO8D10M 0.008 8 2 | grep "RESULT"
./main $EXPO8D10M 0.008 8 2 | grep "RESULT"
echo '## Epsilon 0.010'
./main $EXPO8D10M 0.010 8 2 | grep "RESULT"
./main $EXPO8D10M 0.010 8 2 | grep "RESULT"
./main $EXPO8D10M 0.010 8 2 | grep "RESULT"
