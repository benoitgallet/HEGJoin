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


sw2daLabel=r'\textsc{SW2DA}'
sw2dbLabel=r'\textsc{SW2DB}'
sw3daLabel=r'\textsc{SW3DA}'
sw3dbLabel=r'\textsc{SW3DB}'
avgLabel=r'\textsc{Avg.}'



def getColumn(filename, column):
    results = csv.reader(open(filename), delimiter=",")
    next(results, None)  # skip the headers
    return [result[column] for result in results]



#GPU_K_SuSy = getColumn("Time_vs_K_SuSy_GPU.txt",0)
#GPU_Time_SuSy= getColumn("Time_vs_K_SuSy_GPU.txt",1)
sw2da = getColumn("ego_speedup.txt", 0)
sw2db = getColumn("ego_speedup.txt", 1)
sw3da = getColumn("ego_speedup.txt", 2)
sw3db = getColumn("ego_speedup.txt", 3)
sw2daEps = getColumn("sw2da.txt", 0)
sw2dbEps = getColumn("sw2db.txt", 0)
sw3daEps = getColumn("sw3da.txt", 0)
sw3dbEps = getColumn("sw3db.txt", 0)



#GPU_K_SuSy=np.asfarray(GPU_K_SuSy,dtype=float)
#GPU_Time_SuSy=np.asfarray(GPU_Time_SuSy,dtype=float)
sw2da = np.asfarray(sw2da, dtype=float)
sw2db = np.asfarray(sw2db, dtype=float)
sw3da = np.asfarray(sw3da, dtype=float)
sw3db = np.asfarray(sw3db, dtype=float)
sw2daEps = np.asfarray(sw2daEps, dtype=float)
sw2dbEps = np.asfarray(sw2dbEps, dtype=float)
sw3daEps = np.asfarray(sw3daEps, dtype=float)
sw3dbEps = np.asfarray(sw3dbEps, dtype=float)


#Susy

fig = plt.figure(figsize=(5,3))
ax1 = fig.add_subplot(111)

# We change the fontsize of minor ticks label
ax1.tick_params(which='major', labelsize=20)
ax1.set_xscale("log")
# plt.yticks(np.arange(0.0, 10.0, 5))
# ax1.set_yscale("log")

#ax1.plot(GPU_K_SuSy, GPU_Time_SuSy, ls='-',   c='red', marker='o', markersize=10, linewidth=4, label=gpu)
ax1.plot(sw2daEps, sw2da, ls='-', c='black', marker='^', markersize=10, linewidth=4, label=sw2daLabel)
ax1.plot(sw2dbEps, sw2db, ls='-', c='red', marker='v', markersize=10, linewidth=4, label=sw2dbLabel)
ax1.plot(sw3daEps, sw3da, ls='-', c='purple', marker='s', markersize=10, linewidth=4, label=sw3daLabel)
ax1.plot(sw3dbEps, sw3db, ls='-', c='dodgerblue', marker='o', markersize=10, linewidth=4, label=sw3dbLabel)

#turn off scientific notation
# plt.ticklabel_format(useOffset=False)

ax1.set_ylim(0.0, 4.0)

ax1.axhline(y = 1.97, ls='-', c='darkorange', linewidth=2, label=avgLabel)
ax1.axhline(y = 1, ls='--', c='black', linewidth=2)

# ax1.set_xticks(dimension)

ax1.set_xlabel(r'$\epsilon$', fontsize=18)
ax1.set_ylabel('Speedup', fontsize=18)

ax1.legend(fontsize=12, loc="upper left", fancybox=False, framealpha=1, handlelength=2, ncol=3)

plt.tight_layout()
print("Saving figure: ego_speedup.pdf")
fig.savefig("figures/ego_speedup.pdf", bbox_inches='tight')
