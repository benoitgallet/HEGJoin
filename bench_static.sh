#!/bin/bash

EXPO2D2M="../datasets/2d/expo2d2m.bin"
EXPO2D10M="../datasets/2d/expo2d10m.bin"

EXPO2D2M="../datasets/3d/expo3d2m.bin"
EXPO2D10M="../datasets/3d/expo3d10m.bin"

EXPO4D2M="../datasets/4d/expo4d2m.bin"
EXPO4D10M="../datasets/4d/expo4d10m.bin"

EXPO6D2M="../datasets/6d/expo6d2m.bin"
EXPO6D10M="../datasets/6d/expo6d10m.bin"

EXPO8D2M="../datasets/8d/expo8d2m.bin"
EXPO8D10M="../datasets/8d/expo8d10m.bin"

sed -i '4s/.*/#define GPUNUMDIM 2/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 2/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo '~ EXPO2D2M'
echo '# Hybrid (Dynamic)'
echo '## Epsilon 0.0020'
./main $EXPO2D2M 0.0020 2 1 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ EXPO2D10M'
echo '# Hybrid (Dynamic)'
echo '## Epsilon 0.00040'
./main $EXPO2D10M 0.00040 2 1 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

sed -i '4s/.*/#define GPUNUMDIM 3/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 3/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo '~ EXPO3D2M'
echo '# Hybrid (Dynamic)'
echo '## Epsilon 0.005'
./main $EXPO3D2M 0.005 3 1 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ EXPO3D10M'
echo '# Hybrid (Dynamic)'
echo '## Epsilon 0.0015'
./main $EXPO3D10M 0.0015 3 1 | grep "RESULT"

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
echo '# Hybrid (Dynamic)'
cho '## Epsilon 0.010'
./main $EXPO4D2M 0.010 4 1 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ EXPO4D10M'
echo '# Hybrid (Dynamic)'
echo '## Epsilon 0.0040'
./main $EXPO4D10M 0.0040 4 1 | grep "RESULT"

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
echo '# Hybrid (Dynamic)'
echo '## Epsilon 0.015'
./main $EXPO6D2M 0.015 6 1 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

# echo '~ EXPO6D10M'
# echo '# Hybrid (Dynamic)'
# echo '## Epsilon 0.0080'
# ./main $EXPO6D10M 0.0080 6 1 | grep "RESULT"
#
# echo
# echo
# echo '-----'
# echo
# echo

# sed -i '4s/.*/#define GPUNUMDIM 8/' params.h
# sed -i '5s/.*/#define NUMINDEXEDDIM 8/' params.h
# make clean 1>/dev/null 2>/dev/null
# make 1>/dev/null 2>/dev/null
#
# echo '~ EXPO8D2M'
# echo '# Hybrid (Dynamic)'
# cho '## Epsilon 0.015'
# ./main $EXPO8D2M 0.015 8 1 | grep "RESULT"
#
# echo
# echo
# echo '-----'
# echo
# echo
#
# echo '~ EXPO8D10M'
# echo '# Hybrid (Dynamic)'
# echo '## Epsilon 0.0120'
# ./main $EXPO8D10M 0.0120 8 1 | grep "RESULT"


####################################################################################################

sed -i '34s/.*/#define STATIC_SPLIT_QUERIES 1/' params.h

sed -i '4s/.*/#define GPUNUMDIM 2/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 2/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo '~ EXPO2D2M'
echo '# Hybrid (Queries)'
echo '## Epsilon 0.0020'
./main $EXPO2D2M 0.0020 2 2 0.1 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 2 0.2 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 2 0.3 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 2 0.4 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 2 0.5 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 2 0.6 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 2 0.7 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 2 0.8 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 2 0.9 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ EXPO2D10M'
echo '# Hybrid (Queries)'
echo '## Epsilon 0.00040'
./main $EXPO2D10M 0.00040 2 2 0.1 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 2 0.2 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 2 0.3 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 2 0.4 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 2 0.5 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 2 0.6 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 2 0.7 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 2 0.8 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 2 0.9 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

