#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jan 18 16:03:48 2022

@author: sakkol
"""

import matplotlib.pyplot as plt
from matplotlib import cm
from scipy.io import savemat
import numpy as np


allnames = plt.colormaps()

allmaps=list()
savenames=list()
for s in allnames:
    xxx=cm.get_cmap(s,256)
    if not hasattr(xxx,'colors'):
        zzz=[]
        for z in range(256):
            mmm=xxx(z)
            mmm=np.asarray(mmm)
            mmm=np.delete(mmm,3)
            zzz.append(mmm)
        allmaps.append(zzz.copy())
    else:
        zzz=xxx.colors
        zzz=np.delete(zzz,3,axis=1)
        allmaps.append(zzz.copy())
    savenames.append(s)

savemat('/home/sakkol/Documents/Codes_git/PyColormap4Matlab/listCMapNames.mat',{'allmaps':allmaps,'savenames':savenames})