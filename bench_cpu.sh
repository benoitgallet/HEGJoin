#!/bin/bash

SW2DA="../datasets/2d/sw2da_0_1.bin"
SW2DB="../datasets/2d/sw2db_0_1.bin"
SDSS="../datasets/2d/sdss2d15m_0_1.bin"
EXPO2D2M="../datasets/2d/expo2d2m.bin"
EXPO2D10M="../datasets/2d/expo2d10m.bin"

SW3DA="../datasets/3d/sw3da_0_1.bin"
SW3DB="../datasets/3d/sw3db_0_1.bin"
EXPO3D2M="../datasets/3d/expo3d2m.bin"
EXPO3D10M="../datasets/3d/expo3d10m.bin"

EXPO4D2M="../datasets/4d/expo4d2m.bin"
EXPO4D10M="../datasets/4d/expo4d10m.bin"

EXPO6D2M="../datasets/6d/expo6d2m.bin"
EXPO6D10M="../datasets/6d/expo6d10m.bin"

EXPO8D2M="../datasets/8d/expo8d2m.bin"
EXPO8D10M="../datasets/8d/expo8d10m.bin"

echo '~ SW2DA'
echo '# Super-EGO'
echo '## Epsilon 0.004166667'
./main $SW2DA 0.004166667 2 3 | grep "RESULT"
echo
./main $SW2DA 0.004166667 2 3 | grep "RESULT"
echo
./main $SW2DA 0.004166667 2 3 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ SW2DB'
echo '# Super-EGO'
echo '## Epsilon 0.001388889'
./main $SW2DA 0.001388889 2 3 | grep "RESULT"
echo
./main $SW2DA 0.001388889 2 3 | grep "RESULT"
echo
./main $SW2DA 0.001388889 2 3 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ SDSS2DB'
echo '# Super-EGO'
echo '## Epsilon 0.0020'
./main $SDSS 0.0020 2 3 | grep "RESULT"
echo
./main $SDSS 0.0020 2 3 | grep "RESULT"
echo
./main $SDSS 0.0020 2 3 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ EXPO2D2M'
echo '# Super-EGO'
echo '## Epsilon 0.0020'
./main $EXPO2D2M 0.0020 2 3 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 3 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 3 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ EXPO2D10M'
echo '# Super-EGO'
echo '## Epsilon 0.00040'
./main $EXPO2D10M 0.00040 2 3 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 3 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 3 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

sed -i '4s/.*/#define GPUNUMDIM 3/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 3/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo '~ SW3DA'
echo '# Super-EGO'
echo '## Epsilon 0.006498954'
./main $SW3DA 0.006498954 3 3 | grep "RESULT"
echo
./main $SW3DA 0.006498954 3 3 | grep "RESULT"
echo
./main $SW3DA 0.006498954 3 3 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ SW3DB'
echo '# Super-EGO'
echo '## Epsilon 0.002128298'
./main $SW3DB 0.002128298 3 3 | grep "RESULT"
echo
./main $SW3DB 0.002128298 3 3 | grep "RESULT"
echo
./main $SW3DB 0.002128298 3 3 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ EXPO3D2M'
echo '# Super-EGO'
echo '## Epsilon 0.005'
./main $EXPO3D2M 0.005 3 3 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 3 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 3 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ EXPO3D10M'
echo '# Super-EGO'
echo '## Epsilon 0.0015'
./main $EXPO3D10M 0.0015 3 3 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 3 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 3 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

sed -i '4s/.*/#define GPUNUMDIM 4/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 4/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo '~ EXPO4D2M'
echo '# Super-EGO'
echo '## Epsilon 0.010'
./main $EXPO4D2M 0.010 4 3 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 3 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 3 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ EXPO4D10M'
echo '# Super-EGO'
echo '## Epsilon 0.0040'
./main $EXPO4D10M 0.0040 4 3 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 3 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 3 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

sed -i '4s/.*/#define GPUNUMDIM 6/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 6/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo '~ EXPO6D2M'
echo '# Super-EGO'
echo '## Epsilon 0.015'
./main $EXPO6D2M 0.015 6 3 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 3 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 3 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ EXPO6D10M'
echo '# Super-EGO'
echo '## Epsilon 0.0080'
./main $EXPO6D10M 0.0080 6 3 | grep "RESULT"
echo
./main $EXPO6D10M 0.0080 6 3 | grep "RESULT"
echo
./main $EXPO6D10M 0.0080 6 3 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

sed -i '4s/.*/#define GPUNUMDIM 8/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 8/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo '~ EXPO8D2M'
echo '# Super-EGO'
echo '## Epsilon 0.015'
./main $EXPO8D2M 0.015 8 3 | grep "RESULT"
echo
./main $EXPO8D2M 0.015 8 3 | grep "RESULT"
echo
./main $EXPO8D2M 0.015 8 3 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ EXPO8D10M'
echo '# Super-EGO'
echo '## Epsilon 0.010'
./main $EXPO8D10M 0.010 8 3 | grep "RESULT"
echo
./main $EXPO8D10M 0.010 8 3 | grep "RESULT"
echo
./main $EXPO8D10M 0.010 8 3 | grep "RESULT"

echo
echo
