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
echo '## Epsilon 0.000833333'
./main $SW2DA 0.000833333 2 3 | grep "nb_candidates" > candidates_sw2da_eps1.txt
echo
echo '## Epsilon 0.004166667'
./main $SW2DA 0.004166667 2 3 | grep "nb_candidates" > candidates_sw2da_eps5.txt

echo
echo

echo '~ SW2DB'
echo '## Epsilon 0.000277778'
./main $SW2DB 0.000277778 2 3 | grep "nb_candidates" > candidates_sw2db_eps1.txt
echo
echo '## Epsilon 0.001388889'
./main $SW2DB 0.001388889 2 3 | grep "nb_candidates" > candidates_sw2db_eps5.txt

echo
echo

echo '~ SDSS2DB'
echo '## Epsilon 0.0004'
./main $SDSS 0.0004 2 3 | grep "nb_candidates" > candidates_sdss2db_0004.txt
echo
echo '## Epsilon 0.0020'
./main $SDSS 0.0020 2 3 | grep "nb_candidates" > candidates_sdss2db_0020.txt

echo
echo

echo '~ EXPO2D2M'
echo '## Epsilon 0.0004'
./main $EXPO2D2M 0.0004 2 3 | grep "nb_candidates" > candidates_expo2d2m_0004.txt
echo
echo '## Epsilon 0.0020'
./main $EXPO2D2M 0.0020 2 3 | grep "nb_candidates" > candidates_expo2d2m_0020.txt

echo
echo

echo '~ EXPO2D10M'
echo '## Epsilon 0.00008'
./main $EXPO2D10M 0.00008 2 3 | grep "nb_candidates" > candidates_expo2d10m_00008.txt
echo
echo '## Epsilon 0.00040'
./main $EXPO2D10M 0.00040 2 3 | grep "nb_candidates" > candidates_expo2d10m_00040.txt

sed -i '4s/.*/#define GPUNUMDIM 3/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 3/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo
echo

echo '~ SW3DA'
echo '## Epsilon 0.001299791'
./main $SW3DA 0.001299791 3 3 | grep "nb_candidates" > candidates_sw3da_eps1.txt
echo
echo '## Epsilon 0.006498954'
./main $SW3DA 0.006498954 3 3 | grep "nb_candidates" > candidates_sw3da_eps5.txt

echo
echo

echo '~ SW3DB'
echo '## Epsilon 0.000425660'
./main $SW3DB 0.000425660 3 3 | grep "nb_candidates" > candidates_sw3db_eps1.txt
echo
echo '## Epsilon 0.002128298'
./main $SW3DB 0.002128298 3 3 | grep "nb_candidates" > candidates_sw3db_eps5.txt

echo
echo

echo '~ EXPO3D2M'
echo '## Epsilon 0.001'
./main $EXPO3D2M 0.001 3 3 | grep "nb_candidates" > candidates_expo3d2m_001.txt
echo
echo '## Epsilon 0.005'
./main $EXPO3D2M 0.005 3 3 | grep "nb_candidates" > candidates_expo3d2m_005.txt

echo
echo

echo '~ EXPO3D10M'
echo '## Epsilon 0.0003'
./main $EXPO3D10M 0.0003 3 3 | grep "nb_candidates" > candidates_expo3d10m_0003.txt
echo
echo '## Epsilon 0.0015'
./main $EXPO3D10M 0.0015 3 3 | grep "nb_candidates" > candidates_expo3d10m_0015.txt

sed -i '4s/.*/#define GPUNUMDIM 4/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 4/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo
echo

echo '~ EXPO4D2M'
echo '## Epsilon 0.002'
./main $EXPO4D2M 0.002 4 3 | grep "nb_candidates" > candidates_expo4d2m_002.txt
echo
echo '## Epsilon 0.010'
./main $EXPO4D2M 0.010 4 3 | grep "nb_candidates" > candidates_expo4d2m_010.txt

echo
echo

echo '~ EXPO4D10M'
echo '## Epsilon 0.0008'
./main $EXPO4D10M 0.0008 4 3 | grep "nb_candidates" > candidates_expo4d10m_0008.txt
echo
echo '## Epsilon 0.0040'
./main $EXPO4D10M 0.0040 4 3 | grep "nb_candidates" > candidates_expo4d10m_0040.txt

echo
echo

sed -i '4s/.*/#define GPUNUMDIM 6/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 6/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo '~ EXPO6D2M'
echo '## Epsilon 0.003'
./main $EXPO6D2M 0.003 6 3 | grep "nb_candidates" > candidates_expo6d2m_003.txt
echo
echo '## Epsilon 0.015'
./main $EXPO6D2M 0.015 6 3 | grep "nb_candidates" > candidates_expo6d2m_015.txt

echo
echo

echo '~ EXPO6D10M'
echo '## Epsilon 0.0016'
./main $EXPO6D10M 0.0016 6 3 | grep "nb_candidates" > candidates_expo6d10m_0016.txt
echo
echo '## Epsilon 0.0080'
./main $EXPO6D10M 0.0080 6 3 | grep "nb_candidates" > candidates_expo6d10m_0080.txt

echo
echo

sed -i '4s/.*/#define GPUNUMDIM 8/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 8/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo '~ EXPO8D2M'
echo '## Epsilon 0.003'
./main $EXPO8D2M 0.003 8 3 | grep "nb_candidates" > candidates_expo8d2m_003.txt
echo
echo '## Epsilon 0.015'
./main $EXPO8D2M 0.015 8 3 | grep "nb_candidates" > candidates_expo8d2m_015.txt

echo
echo

echo '## Epsilon 0.0024'
./main $EXPO8D10M 0.0024 8 3 | grep "nb_candidates" > candidates_expo8d10m_0024.txt
echo
echo '## Epsilon 0.0120'
./main $EXPO8D10M 0.0120 8 3 | grep "nb_candidates" > candidates_expo8d10m_0120.txt
