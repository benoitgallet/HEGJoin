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
echo '# GPU'
echo '## Epsilon 0.000833333'
./main $SW2DA 0.000833333 2 0 | grep "RESULT"
echo
./main $SW2DA 0.000833333 2 0 | grep "RESULT"
echo
./main $SW2DA 0.000833333 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.001666667'
./main $SW2DA 0.001666667 2 0 | grep "RESULT"
echo
./main $SW2DA 0.001666667 2 0 | grep "RESULT"
echo
./main $SW2DA 0.001666667 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.002500000'
./main $SW2DA 0.002500000 2 0 | grep "RESULT"
echo
./main $SW2DA 0.002500000 2 0 | grep "RESULT"
echo
./main $SW2DA 0.002500000 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.003333333'
./main $SW2DA 0.003333333 2 0 | grep "RESULT"
echo
./main $SW2DA 0.003333333 2 0 | grep "RESULT"
echo
./main $SW2DA 0.003333333 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.004166667'
./main $SW2DA 0.004166667 2 0 | grep "RESULT"
echo
./main $SW2DA 0.004166667 2 0 | grep "RESULT"
echo
./main $SW2DA 0.004166667 2 0 | grep "RESULT"

echo
echo '~~~'
echo

echo '# Super-EGO'
echo '## Epsilon 0.000833333'
./main $SW2DA 0.000833333 2 3 | grep "RESULT"
echo
./main $SW2DA 0.000833333 2 3 | grep "RESULT"
echo
./main $SW2DA 0.000833333 2 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.001666667'
./main $SW2DA 0.001666667 2 3 | grep "RESULT"
echo
./main $SW2DA 0.001666667 2 3 | grep "RESULT"
echo
./main $SW2DA 0.001666667 2 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.002500000'
./main $SW2DA 0.002500000 2 3 | grep "RESULT"
echo
./main $SW2DA 0.002500000 2 3 | grep "RESULT"
echo
./main $SW2DA 0.002500000 2 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.003333333'
./main $SW2DA 0.003333333 2 3 | grep "RESULT"
echo
./main $SW2DA 0.003333333 2 3 | grep "RESULT"
echo
./main $SW2DA 0.003333333 2 3 | grep "RESULT"
echo
echo
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
echo '# GPU'
echo '## Epsilon 0.000277778'
./main $SW2DB 0.000277778 2 0 | grep "RESULT"
echo
./main $SW2DB 0.000277778 2 0 | grep "RESULT"
echo
./main $SW2DB 0.000277778 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.000555556'
./main $SW2DB 0.000555556 2 0 | grep "RESULT"
echo
./main $SW2DB 0.000555556 2 0 | grep "RESULT"
echo
./main $SW2DB 0.000555556 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.000833333'
./main $SW2DB 0.000833333 2 0 | grep "RESULT"
echo
./main $SW2DB 0.000833333 2 0 | grep "RESULT"
echo
./main $SW2DB 0.000833333 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.001111111'
./main $SW2DB 0.001111111 2 0 | grep "RESULT"
echo
./main $SW2DB 0.001111111 2 0 | grep "RESULT"
echo
./main $SW2DB 0.001111111 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.001388889'
./main $SW2DB 0.001388889 2 0 | grep "RESULT"
echo
./main $SW2DB 0.001388889 2 0 | grep "RESULT"
echo
./main $SW2DB 0.001388889 2 0 | grep "RESULT"

echo
echo '~~~'
echo

echo '# Super-EGO'
echo '## Epsilon 0.000277778'
./main $SW2DB 0.000277778 2 3 | grep "RESULT"
echo
./main $SW2DB 0.000277778 2 3 | grep "RESULT"
echo
./main $SW2DB 0.000277778 2 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.000555556'
./main $SW2DB 0.000555556 2 3 | grep "RESULT"
echo
./main $SW2DB 0.000555556 2 3 | grep "RESULT"
echo
./main $SW2DB 0.000555556 2 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.000833333'
./main $SW2DB 0.000833333 2 3 | grep "RESULT"
echo
./main $SW2DB 0.000833333 2 3 | grep "RESULT"
echo
./main $SW2DB 0.000833333 2 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.001111111'
./main $SW2DB 0.001111111 2 3 | grep "RESULT"
echo
./main $SW2DB 0.001111111 2 3 | grep "RESULT"
echo
./main $SW2DB 0.001111111 2 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.001388889'
./main $SW2DB 0.001388889 2 3 | grep "RESULT"
echo
./main $SW2DB 0.001388889 2 3 | grep "RESULT"
echo
./main $SW2DB 0.001388889 2 3 | grep "RESULT"

