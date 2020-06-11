#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Mar  2 12:54:24 2020

@author: BrianHo
"""
import pandas as pd

groups = ['DMSO','KL1','KL2']

for group in groups:
    tssgenes = pd.read_csv(group+'_tss.txt',delimiter='\t', header=None)
    gbgenes = pd.read_csv(group+'_gb.txt',delimiter='\t', header=None)
    
    tss_cov = []
    for i in tssgenes.index:
        tss_cov.append(tssgenes.iat[i,6])
        
    gb_cov = []
    for i in gbgenes.index:
        gb_cov.append(gbgenes.iat[i,6])
    
    avg_tss = sum(tss_cov) / len(tss_cov)
    avg_gb = sum(gb_cov) / len(gb_cov)
    pause_index = avg_tss / avg_gb
        
    print(group)
    print('pausing index: ' + str(pause_index))
    print('\n')