sed -i '4s/.*/#define GPUNUMDIM 3/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 3/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo '~ EXPO3D2M'
echo '# Hybrid (Queries)'
echo '## Epsilon 0.005'
./main $EXPO3D2M 0.005 3 2 0.1 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 2 0.2 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 2 0.3 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 2 0.4 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 2 0.5 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 2 0.6 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 2 0.7 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 2 0.8 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 2 0.9 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ EXPO3D10M'
echo '# Hybrid (Queries)'
echo '## Epsilon 0.0015'
./main $EXPO3D10M 0.0015 3 2 0.1 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 2 0.2 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 2 0.3 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 2 0.4 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 2 0.5 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 2 0.6 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 2 0.7 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 2 0.8 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 2 0.9 | grep "RESULT"

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
echo '# Hybrid (Queries)'
echo '## Epsilon 0.010'
./main $EXPO4D2M 0.010 4 2 0.1 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 2 0.2 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 2 0.3 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 2 0.4 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 2 0.5 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 2 0.6 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 2 0.7 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 2 0.8 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 2 0.9 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ EXPO4D10M'
echo '# Hybrid (Queries)'
echo '## Epsilon 0.0040'
./main $EXPO4D10M 0.0040 4 2 0.1 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 2 0.2 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 2 0.3 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 2 0.4 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 2 0.5 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 2 0.6 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 2 0.7 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 2 0.8 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 2 0.9 | grep "RESULT"

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
echo '# Hybrid (Queries)'
echo '## Epsilon 0.015'
./main $EXPO6D2M 0.015 6 2 0.1 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 2 0.2 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 2 0.3 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 2 0.4 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 2 0.5 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 2 0.6 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 2 0.7 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 2 0.8 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 2 0.9 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

# echo '~ EXPO6D10M'
# echo '# Hybrid (Queries)'
# echo '## Epsilon 0.0080'
# ./main $EXPO6D10M 0.0080 6 2 0.1 | grep "RESULT"
# echo
# ./main $EXPO6D10M 0.0080 6 2 0.2 | grep "RESULT"
# echo
# ./main $EXPO6D10M 0.0080 6 2 0.3 | grep "RESULT"
# echo
# ./main $EXPO6D10M 0.0080 6 2 0.4 | grep "RESULT"
# echo
# ./main $EXPO6D10M 0.0080 6 2 0.5 | grep "RESULT"
# echo
# ./main $EXPO6D10M 0.0080 6 2 0.6 | grep "RESULT"
# echo
# ./main $EXPO6D10M 0.0080 6 2 0.7 | grep "RESULT"
# echo
# ./main $EXPO6D10M 0.0080 6 2 0.8 | grep "RESULT"
# echo
# ./main $EXPO6D10M 0.0080 6 2 0.9 | grep "RESULT"
#
# echo
# echo
# echo '-----'
# echo
# echo

# sed -i '4s/.*/#define GPUNUMDIM 8/' params.h
# sed -i '5s/.*/#define NUMINDEXEDDIM 8/' params.h
# make clean 1>/dev/null 2>/dev/null
# make 1>/dev/null 2>/dev/null
#
# echo '~ EXPO8D2M'
# echo '# Hybrid (Queries)'
# cho '## Epsilon 0.015'
# ./main $EXPO8D2M 0.015 8 2 | grep "RESULT"
#
# echo
# echo
# echo '-----'
# echo
# echo
#
# echo '~ EXPO8D10M'
# echo '# Hybrid (Queries)'
# echo '## Epsilon 0.0120'
# ./main $EXPO8D10M 0.0120 8 2 | grep "RESULT"


####################################################################################################


sed -i '34s/.*/#define STATIC_SPLIT_QUERIES 0/' params.h