echo
echo
echo '-----'
echo
echo

echo '~ SDSS2DB'
echo '# GPU'
echo '## Epsilon 0.0004'
./main $SDSS 0.0004 2 0 | grep "RESULT"
echo
./main $SDSS 0.0004 2 0 | grep "RESULT"
echo
./main $SDSS 0.0004 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0008'
./main $SDSS 0.0008 2 0 | grep "RESULT"
echo
./main $SDSS 0.0008 2 0 | grep "RESULT"
echo
./main $SDSS 0.0008 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0012'
./main $SDSS 0.0012 2 0 | grep "RESULT"
echo
./main $SDSS 0.0012 2 0 | grep "RESULT"
echo
./main $SDSS 0.0012 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0016'
./main $SDSS 0.0016 2 0 | grep "RESULT"
echo
./main $SDSS 0.0016 2 0 | grep "RESULT"
echo
./main $SDSS 0.0016 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0020'
./main $SDSS 0.0020 2 0 | grep "RESULT"
echo
./main $SDSS 0.0020 2 0 | grep "RESULT"
echo
./main $SDSS 0.0020 2 0 | grep "RESULT"

echo
echo '~~~'
echo

echo '# Super-EGO'
echo '## Epsilon 0.0004'
./main $SDSS 0.0004 2 3 | grep "RESULT"
echo
./main $SDSS 0.0004 2 3 | grep "RESULT"
echo
./main $SDSS 0.0004 2 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0008'
./main $SDSS 0.0008 2 3 | grep "RESULT"
echo
./main $SDSS 0.0008 2 3 | grep "RESULT"
echo
./main $SDSS 0.0008 2 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0012'
./main $SDSS 0.0012 2 3 | grep "RESULT"
echo
./main $SDSS 0.0012 2 3 | grep "RESULT"
echo
./main $SDSS 0.0012 2 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0016'
./main $SDSS 0.0016 2 3 | grep "RESULT"
echo
./main $SDSS 0.0016 2 3 | grep "RESULT"
echo
./main $SDSS 0.0016 2 3 | grep "RESULT"
echo
echo
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
echo '# GPU'
echo '## Epsilon 0.0004'
./main $EXPO2D2M 0.0004 2 0 | grep "RESULT"
echo
./main $EXPO2D2M 0.0004 2 0 | grep "RESULT"
echo
./main $EXPO2D2M 0.0004 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0008'
./main $EXPO2D2M 0.0008 2 0 | grep "RESULT"
echo
./main $EXPO2D2M 0.0008 2 0 | grep "RESULT"
echo
./main $EXPO2D2M 0.0008 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0012'
./main $EXPO2D2M 0.0012 2 0 | grep "RESULT"
echo
./main $EXPO2D2M 0.0012 2 0 | grep "RESULT"
echo
./main $EXPO2D2M 0.0012 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0016'
./main $EXPO2D2M 0.0016 2 0 | grep "RESULT"
echo
./main $EXPO2D2M 0.0016 2 0 | grep "RESULT"
echo
./main $EXPO2D2M 0.0016 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0020'
./main $EXPO2D2M 0.0020 2 0 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 0 | grep "RESULT"
echo
./main $EXPO2D2M 0.0020 2 0 | grep "RESULT"

echo
echo '~~~'
echo

