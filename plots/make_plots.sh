#!/bin/bash

parallel python3 ::: delta_2m.py delta_10m.py ego_sort.py
parallel python3 ::: expo2d2m.py expo3d2m.py expo4d2m.py expo6d2m.py expo8d2m.py
parallel python3 ::: expo2d10m.py expo3d10m.py expo4d10m.py expo6d10m.py expo8d10m.py
parallel python3 ::: sw2da.py sw2db.py sw3da.py sw3db.py
parallel python3 ::: sw2da_ego.py sw2db_ego.py sw3da_ego.py sw3db_ego.py

mv *.pdf figures/
