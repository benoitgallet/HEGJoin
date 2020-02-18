#!/usr/bin/python

import numpy as np
import matplotlib.pyplot as plt
import csv
import math
from matplotlib.ticker import FormatStrFormatter
import matplotlib.pyplot as plt
import matplotlib.ticker as mtick


# IMPORT MY LATEX SO I CAN USE \TEXTSC
import matplotlib as mpl
mpl.rc('text', **{'usetex':True})

#


qsortLabel=r'\textsc{qsort 2M}'
qsort_10mLabel=r'\textsc{qsort 10M}'
stableLabel=r'\textsc{stable 2M}'
stable_10mLabel=r'\textsc{stable 10M}'


def getColumn(filename, column):
    results = csv.reader(open(filename), delimiter=",")
    next(results, None)  # skip the headers
    return [result[column] for result in results]



#GPU_K_SuSy = getColumn("Time_vs_K_SuSy_GPU.txt",0)
#GPU_Time_SuSy= getColumn("Time_vs_K_SuSy_GPU.txt",1)
dimension = getColumn("ego_sort.txt", 0)
qsort = getColumn("ego_sort.txt", 1)
qsort_10m = getColumn("ego_sort.txt", 2)
stable = getColumn("ego_sort.txt", 3)
stable_10m = getColumn("ego_sort.txt", 4)



#GPU_K_SuSy=np.asfarray(GPU_K_SuSy,dtype=float)
#GPU_Time_SuSy=np.asfarray(GPU_Time_SuSy,dtype=float)
dimension = np.asfarray(dimension, dtype=float)
qsort = np.asfarray(qsort, dtype=float)
qsort_10m = np.asfarray(qsort_10m, dtype=float)
stable = np.asfarray(stable, dtype=float)
stable_10m = np.asfarray(stable_10m, dtype=float)


#Susy

fig = plt.figure(figsize=(5,3))
ax1 = fig.add_subplot(111)

# We change the fontsize of minor ticks label
ax1.tick_params(which='major', labelsize=20)
# plt.yticks(np.arange(0.0, 10.0, 5))
# ax1.set_yscale("log")

#ax1.plot(GPU_K_SuSy, GPU_Time_SuSy, ls='-',   c='red', marker='o', markersize=10, linewidth=4, label=gpu)
ax1.plot(dimension, qsort, ls='-', c='black', marker='^', markersize=10, linewidth=4, label=qsortLabel)
ax1.plot(dimension, qsort_10m, ls='-', c='red', marker='v', markersize=10, linewidth=4, label=qsort_10mLabel)
ax1.plot(dimension, stable, ls='-', c='darkorange', marker='s', markersize=10, linewidth=4, label=stableLabel)
ax1.plot(dimension, stable_10m, ls='-', c='dodgerblue', marker='o', markersize=10, linewidth=4, label=stable_10mLabel)

#turn off scientific notation
# plt.ticklabel_format(useOffset=False)

ax1.set_ylim(0.0, 10.0)

ax1.set_xticks(dimension)

ax1.set_xlabel(r'Dimensionality', fontsize=18)
ax1.set_ylabel('Time (s)', fontsize=18)

ax1.legend(fontsize=12, loc="center right", fancybox=False, framealpha=1, handlelength=2, ncol=1)

plt.tight_layout()
print("Saving figure: ego_sort.pdf")
fig.savefig("figures/ego_sort.pdf", bbox_inches='tight')