echo '# Super-EGO'
echo '## Epsilon 0.0004'
./main $EXPO2D2M 0.0004 2 3 | grep "RESULT"
echo
./main $EXPO2D2M 0.0004 2 3 | grep "RESULT"
echo
./main $EXPO2D2M 0.0004 2 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0008'
./main $EXPO2D2M 0.0008 2 3 | grep "RESULT"
echo
./main $EXPO2D2M 0.0008 2 3 | grep "RESULT"
echo
./main $EXPO2D2M 0.0008 2 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0012'
./main $EXPO2D2M 0.0012 2 3 | grep "RESULT"
echo
./main $EXPO2D2M 0.0012 2 3 | grep "RESULT"
echo
./main $EXPO2D2M 0.0012 2 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0016'
./main $EXPO2D2M 0.0016 2 3 | grep "RESULT"
echo
./main $EXPO2D2M 0.0016 2 3 | grep "RESULT"
echo
./main $EXPO2D2M 0.0016 2 3 | grep "RESULT"
echo
echo
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
echo '# GPU'
echo '## Epsilon 0.00008'
./main $EXPO2D10M 0.00008 2 0 | grep "RESULT"
echo
./main $EXPO2D10M 0.00008 2 0 | grep "RESULT"
echo
./main $EXPO2D10M 0.00008 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.00016'
./main $EXPO2D10M 0.00016 2 0 | grep "RESULT"
echo
./main $EXPO2D10M 0.00016 2 0 | grep "RESULT"
echo
./main $EXPO2D10M 0.00016 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.00024'
./main $EXPO2D10M 0.00024 2 0 | grep "RESULT"
echo
./main $EXPO2D10M 0.00024 2 0 | grep "RESULT"
echo
./main $EXPO2D10M 0.00024 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.00032'
./main $EXPO2D10M 0.00032 2 0 | grep "RESULT"
echo
./main $EXPO2D10M 0.00032 2 0 | grep "RESULT"
echo
./main $EXPO2D10M 0.00032 2 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.00040'
./main $EXPO2D10M 0.00040 2 0 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 0 | grep "RESULT"
echo
./main $EXPO2D10M 0.00040 2 0 | grep "RESULT"

echo
echo '~~~'
echo

echo '# Super-EGO'
echo '## Epsilon 0.00008'
./main $EXPO2D10M 0.00008 2 3 | grep "RESULT"
echo
./main $EXPO2D10M 0.00008 2 3 | grep "RESULT"
echo
./main $EXPO2D10M 0.00008 2 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.00016'
./main $EXPO2D10M 0.00016 2 3 | grep "RESULT"
echo
./main $EXPO2D10M 0.00016 2 3 | grep "RESULT"
echo
./main $EXPO2D10M 0.00016 2 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.00024'
./main $EXPO2D10M 0.00024 2 3 | grep "RESULT"
echo
./main $EXPO2D10M 0.00024 2 3 | grep "RESULT"
echo
./main $EXPO2D10M 0.00024 2 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.00032'
./main $EXPO2D10M 0.00032 2 3 | grep "RESULT"
echo
./main $EXPO2D10M 0.00032 2 3 | grep "RESULT"
echo
./main $EXPO2D10M 0.00032 2 3 | grep "RESULT"
echo
echo
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
echo '# GPU'
echo '## Epsilon 0.001299791'
./main $SW3DA 0.001299791 3 0 | grep "RESULT"
echo
./main $SW3DA 0.001299791 3 0 | grep "RESULT"
echo
./main $SW3DA 0.001299791 3 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.002599582'
./main $SW3DA 0.002599582 3 0 | grep "RESULT"
echo
./main $SW3DA 0.002599582 3 0 | grep "RESULT"
echo
./main $SW3DA 0.002599582 3 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.003899373'
./main $SW3DA 0.003899373 3 0 | grep "RESULT"
echo
./main $SW3DA 0.003899373 3 0 | grep "RESULT"
echo
./main $SW3DA 0.003899373 3 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.005199163'
./main $SW3DA 0.005199163 3 0 | grep "RESULT"
echo
./main $SW3DA 0.005199163 3 0 | grep "RESULT"
echo
./main $SW3DA 0.005199163 3 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.006498954'
./main $SW3DA 0.006498954 3 0 | grep "RESULT"
echo
./main $SW3DA 0.006498954 3 0 | grep "RESULT"
echo
./main $SW3DA 0.006498954 3 0 | grep "RESULT"

echo
echo '~~~'
echo

