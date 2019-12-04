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


gpuLabel=r'\textsc{LBJoin}'
egoLabel=r'\textsc{Super-EGO}'
heteroLabel=r'\textsc{HEGO}'



def getColumn(filename, column):
    results = csv.reader(open(filename), delimiter=",")
    next(results, None)  # skip the headers
    return [result[column] for result in results]



#GPU_K_SuSy = getColumn("Time_vs_K_SuSy_GPU.txt",0)
#GPU_Time_SuSy= getColumn("Time_vs_K_SuSy_GPU.txt",1)
epsilon = getColumn("sw2db.txt", 0)
gpu = getColumn("sw2db.txt", 1)
ego = getColumn("sw2db.txt", 3)
hybrid = getColumn("sw2db.txt", 2)



#GPU_K_SuSy=np.asfarray(GPU_K_SuSy,dtype=float)
#GPU_Time_SuSy=np.asfarray(GPU_Time_SuSy,dtype=float)
epsilon = np.asfarray(epsilon, dtype=float)
gpu = np.asfarray(gpu, dtype=float)
ego = np.asfarray(ego, dtype=float)
hybrid = np.asfarray(hybrid, dtype=float)


#Susy

fig = plt.figure(figsize=(5,3))
ax1 = fig.add_subplot(111)

# We change the fontsize of minor ticks label
ax1.tick_params(which='major', labelsize=20)

#ax1.plot(GPU_K_SuSy, GPU_Time_SuSy, ls='-',   c='red', marker='o', markersize=10, linewidth=4, label=gpu)
ax1.plot(epsilon, gpu, ls='-', c='red', marker='o', markersize=10, linewidth=4, label=gpuLabel)
ax1.plot(epsilon, ego, ls='-', c='orange', marker='^', markersize=10, linewidth=4, label=egoLabel)
ax1.plot(epsilon, hybrid, ls='-', c='dodgerblue', marker='v', markersize=10, linewidth=4, label=heteroLabel)

#turn off scientific notation
plt.ticklabel_format(useOffset=False)

ax1.set_ylim(0,30)

ax1.set_xticks(epsilon)

ax1.set_xlabel(r'$\epsilon$', fontsize=18)
ax1.set_ylabel('Time (s)', fontsize=18)

ax1.legend(fontsize=14, loc='upper left', fancybox=False, framealpha=1, handlelength=2, ncol=1)

plt.tight_layout()
print("Saving figure: sw2db.pdf")
fig.savefig("sw2db.pdf", bbox_inches='tight')
