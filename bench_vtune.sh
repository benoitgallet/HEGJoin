#!/bin/bash

SW2DA="../datasets/2d/sw2da_0_1.txt"
SW2DB="../datasets/2d/sw2db_0_1.txt"
SDSS="../datasets/2d/sdss_2d_15m_normalized.txt"
EXPO2D2M="/data/fixed_length_expo_dist/dataset_fixed_len_pts_expo_NDIM_2_pts_2000000.txt"
EXPO2D10M="/data/fixed_length_expo_dist/dataset_fixed_len_pts_expo_NDIM_2_pts_10000000.txt"

SW3DA="../datasets/3d/sw3da_0_1.txt"
SW3DB="../datasets/3d/sw3db_0_1.txt"
EXPO3D2M="/data/fixed_length_expo_dist/dataset_fixed_len_pts_expo_NDIM_3_pts_2000000.txt"
EXPO3D10M="../datasets/3d/dataset_fixed_len_pts_expo_NDIM_3_pts_10000000.txt"

EXPO4D2M="/data/fixed_length_expo_dist/dataset_fixed_len_pts_expo_NDIM_4_pts_2000000.txt"
EXPO4D10M="/data/fixed_length_expo_dist/dataset_fixed_len_pts_expo_NDIM_4_pts_10000000.txt"

EXPO6D2M="/data/fixed_length_expo_dist/dataset_fixed_len_pts_expo_NDIM_6_pts_2000000.txt"
EXPO6D10M="/data/fixed_length_expo_dist/dataset_fixed_len_pts_expo_NDIM_6_pts_10000000.txt"

EXPO8D2M="/data/fixed_length_expo_dist/dataset_fixed_len_pts_expo_NDIM_8_pts_2000000.txt"
EXPO8D10M="/data/fixed_length_expo_dist/dataset_fixed_len_pts_expo_NDIM_8_pts_10000000.txt"

sed -i '4s/.*/#define GPUNUMDIM 2/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 2/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
vtune -collect memory-access -result-dir expo2d2m_0_0020 -knob dram-bandwidth-limits=true -knob analyze-openmp=true ./main $EXPO2D2M 0.002 2 1
vtune -collect memory-access -result-dir expo2d10m_0_0004 -knob dram-bandwidth-limits=true -knob analyze-openmp=true ./main $EXPO2D10M 0.0004 2 1
vtune -collect memory-access -result-dir sw2da_1_5 -knob dram-bandwidth-limits=true -knob analyze-openmp=true ./main $SW2DA 0.004166667 2 1
vtune -collect memory-access -result-dir sdss_0_002 -knob dram-bandwidth-limits=true -knob analyze-openmp=true ./main $SDSS 0.002 2 1


sed -i '4s/.*/#define GPUNUMDIM 3/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 3/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
vtune -collect memory-access -result-dir sw3da_3_0 -knob dram-bandwidth-limits=true -knob analyze-openmp=true ./main $SW3DA 0.006498954 3 1


sed -i '4s/.*/#define GPUNUMDIM 4/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 4/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
vtune -collect memory-access -result-dir expo4d2m_0_01 -knob dram-bandwidth-limits=true -knob analyze-openmp=true ./main $EXPO4D2M 0.01 4 1
vtune -collect memory-access -result-dir expo4d10m_0_004 -knob dram-bandwidth-limits=true -knob analyze-openmp=true ./main $EXPO4D10M 0.004 4 1


sed -i '4s/.*/#define GPUNUMDIM 8/' params.h
sed -i '5s/.*/#define NUMINDEXEDDIM 8/' params.h
make clean 1>/dev/null 2>/dev/null
make 1>/dev/null 2>/dev/null
vtune -collect memory-access -result-dir expo8d2m_0_015 -knob dram-bandwidth-limits=true -knob analyze-openmp=true ./main $EXPO8D2M 0.015 8 1
vtune -collect memory-access -result-dir expo8d10m_0_012 -knob dram-bandwidth-limits=true -knob analyze-openmp=true ./main $EXPO8D10M 0.012 8 1
