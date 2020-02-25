#!/bin/bash

SW2DA="../datasets/2d/sw2da_0_1.bin"
SDSS="../datasets/2d/sdss2d15m_0_1.bin"
EXPO2D2M="../datasets/2d/expo2d2m.bin"
EXPO2D10M="../datasets/2d/expo2d10m.bin"

SW3DA="../datasets/3d/sw3da_0_1.bin"

EXPO4D2M="../datasets/4d/expo4d2m.bin"
EXPO4D10M="../datasets/4d/expo4d10m.bin"

EXPO8D2M="../datasets/8d/expo8d2m.bin"
EXPO8D10M="../datasets/8d/expo8d10m.bin"

sed -i '4s/.*/#define GPUNUMDIM 2/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 2/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo 'Expo2d2m'
./main $EXPO2D2M 0.002 2 0 | grep "BENCH"
nvprof --kernels "kernelNDGridIndexGlobal" --export-profile "expo2d2m.prof" ./main $EXPO2D2M 0.002 2 0

echo
echo 'Expo2d10m'
./main $EXPO2D10M 0.0004 2 0 | grep "BENCH"
nvprof --kernels "kernelNDGridIndexGlobal" --export-profile "expo2d10m.prof" ./main $EXPO2D10M 0.0004 2 0

echo
echo 'sw2da'
./main $SW2DA 0.004166667 2 0 | grep "BENCH"
nvprof --kernels "kernelNDGridIndexGlobal" --export-profile "sw2da.prof" ./main $SW2DA 0.004166667 2 0

echo
echo 'sdss'
./main $SDSS 0.002 2 0 | grep "BENCH"
nvprof --kernels "kernelNDGridIndexGlobal" --export-profile "sdss.prof" ./main $SDSS 0.002 2 0

sed -i '4s/.*/#define GPUNUMDIM 3/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 3/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo
echo 'sw3da'
./main $SW3DA 0.006498954 3 0 | grep "BENCH"
nvprof --kernels "kernelNDGridIndexGlobal" --export-profile "sw3da.prof" ./main $SW3DA 0.006498954 3 0

sed -i '4s/.*/#define GPUNUMDIM 4/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 4/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo
echo 'Expo4d2m'
./main $EXPO4D2M 0.01 4 0 | grep "BENCH"
nvprof --kernels "kernelNDGridIndexGlobal" --export-profile "expo4d2m.prof" ./main $EXPO4D2M 0.01 4 0

echo
echo 'Expo4d10m'
./main $EXPO4D10M 0.004 4 0 | grep "BENCH"
nvprof --kernels "kernelNDGridIndexGlobal" --export-profile "expo4d10m.prof" ./main $EXPO4D10M 0.004 4 0

sed -i '4s/.*/#define GPUNUMDIM 8/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 8/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo
echo 'Expo8d2m'
./main $EXPO8D2M 0.015 8 0 | grep "BENCH"
nvprof --kernels "kernelNDGridIndexGlobal" --export-profile "expo8d2m.prof" ./main $EXPO8D2M 0.015 8 0

echo
echo 'Expo8d10m'
./main $EXPO8D10M 0.012 8 0 | grep "BENCH"
nvprof --kernels "kernelNDGridIndexGlobal" --export-profile "expo8d10m.prof" ./main $EXPO8D10M 0.012 8 0
