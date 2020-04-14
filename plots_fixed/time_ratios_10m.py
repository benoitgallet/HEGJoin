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


# twoMLabel=r'\textsc{2M queries}'
# tenMLabel=r'\textsc{10M queries}'
# min2mLabel=r'\textsc{Min.}'
# avg2mLabel=r'\textsc{Avg.}'
# max2mLabel=r'\textsc{Max.}'
min10mLabel=r'\textsc{Min.}'
avg10mLabel=r'\textsc{Avg.}'
max10mLabel=r'\textsc{Max.}'


def getColumn(filename, column):
    results = csv.reader(open(filename), delimiter=",")
    next(results, None)  # skip the headers
    return [result[column] for result in results]



#GPU_K_SuSy = getColumn("Time_vs_K_SuSy_GPU.txt",0)
#GPU_Time_SuSy= getColumn("Time_vs_K_SuSy_GPU.txt",1)
dimension = getColumn("time_ratios.txt", 0)
# min2m = getColumn("time_ratios.txt", 1)
# avg2m = getColumn("time_ratios.txt", 2)
# max2m = getColumn("time_ratios.txt", 3)
min10m = getColumn("time_ratios.txt", 4)
avg10m = getColumn("time_ratios.txt", 5)
max10m = getColumn("time_ratios.txt", 6)



#GPU_K_SuSy=np.asfarray(GPU_K_SuSy,dtype=float)
#GPU_Time_SuSy=np.asfarray(GPU_Time_SuSy,dtype=float)
dimension = np.asfarray(dimension, dtype=float)
# min2m = np.asfarray(min2m, dtype=float)
# avg2m = np.asfarray(avg2m, dtype=float)
# max2m = np.asfarray(max2m, dtype=float)
min10m = np.asfarray(min10m, dtype=float)
avg10m = np.asfarray(avg10m, dtype=float)
max10m = np.asfarray(max10m, dtype=float)



#Susy

fig = plt.figure(figsize=(5,2.75))
ax1 = fig.add_subplot(111)

# We change the fontsize of minor ticks label
ax1.tick_params(which='major', labelsize=20)
# plt.yticks(np.arange(0.0, 10.0, 5))
# ax1.set_yscale("log")

#ax1.plot(GPU_K_SuSy, GPU_Time_SuSy, ls='-',   c='red', marker='o', markersize=10, linewidth=4, label=gpu)
# ax1.plot(dimension, twoM, ls='-', c='red', marker='x', markersize=10, linewidth=4, label=twoMLabel)
# ax1.plot(dimension, tenM, ls='-', c='dodgerblue', marker='v', markersize=10, linewidth=4, label=tenMLabel)
# ax1.plot(dimension, min2m, ls='-', c='darkred', marker='v', markersize=10, linewidth=4, label=min2mLabel)
# ax1.plot(dimension, avg2m, ls='-.', c='darkorange', marker='D', markersize=10, linewidth=4, label=avg2mLabel)
# ax1.plot(dimension, max2m, ls='-', c='dodgerblue', marker='^', markersize=10, linewidth=4, label=max2mLabel)
ax1.plot(dimension, min10m, ls='-', c='darkred', marker='v', markersize=10, linewidth=4, label=min10mLabel)
ax1.plot(dimension, avg10m, ls='-.', c='darkorange', marker='D', markersize=10, linewidth=4, label=avg10mLabel)
ax1.plot(dimension, max10m, ls='-', c='dodgerblue', marker='^', markersize=10, linewidth=4, label=max10mLabel)

#turn off scientific notation
# plt.ticklabel_format(useOffset=False)

ax1.set_ylim(0.0, 1.0)

ax1.set_xticks(dimension)

ax1.set_xlabel(r'Dimensionality', fontsize=18)
ax1.set_ylabel('Load Imbalance Ratio', fontsize=17)

ax1.legend(fontsize=15, loc='upper left', fancybox=False, framealpha=1, handlelength=2, ncol=2)

plt.tight_layout()
print("Saving figure: time_ratios_10m.pdf")
fig.savefig("figures/time_ratios_10m.pdf", bbox_inches='tight')
