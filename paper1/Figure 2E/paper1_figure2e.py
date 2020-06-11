#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thurs Mar 05 01:24:40 2020

@author: BrianHo
"""

import pandas as pd

genes = pd.read_csv('figure2fgenes.bed',delimiter='\t')
# genes = genes.iloc[1:,0:6] #fix this
print(genes.iloc[0,:])
#numerator of pausing index - transcription start site
tss = genes.copy()

for i in tss.index:
    if tss.iat[i,5] == '-':
        tss.iat[i,1] = tss.iat[i,2] - 400
        tss.iat[i,2] = tss.iat[i,2] + 200
    elif tss.iat[i,5] == '+':
        tss.iat[i,2] = tss.iat[i,1] + 400
        tss.iat[i,1] = tss.iat[i,1] - 200

print(tss.iloc[0:2,:])
tss = tss.iloc[:,0:6]
tss.to_csv('tssgenes.bed', sep='\t', index=False, header=False)

#denominator of pausing index - genebody
gb = genes.copy()

for i in gb.index:
    if gb.iat[i,5] == '-':
        gb.iat[i,2] = gb.iat[i,2] - 401
    elif gb.iat[i,5] == '+':
        gb.iat[i,1] = gb.iat[i,1] + 401
        
print(gb.iloc[0:2,:])
gb = gb.iloc[:,0:6]
gb.to_csv('gbgenes.bed', sep='\t', index=False, header=False)

print('Finished.')