echo '# Super-EGO'
echo '## Epsilon 0.001299791'
./main $SW3DA 0.001299791 3 3 | grep "RESULT"
echo
./main $SW3DA 0.001299791 3 3 | grep "RESULT"
echo
./main $SW3DA 0.001299791 3 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.002599582'
./main $SW3DA 0.002599582 3 3 | grep "RESULT"
echo
./main $SW3DA 0.002599582 3 3 | grep "RESULT"
echo
./main $SW3DA 0.002599582 3 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.003899373'
./main $SW3DA 0.003899373 3 3 | grep "RESULT"
echo
./main $SW3DA 0.003899373 3 3 | grep "RESULT"
echo
./main $SW3DA 0.003899373 3 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.005199163'
./main $SW3DA 0.005199163 3 3 | grep "RESULT"
echo
./main $SW3DA 0.005199163 3 3 | grep "RESULT"
echo
./main $SW3DA 0.005199163 3 3 | grep "RESULT"
echo
echo
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
echo '# GPU'
echo '## Epsilon 0.000425660'
./main $SW3DB 0.000425660 3 0 | grep "RESULT"
echo
./main $SW3DB 0.000425660 3 0 | grep "RESULT"
echo
./main $SW3DB 0.000425660 3 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.000851319'
./main $SW3DB 0.000851319 3 0 | grep "RESULT"
echo
./main $SW3DB 0.000851319 3 0 | grep "RESULT"
echo
./main $SW3DB 0.000851319 3 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.001276979'
./main $SW3DB 0.001276979 3 0 | grep "RESULT"
echo
./main $SW3DB 0.001276979 3 0 | grep "RESULT"
echo
./main $SW3DB 0.001276979 3 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.001702639'
./main $SW3DB 0.001702639 3 0 | grep "RESULT"
echo
./main $SW3DB 0.001702639 3 0 | grep "RESULT"
echo
./main $SW3DB 0.001702639 3 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.002128298'
./main $SW3DB 0.002128298 3 0 | grep "RESULT"
echo
./main $SW3DB 0.002128298 3 0 | grep "RESULT"
echo
./main $SW3DB 0.002128298 3 0 | grep "RESULT"

echo
echo '~~~'
echo

echo '# Super-EGO'
echo '## Epsilon 0.000425660'
./main $SW3DB 0.000425660 3 3 | grep "RESULT"
echo
./main $SW3DB 0.000425660 3 3 | grep "RESULT"
echo
./main $SW3DB 0.000425660 3 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.000851319'
./main $SW3DB 0.000851319 3 3 | grep "RESULT"
echo
./main $SW3DB 0.000851319 3 3 | grep "RESULT"
echo
./main $SW3DB 0.000851319 3 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.001276979'
./main $SW3DB 0.001276979 3 3 | grep "RESULT"
echo
./main $SW3DB 0.001276979 3 3 | grep "RESULT"
echo
./main $SW3DB 0.001276979 3 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.001702639'
./main $SW3DB 0.001702639 3 3 | grep "RESULT"
echo
./main $SW3DB 0.001702639 3 3 | grep "RESULT"
echo
./main $SW3DB 0.001702639 3 3 | grep "RESULT"
echo
echo
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
echo '# GPU'
echo '## Epsilon 0.001'
./main $EXPO3D2M 0.001 3 0 | grep "RESULT"
echo
./main $EXPO3D2M 0.001 3 0 | grep "RESULT"
echo
./main $EXPO3D2M 0.001 3 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.002'
./main $EXPO3D2M 0.002 3 0 | grep "RESULT"
echo
./main $EXPO3D2M 0.002 3 0 | grep "RESULT"
echo
./main $EXPO3D2M 0.002 3 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.003'
./main $EXPO3D2M 0.003 3 0 | grep "RESULT"
echo
./main $EXPO3D2M 0.003 3 0 | grep "RESULT"
echo
./main $EXPO3D2M 0.003 3 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.004'
./main $EXPO3D2M 0.004 3 0 | grep "RESULT"
echo
./main $EXPO3D2M 0.004 3 0 | grep "RESULT"
echo
./main $EXPO3D2M 0.004 3 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.005'
./main $EXPO3D2M 0.005 3 0 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 0 | grep "RESULT"
echo
./main $EXPO3D2M 0.005 3 0 | grep "RESULT"

echo
echo '~~~'
echo

