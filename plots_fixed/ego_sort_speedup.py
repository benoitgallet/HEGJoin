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


speedup2mLabel=r'\textsc{Parallel Boost sample\_sort 2M}'
speedup10mLabel=r'\textsc{Parallel Boost sample\_sort 10M}'


def getColumn(filename, column):
    results = csv.reader(open(filename), delimiter=",")
    next(results, None)  # skip the headers
    return [result[column] for result in results]



#GPU_K_SuSy = getColumn("Time_vs_K_SuSy_GPU.txt",0)
#GPU_Time_SuSy= getColumn("Time_vs_K_SuSy_GPU.txt",1)
dimension = getColumn("ego_sort.txt", 0)
speedup2m = getColumn("ego_sort.txt", 5)
speedup10m = getColumn("ego_sort.txt", 6)



#GPU_K_SuSy=np.asfarray(GPU_K_SuSy,dtype=float)
#GPU_Time_SuSy=np.asfarray(GPU_Time_SuSy,dtype=float)
dimension = np.asfarray(dimension, dtype=float)
speedup2m = np.asfarray(speedup2m, dtype=float)
speedup10m = np.asfarray(speedup10m, dtype=float)


#Susy

fig = plt.figure(figsize=(5,3))
ax1 = fig.add_subplot(111)

# We change the fontsize of minor ticks label
ax1.tick_params(which='major', labelsize=20)
# plt.yticks(np.arange(0.0, 10.0, 5))
# ax1.set_yscale("log")

#ax1.plot(GPU_K_SuSy, GPU_Time_SuSy, ls='-',   c='red', marker='o', markersize=10, linewidth=4, label=gpu)
ax1.plot(dimension, speedup10m, ls='-', c='dodgerblue', marker='^', markersize=10, linewidth=4, label=speedup10mLabel)
ax1.plot(dimension, speedup2m, ls='-', c='red', marker='v', markersize=10, linewidth=4, label=speedup2mLabel)


#turn off scientific notation
# plt.ticklabel_format(useOffset=False)

ax1.set_ylim(6.0, 12.0)

ax1.set_xticks(dimension)

ax1.set_xlabel(r'Dimensionality', fontsize=18)
ax1.set_ylabel('Speedup', fontsize=18)

ax1.legend(fontsize=13, loc="best", fancybox=False, framealpha=1, handlelength=2, ncol=1)

plt.tight_layout()
print("Saving figure: ego_sort_speedup.pdf")
fig.savefig("figures/ego_sort_speedup.pdf", bbox_inches='tight')
