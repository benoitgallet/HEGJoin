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


minLabel=r'\textsc{Minimum}'
maxLabel=r'\textsc{Maximum}'
avgLabel=r'\textsc{Average}'


def getColumn(filename, column):
    results = csv.reader(open(filename), delimiter=",")
    next(results, None)  # skip the headers
    return [result[column] for result in results]



#GPU_K_SuSy = getColumn("Time_vs_K_SuSy_GPU.txt",0)
#GPU_Time_SuSy= getColumn("Time_vs_K_SuSy_GPU.txt",1)
dimension = getColumn("delta_2m.txt", 0)
avg = getColumn("delta_2m.txt", 1)
min = getColumn("delta_2m.txt", 2)
max = getColumn("delta_2m.txt", 3)



#GPU_K_SuSy=np.asfarray(GPU_K_SuSy,dtype=float)
#GPU_Time_SuSy=np.asfarray(GPU_Time_SuSy,dtype=float)
dimension = np.asfarray(dimension, dtype=float)
avg = np.asfarray(avg, dtype=float)
min = np.asfarray(min, dtype=float)
max = np.asfarray(max, dtype=float)


#Susy

fig = plt.figure(figsize=(5,3))
ax1 = fig.add_subplot(111)

# We change the fontsize of minor ticks label
ax1.tick_params(which='major', labelsize=20)
plt.yticks(np.arange(0.0, 10.0, 5))
ax1.set_yscale("log")

#ax1.plot(GPU_K_SuSy, GPU_Time_SuSy, ls='-',   c='red', marker='o', markersize=10, linewidth=4, label=gpu)
ax1.plot(dimension, max, ls='-', c='black', marker='^', markersize=10, linewidth=4, label=maxLabel)
ax1.plot(dimension, avg, ls=':', c='black', marker='x', markersize=10, linewidth=4, label=avgLabel)
ax1.plot(dimension, min, ls='-', c='black', marker='v', markersize=10, linewidth=4, label=minLabel)

#turn off scientific notation
# plt.ticklabel_format(useOffset=False)

ax1.set_ylim(0.0, 10.0)

ax1.set_xticks(dimension)

ax1.set_xlabel(r'Dimensionality', fontsize=18)
ax1.set_ylabel('Time (s)', fontsize=18)

ax1.legend(fontsize=14, loc='upper left', fancybox=False, framealpha=1, handlelength=2, ncol=1)

plt.tight_layout()
print("Saving figure: delta_2m.pdf")
fig.savefig("delta_2m.pdf", bbox_inches='tight')