sed -i '4s/.*/#define GPUNUMDIM 2/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 2/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo '~ EXPO2D2M'
echo '# Hybrid (Candidates)'
echo '## Epsilon 0.0020'
./main $EXPO2D2M 0.0020 2 2 0.1 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 2 0.2 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 2 0.3 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 2 0.4 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 2 0.5 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 2 0.6 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 2 0.7 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 2 0.8 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 2 0.9 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ EXPO2D10M'
echo '# Hybrid (Candidates)'
echo '## Epsilon 0.00040'
./main $EXPO2D10M 0.00040 2 2 0.1 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 2 0.2 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 2 0.3 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 2 0.4 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 2 0.5 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 2 0.6 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 2 0.7 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 2 0.8 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 2 0.9 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

sed -i '4s/.*/#define GPUNUMDIM 3/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 3/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null

echo '~ EXPO3D2M'
echo '# Hybrid (Candidates)'
echo '## Epsilon 0.005'
./main $EXPO3D2M 0.005 3 2 0.1 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 2 0.2 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 2 0.3 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 2 0.4 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 2 0.5 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 2 0.6 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 2 0.7 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 2 0.8 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 2 0.9 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ EXPO3D10M'
echo '# Hybrid (Candidates)'
echo '## Epsilon 0.0015'
./main $EXPO3D10M 0.0015 3 2 0.1 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 2 0.2 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 2 0.3 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 2 0.4 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 2 0.5 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 2 0.6 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 2 0.7 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 2 0.8 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 2 0.9 | grep "RESULT"

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
echo '# Hybrid (Candidates)'
cho '## Epsilon 0.010'
./main $EXPO4D2M 0.010 4 2 0.1 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 2 0.2 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 2 0.3 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 2 0.4 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 2 0.5 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 2 0.6 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 2 0.7 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 2 0.8 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 2 0.9 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ EXPO4D10M'
echo '# Hybrid (Candidates)'
echo '## Epsilon 0.0040'
./main $EXPO4D10M 0.0040 4 2 0.1 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 2 0.2 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 2 0.3 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 2 0.4 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 2 0.5 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 2 0.6 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 2 0.7 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 2 0.8 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 2 0.9 | grep "RESULT"

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
echo '# Hybrid (Candidates)'
echo '## Epsilon 0.015'
./main $EXPO6D2M 0.015 6 2 0.1 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 2 0.2 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 2 0.3 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 2 0.4 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 2 0.5 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 2 0.6 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 2 0.7 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 2 0.8 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 2 0.9 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

# echo '~ EXPO6D10M'
# echo '# Hybrid (Candidates)'
# echo '## Epsilon 0.0080'
# ./main $EXPO6D10M 0.0080 6 2 0.1 | grep "RESULT"
# echo
# ./main $EXPO6D10M 0.0080 6 2 0.2 | grep "RESULT"
# echo
# ./main $EXPO6D10M 0.0080 6 2 0.3 | grep "RESULT"
# echo
# ./main $EXPO6D10M 0.0080 6 2 0.4 | grep "RESULT"
# echo
# ./main $EXPO6D10M 0.0080 6 2 0.5 | grep "RESULT"
# echo
# ./main $EXPO6D10M 0.0080 6 2 0.6 | grep "RESULT"
# echo
# ./main $EXPO6D10M 0.0080 6 2 0.7 | grep "RESULT"
# echo
# ./main $EXPO6D10M 0.0080 6 2 0.8 | grep "RESULT"
# echo
# ./main $EXPO6D10M 0.0080 6 2 0.9 | grep "RESULT"
#
# echo
# echo
# echo '-----'
# echo
# echo

# sed -i '4s/.*/#define GPUNUMDIM 8/' params.h
# sed -i '5s/.*/#define NUMINDEXEDDIM 8/' params.h
# make clean 1>/dev/null 2>/dev/null
# make 1>/dev/null 2>/dev/null
#
# echo '~ EXPO8D2M'
# echo '# Hybrid (Queries)'
# cho '## Epsilon 0.015'
# ./main $EXPO8D2M 0.015 8 2 | grep "RESULT"
#
# echo
# echo
# echo '-----'
# echo
# echo
#
# echo '~ EXPO8D10M'
# echo '# Hybrid (Queries)'
# echo '## Epsilon 0.0120'
# ./main $EXPO8D10M 0.0120 8 2 | grep "RESULT"