echo '# Super-EGO'
echo '## Epsilon 0.001'
./main $EXPO3D2M 0.001 3 3 | grep "RESULT"
echo
./main $EXPO3D2M 0.001 3 3 | grep "RESULT"
echo
./main $EXPO3D2M 0.001 3 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.002'
./main $EXPO3D2M 0.002 3 3 | grep "RESULT"
echo
./main $EXPO3D2M 0.002 3 3 | grep "RESULT"
echo
./main $EXPO3D2M 0.002 3 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.003'
./main $EXPO3D2M 0.003 3 3 | grep "RESULT"
echo
./main $EXPO3D2M 0.003 3 3 | grep "RESULT"
echo
./main $EXPO3D2M 0.003 3 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.004'
./main $EXPO3D2M 0.004 3 3 | grep "RESULT"
echo
./main $EXPO3D2M 0.004 3 3 | grep "RESULT"
echo
./main $EXPO3D2M 0.004 3 3 | grep "RESULT"
echo
echo
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
echo '# GPU'
echo '## Epsilon 0.0003'
./main $EXPO3D10M 0.0003 3 0 | grep "RESULT"
echo
./main $EXPO3D10M 0.0003 3 0 | grep "RESULT"
echo
./main $EXPO3D10M 0.0003 3 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0006'
./main $EXPO3D10M 0.0006 3 0 | grep "RESULT"
echo
./main $EXPO3D10M 0.0006 3 0 | grep "RESULT"
echo
./main $EXPO3D10M 0.0006 3 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0009'
./main $EXPO3D10M 0.0009 3 0 | grep "RESULT"
echo
./main $EXPO3D10M 0.0009 3 0 | grep "RESULT"
echo
./main $EXPO3D10M 0.0009 3 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0012'
./main $EXPO3D10M 0.0012 3 0 | grep "RESULT"
echo
./main $EXPO3D10M 0.0012 3 0 | grep "RESULT"
echo
./main $EXPO3D10M 0.0012 3 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0015'
./main $EXPO3D10M 0.0015 3 0 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 0 | grep "RESULT"
echo
./main $EXPO3D10M 0.0015 3 0 | grep "RESULT"

echo
echo '~~~'
echo

echo '# Super-EGO'
echo '## Epsilon 0.0003'
./main $EXPO3D10M 0.0003 3 3 | grep "RESULT"
echo
./main $EXPO3D10M 0.0003 3 3 | grep "RESULT"
echo
./main $EXPO3D10M 0.0003 3 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0006'
./main $EXPO3D10M 0.0006 3 3 | grep "RESULT"
echo
./main $EXPO3D10M 0.0006 3 3 | grep "RESULT"
echo
./main $EXPO3D10M 0.0006 3 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0009'
./main $EXPO3D10M 0.0009 3 3 | grep "RESULT"
echo
./main $EXPO3D10M 0.0009 3 3 | grep "RESULT"
echo
./main $EXPO3D10M 0.0009 3 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0012'
./main $EXPO3D10M 0.0012 3 3 | grep "RESULT"
echo
./main $EXPO3D10M 0.0012 3 3 | grep "RESULT"
echo
./main $EXPO3D10M 0.0012 3 3 | grep "RESULT"
echo
echo
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
echo '# GPU'
echo '## Epsilon 0.002'
./main $EXPO4D2M 0.002 4 0 | grep "RESULT"
echo
./main $EXPO4D2M 0.002 4 0 | grep "RESULT"
echo
./main $EXPO4D2M 0.002 4 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.004'
./main $EXPO4D2M 0.004 4 0 | grep "RESULT"
echo
./main $EXPO4D2M 0.004 4 0 | grep "RESULT"
echo
./main $EXPO4D2M 0.004 4 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.006'
./main $EXPO4D2M 0.006 4 0 | grep "RESULT"
echo
./main $EXPO4D2M 0.006 4 0 | grep "RESULT"
echo
./main $EXPO4D2M 0.006 4 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.008'
./main $EXPO4D2M 0.008 4 0 | grep "RESULT"
echo
./main $EXPO4D2M 0.008 4 0 | grep "RESULT"
echo
./main $EXPO4D2M 0.008 4 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.010'
./main $EXPO4D2M 0.010 4 0 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 0 | grep "RESULT"
echo
./main $EXPO4D2M 0.010 4 0 | grep "RESULT"

