#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Mar  31 3:18:17 2020

@author: BrianHo
"""

import pandas as pd

genes = pd.read_csv('figure2fgenes.bed', delimiter='\t')

tss = genes.copy()

for i in tss.index:
    if tss.iat[i,5] == '-':
        tss.iat[i,1] = tss.iat[i,2] - 500
    elif tss.iat[i,5] == '+':
        tss.iat[i,2] = tss.iat[i,1] + 500

print(tss.iloc[0:2,:])
tss = tss.iloc[:,0:6]
tss.to_csv('figure3h.tss.bed', sep='\t', index=False, header=False)

print('Finished.')
