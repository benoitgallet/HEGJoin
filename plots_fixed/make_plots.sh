#!/bin/bash

# parallel python3 ::: time_ratios_2m.py time_ratios_10m.py ego_sort.py ego_sort_speedup.py ego_speedup.py
parallel python3 ::: expo2d2m.py expo3d2m.py expo4d2m.py expo6d2m.py expo8d2m.py
parallel python3 ::: expo2d10m.py expo3d10m.py expo4d10m.py expo6d10m.py expo8d10m.py
parallel python3 ::: sw2da.py sw2db.py sw3da.py sw3db.py sdss2db.py gaia50m.py osm50m.py

# mv *.pdf figures/