echo
echo '~~~'
echo

echo '# Super-EGO'
echo '## Epsilon 0.002'
./main $EXPO4D2M 0.002 4 3 | grep "RESULT"
echo
./main $EXPO4D2M 0.002 4 3 | grep "RESULT"
echo
./main $EXPO4D2M 0.002 4 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.004'
./main $EXPO4D2M 0.004 4 3 | grep "RESULT"
echo
./main $EXPO4D2M 0.004 4 3 | grep "RESULT"
echo
./main $EXPO4D2M 0.004 4 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.006'
./main $EXPO4D2M 0.006 4 3 | grep "RESULT"
echo
./main $EXPO4D2M 0.006 4 3 | grep "RESULT"
echo
./main $EXPO4D2M 0.006 4 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.008'
./main $EXPO4D2M 0.008 4 3 | grep "RESULT"
echo
./main $EXPO4D2M 0.008 4 3 | grep "RESULT"
echo
./main $EXPO4D2M 0.008 4 3 | grep "RESULT"
echo
echo
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
echo '# GPU'
echo '## Epsilon 0.0008'
./main $EXPO4D10M 0.0008 4 0 | grep "RESULT"
echo
./main $EXPO4D10M 0.0008 4 0 | grep "RESULT"
echo
./main $EXPO4D10M 0.0008 4 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0016'
./main $EXPO4D10M 0.0016 4 0 | grep "RESULT"
echo
./main $EXPO4D10M 0.0016 4 0 | grep "RESULT"
echo
./main $EXPO4D10M 0.0016 4 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0024'
./main $EXPO4D10M 0.0024 4 0 | grep "RESULT"
echo
./main $EXPO4D10M 0.0024 4 0 | grep "RESULT"
echo
./main $EXPO4D10M 0.0024 4 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0032'
./main $EXPO4D10M 0.0032 4 0 | grep "RESULT"
echo
./main $EXPO4D10M 0.0032 4 0 | grep "RESULT"
echo
./main $EXPO4D10M 0.0032 4 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0040'
./main $EXPO4D10M 0.0040 4 0 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 0 | grep "RESULT"
echo
./main $EXPO4D10M 0.0040 4 0 | grep "RESULT"

echo
echo '~~~'
echo

echo '# Super-EGO'
echo '## Epsilon 0.0008'
./main $EXPO4D10M 0.0008 4 3 | grep "RESULT"
echo
./main $EXPO4D10M 0.0008 4 3 | grep "RESULT"
echo
./main $EXPO4D10M 0.0008 4 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0016'
./main $EXPO4D10M 0.0016 4 3 | grep "RESULT"
echo
./main $EXPO4D10M 0.0016 4 3 | grep "RESULT"
echo
./main $EXPO4D10M 0.0016 4 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0024'
./main $EXPO4D10M 0.0024 4 3 | grep "RESULT"
echo
./main $EXPO4D10M 0.0024 4 3 | grep "RESULT"
echo
./main $EXPO4D10M 0.0024 4 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0032'
./main $EXPO4D10M 0.0032 4 3 | grep "RESULT"
echo
./main $EXPO4D10M 0.0032 4 3 | grep "RESULT"
echo
./main $EXPO4D10M 0.0032 4 3 | grep "RESULT"
echo
echo
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
echo '# GPU'
echo '## Epsilon 0.003'
./main $EXPO6D2M 0.003 6 0 | grep "RESULT"
echo
./main $EXPO6D2M 0.003 6 0 | grep "RESULT"
echo
./main $EXPO6D2M 0.003 6 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.006'
./main $EXPO6D2M 0.006 6 0 | grep "RESULT"
echo
./main $EXPO6D2M 0.006 6 0 | grep "RESULT"
echo
./main $EXPO6D2M 0.006 6 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.009'
./main $EXPO6D2M 0.009 6 0 | grep "RESULT"
echo
./main $EXPO6D2M 0.009 6 0 | grep "RESULT"
echo
./main $EXPO6D2M 0.009 6 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.012'
./main $EXPO6D2M 0.012 6 0 | grep "RESULT"
echo
./main $EXPO6D2M 0.012 6 0 | grep "RESULT"
echo
./main $EXPO6D2M 0.012 6 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.015'
./main $EXPO6D2M 0.015 6 0 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 0 | grep "RESULT"
echo
./main $EXPO6D2M 0.015 6 0 | grep "RESULT"

