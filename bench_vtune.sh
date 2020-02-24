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

source /home/benoit/intel/vtune_profiler_2020.0.0.605129/vtune-vars.sh

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
