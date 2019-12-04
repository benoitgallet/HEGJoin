#!/bin/bash

SDSS="~/datasets/2d/sdss_2d_15m_normalized.txt"

echo '~ SDSS2D15M'
echo '# GPU'
echo '## Epsilon 0.000055556'
./main $SDSS 0.000055556 2 0 | grep "RESULT"
./main $SDSS 0.000055556 2 0 | grep "RESULT"
./main $SDSS 0.000055556 2 0 | grep "RESULT"
echo
echo '## Epsilon 0.000111111'
./main $SDSS 0.000111111 2 0 | grep "RESULT"
./main $SDSS 0.000111111 2 0 | grep "RESULT"
./main $SDSS 0.000111111 2 0 | grep "RESULT"
echo
echo '## Epsilon 0.000166667'
./main $SDSS 0.000166667 2 0 | grep "RESULT"
./main $SDSS 0.000166667 2 0 | grep "RESULT"
./main $SDSS 0.000166667 2 0 | grep "RESULT"
echo
echo '## Epsilon 0.000222222'
./main $SDSS 0.000222222 2 0 | grep "RESULT"
./main $SDSS 0.000222222 2 0 | grep "RESULT"
./main $SDSS 0.000222222 2 0 | grep "RESULT"
echo
echo '## Epsilon 0.000277778'
./main $SDSS 0.000277778 2 0 | grep "RESULT"
./main $SDSS 0.000277778 2 0 | grep "RESULT"
./main $SDSS 0.000277778 2 0 | grep "RESULT"

echo
echo '----------'
echo

echo '# Hybrid'
echo '## Epsilon 0.000055556'
./main $SDSS 0.000055556 2 1 | grep "RESULT"
./main $SDSS 0.000055556 2 1 | grep "RESULT"
./main $SDSS 0.000055556 2 1 | grep "RESULT"
echo
echo '## Epsilon 0.000111111'
./main $SDSS 0.000111111 2 1 | grep "RESULT"
./main $SDSS 0.000111111 2 1 | grep "RESULT"
./main $SDSS 0.000111111 2 1 | grep "RESULT"
echo
echo '## Epsilon 0.000166667'
./main $SDSS 0.000166667 2 1 | grep "RESULT"
./main $SDSS 0.000166667 2 1 | grep "RESULT"
./main $SDSS 0.000166667 2 1 | grep "RESULT"
echo
echo '## Epsilon 0.000222222'
./main $SDSS 0.000222222 2 1 | grep "RESULT"
./main $SDSS 0.000222222 2 1 | grep "RESULT"
./main $SDSS 0.000222222 2 1 | grep "RESULT"
echo
echo '## Epsilon 0.000277778'
./main $SDSS 0.000277778 2 1 | grep "RESULT"
./main $SDSS 0.000277778 2 1 | grep "RESULT"
./main $SDSS 0.000277778 2 1 | grep "RESULT"

echo
echo '----------'
echo

echo '# Super-EGO'
echo '## Epsilon 0.000055556'
./main $SDSS 0.000055556 2 2 | grep "RESULT"
./main $SDSS 0.000055556 2 2 | grep "RESULT"
./main $SDSS 0.000055556 2 2 | grep "RESULT"
echo
echo '## Epsilon 0.000111111'
./main $SDSS 0.000111111 2 2 | grep "RESULT"
./main $SDSS 0.000111111 2 2 | grep "RESULT"
./main $SDSS 0.000111111 2 2 | grep "RESULT"
echo
echo '## Epsilon 0.000166667'
./main $SDSS 0.000166667 2 2 | grep "RESULT"
./main $SDSS 0.000166667 2 2 | grep "RESULT"
./main $SDSS 0.000166667 2 2 | grep "RESULT"
echo
echo '## Epsilon 0.000222222'
./main $SDSS 0.000222222 2 2 | grep "RESULT"
./main $SDSS 0.000222222 2 2 | grep "RESULT"
./main $SDSS 0.000222222 2 2 | grep "RESULT"
echo
echo '## Epsilon 0.000277778'
./main $SDSS 0.000277778 2 2 | grep "RESULT"
./main $SDSS 0.000277778 2 2 | grep "RESULT"
./main $SDSS 0.000277778 2 2 | grep "RESULT"