echo
echo '~~~'
echo

echo '# Super-EGO'
echo '## Epsilon 0.003'
./main $EXPO6D2M 0.003 6 3 | grep "RESULT"
echo
./main $EXPO6D2M 0.003 6 3 | grep "RESULT"
echo
./main $EXPO6D2M 0.003 6 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.006'
./main $EXPO6D2M 0.006 6 3 | grep "RESULT"
echo
./main $EXPO6D2M 0.006 6 3 | grep "RESULT"
echo
./main $EXPO6D2M 0.006 6 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.009'
./main $EXPO6D2M 0.009 6 3 | grep "RESULT"
echo
./main $EXPO6D2M 0.009 6 3 | grep "RESULT"
echo
./main $EXPO6D2M 0.009 6 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.012'
./main $EXPO6D2M 0.012 6 3 | grep "RESULT"
echo
./main $EXPO6D2M 0.012 6 3 | grep "RESULT"
echo
./main $EXPO6D2M 0.012 6 3 | grep "RESULT"
echo
echo
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
echo '# GPU'
echo '## Epsilon 0.0016'
./main $EXPO6D10M 0.0016 6 0 | grep "RESULT"
echo
./main $EXPO6D10M 0.0016 6 0 | grep "RESULT"
echo
./main $EXPO6D10M 0.0016 6 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0032'
./main $EXPO6D10M 0.0032 6 0 | grep "RESULT"
echo
./main $EXPO6D10M 0.0032 6 0 | grep "RESULT"
echo
./main $EXPO6D10M 0.0032 6 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0048'
./main $EXPO6D10M 0.0048 6 0 | grep "RESULT"
echo
./main $EXPO6D10M 0.0048 6 0 | grep "RESULT"
echo
./main $EXPO6D10M 0.0048 6 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0064'
./main $EXPO6D10M 0.0064 6 0 | grep "RESULT"
echo
./main $EXPO6D10M 0.0064 6 0 | grep "RESULT"
echo
./main $EXPO6D10M 0.0064 6 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0080'
./main $EXPO6D10M 0.0080 6 0 | grep "RESULT"
echo
./main $EXPO6D10M 0.0080 6 0 | grep "RESULT"
echo
./main $EXPO6D10M 0.0080 6 0 | grep "RESULT"

echo
echo '~~~'
echo

echo '# Super-EGO'
echo '## Epsilon 0.0016'
./main $EXPO6D10M 0.0016 6 3 | grep "RESULT"
echo
./main $EXPO6D10M 0.0016 6 3 | grep "RESULT"
echo
./main $EXPO6D10M 0.0016 6 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0032'
./main $EXPO6D10M 0.0032 6 3 | grep "RESULT"
echo
./main $EXPO6D10M 0.0032 6 3 | grep "RESULT"
echo
./main $EXPO6D10M 0.0032 6 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0048'
./main $EXPO6D10M 0.0048 6 3 | grep "RESULT"
echo
./main $EXPO6D10M 0.0048 6 3 | grep "RESULT"
echo
./main $EXPO6D10M 0.0048 6 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0064'
./main $EXPO6D10M 0.0064 6 3 | grep "RESULT"
echo
./main $EXPO6D10M 0.0064 6 3 | grep "RESULT"
echo
./main $EXPO6D10M 0.0064 6 3 | grep "RESULT"
echo
echo
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
echo '# GPU'
echo '## Epsilon 0.003'
./main $EXPO8D2M 0.003 8 0 | grep "RESULT"
echo
./main $EXPO8D2M 0.003 8 0 | grep "RESULT"
echo
./main $EXPO8D2M 0.003 8 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.006'
./main $EXPO8D2M 0.006 8 0 | grep "RESULT"
echo
./main $EXPO8D2M 0.006 8 0 | grep "RESULT"
echo
./main $EXPO8D2M 0.006 8 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.009'
./main $EXPO8D2M 0.009 8 0 | grep "RESULT"
echo
./main $EXPO8D2M 0.009 8 0 | grep "RESULT"
echo
./main $EXPO8D2M 0.009 8 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.012'
./main $EXPO8D2M 0.012 8 0 | grep "RESULT"
echo
./main $EXPO8D2M 0.012 8 0 | grep "RESULT"
echo
./main $EXPO8D2M 0.012 8 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.015'
./main $EXPO8D2M 0.015 8 0 | grep "RESULT"
echo
./main $EXPO8D2M 0.015 8 0 | grep "RESULT"
echo
./main $EXPO8D2M 0.015 8 0 | grep "RESULT"

