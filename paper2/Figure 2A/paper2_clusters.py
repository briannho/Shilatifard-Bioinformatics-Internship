#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Mar  4 11:57:30 2020

@author: BrianHo
"""

import pandas as pd

data = pd.read_csv('gnames_km.txt',delimiter='\t')

genes = []

for gene in data.iloc[:,1]:
    genes.append(gene)

count = 0
for i in range(len(genes)):
    if genes[i] < genes[i-1] and i != 0:
        print(count)
        count = 1
    else:
        count+=1
print(count)
        
	
