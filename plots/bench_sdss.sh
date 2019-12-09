#!/bin/bash

SDSS="~/datasets/2d/sdss_2d_15m_normalized.txt"

echo '~ SDSS2D15M'
echo '# GPU'
echo '## Epsilon 0.0004'
./main $SDSS 0.0004 2 0 | grep "RESULT"
./main $SDSS 0.0004 2 0 | grep "RESULT"
./main $SDSS 0.0004 2 0 | grep "RESULT"
echo
echo '## Epsilon 0.0008'
./main $SDSS 0.0008 2 0 | grep "RESULT"
./main $SDSS 0.0008 2 0 | grep "RESULT"
./main $SDSS 0.0008 2 0 | grep "RESULT"
echo
echo '## Epsilon 0.0012'
./main $SDSS 0.0012 2 0 | grep "RESULT"
./main $SDSS 0.0012 2 0 | grep "RESULT"
./main $SDSS 0.0012 2 0 | grep "RESULT"
echo
echo '## Epsilon 0.0016'
./main $SDSS 0.0016 2 0 | grep "RESULT"
./main $SDSS 0.0016 2 0 | grep "RESULT"
./main $SDSS 0.0016 2 0 | grep "RESULT"
echo
echo '## Epsilon 0.0020'
./main $SDSS 0.0020 2 0 | grep "RESULT"
./main $SDSS 0.0020 2 0 | grep "RESULT"
./main $SDSS 0.0020 2 0 | grep "RESULT"

echo
echo

echo '# Hybrid'
echo '## Epsilon 0.0004'
./main $SDSS 0.0004 2 1 | grep "RESULT"
./main $SDSS 0.0004 2 1 | grep "RESULT"
./main $SDSS 0.0004 2 1 | grep "RESULT"
echo
echo '## Epsilon 0.0008'
./main $SDSS 0.0008 2 1 | grep "RESULT"
./main $SDSS 0.0008 2 1 | grep "RESULT"
./main $SDSS 0.0008 2 1 | grep "RESULT"
echo
echo '## Epsilon 0.0012'
./main $SDSS 0.0012 2 1 | grep "RESULT"
./main $SDSS 0.0012 2 1 | grep "RESULT"
./main $SDSS 0.0012 2 1 | grep "RESULT"
echo
echo '## Epsilon 0.0016'
./main $SDSS 0.0016 2 1 | grep "RESULT"
./main $SDSS 0.0016 2 1 | grep "RESULT"
./main $SDSS 0.0016 2 1 | grep "RESULT"
echo
echo '## Epsilon 0.0020'
./main $SDSS 0.0020 2 1 | grep "RESULT"
./main $SDSS 0.0020 2 1 | grep "RESULT"
./main $SDSS 0.0020 2 1 | grep "RESULT"

echo
echo

echo '# Super-EGO'
echo '## Epsilon 0.0004'
./main $SDSS 0.0004 2 2 | grep "RESULT"
./main $SDSS 0.0004 2 2 | grep "RESULT"
./main $SDSS 0.0004 2 2 | grep "RESULT"
echo
echo '## Epsilon 0.0008'
./main $SDSS 0.0008 2 2 | grep "RESULT"
./main $SDSS 0.0008 2 2 | grep "RESULT"
./main $SDSS 0.0008 2 2 | grep "RESULT"
echo
echo '## Epsilon 0.0012'
./main $SDSS 0.0012 2 2 | grep "RESULT"
./main $SDSS 0.0012 2 2 | grep "RESULT"
./main $SDSS 0.0012 2 2 | grep "RESULT"
echo
echo '## Epsilon 0.0016'
./main $SDSS 0.0016 2 2 | grep "RESULT"
./main $SDSS 0.0016 2 2 | grep "RESULT"
./main $SDSS 0.0016 2 2 | grep "RESULT"
echo
echo '## Epsilon 0.0020'
./main $SDSS 0.0020 2 2 | grep "RESULT"
./main $SDSS 0.0020 2 2 | grep "RESULT"
./main $SDSS 0.0020 2 2 | grep "RESULT"