echo
echo '~~~'
echo

echo '# Super-EGO'
echo '## Epsilon 0.003'
./main $EXPO8D2M 0.003 8 3 | grep "RESULT"
echo
./main $EXPO8D2M 0.003 8 3 | grep "RESULT"
echo
./main $EXPO8D2M 0.003 8 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.006'
./main $EXPO8D2M 0.006 8 3 | grep "RESULT"
echo
./main $EXPO8D2M 0.006 8 3 | grep "RESULT"
echo
./main $EXPO8D2M 0.006 8 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.009'
./main $EXPO8D2M 0.009 8 3 | grep "RESULT"
echo
./main $EXPO8D2M 0.009 8 3 | grep "RESULT"
echo
./main $EXPO8D2M 0.009 8 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.012'
./main $EXPO8D2M 0.012 8 3 | grep "RESULT"
echo
./main $EXPO8D2M 0.012 8 3 | grep "RESULT"
echo
./main $EXPO8D2M 0.012 8 3 | grep "RESULT"
echo
echo
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
echo '# GPU'
echo '## Epsilon 0.0024'
./main $EXPO8D10M 0.0024 8 0 | grep "RESULT"
echo
./main $EXPO8D10M 0.0024 8 0 | grep "RESULT"
echo
./main $EXPO8D10M 0.0024 8 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0048'
./main $EXPO8D10M 0.0048 8 0 | grep "RESULT"
echo
./main $EXPO8D10M 0.0048 8 0 | grep "RESULT"
echo
./main $EXPO8D10M 0.0048 8 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0072'
./main $EXPO8D10M 0.0072 8 0 | grep "RESULT"
echo
./main $EXPO8D10M 0.0072 8 0 | grep "RESULT"
echo
./main $EXPO8D10M 0.0072 8 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0096'
./main $EXPO8D10M 0.0096 8 0 | grep "RESULT"
echo
./main $EXPO8D10M 0.0096 8 0 | grep "RESULT"
echo
./main $EXPO8D10M 0.0096 8 0 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0120'
./main $EXPO8D10M 0.0120 8 0 | grep "RESULT"
echo
./main $EXPO8D10M 0.0120 8 0 | grep "RESULT"
echo
./main $EXPO8D10M 0.0120 8 0 | grep "RESULT"

echo
echo '~~~'
echo

echo '# Super-EGO'
echo '## Epsilon 0.0024'
./main $EXPO8D10M 0.0024 8 3 | grep "RESULT"
echo
./main $EXPO8D10M 0.0024 8 3 | grep "RESULT"
echo
./main $EXPO8D10M 0.0024 8 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0048'
./main $EXPO8D10M 0.0048 8 3 | grep "RESULT"
echo
./main $EXPO8D10M 0.0048 8 3 | grep "RESULT"
echo
./main $EXPO8D10M 0.0048 8 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0072'
./main $EXPO8D10M 0.0072 8 3 | grep "RESULT"
echo
./main $EXPO8D10M 0.0072 8 3 | grep "RESULT"
echo
./main $EXPO8D10M 0.0072 8 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0096'
./main $EXPO8D10M 0.0096 8 3 | grep "RESULT"
echo
./main $EXPO8D10M 0.0096 8 3 | grep "RESULT"
echo
./main $EXPO8D10M 0.0096 8 3 | grep "RESULT"
echo
echo
echo '## Epsilon 0.0120'
./main $EXPO8D10M 0.0120 8 3 | grep "RESULT"
echo
./main $EXPO8D10M 0.0120 8 3 | grep "RESULT"
echo
./main $EXPO8D10M 0.0120 8 3 | grep "RESULT"
