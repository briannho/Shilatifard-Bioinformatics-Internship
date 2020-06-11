#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Mar  27 3:14:19 2020

@author: BrianHo
"""

import pandas as pd

nontss_clusters = pd.read_csv('gnames_km.tss.txt',delimiter='\t')

merged_peaks = pd.read_csv('merged.tss.peaks.centered.sorted.bed',delimiter='\t',header=None)

genes = []
for gene in nontss_clusters.iloc[:,0]:
	genes.append(gene)

genes2 = []
for gene in merged_peaks.iloc[:,3]:
	genes2.append(gene)


#writes row into new file
newbed = open('figure2cpeaks.tss.bed', 'w')

for gene in genes:
	for gene2 in genes2:
		if gene == gene2:
			i = genes2.index(gene2)
			chromosome = merged_peaks.iat[i,0]
			start = merged_peaks.iat[i,1]
			end = merged_peaks.iat[i,2]
			name = merged_peaks.iat[i,3]
			score = merged_peaks.iat[i,4]
			strand = merged_peaks.iat[i,5]
			row = chromosome+'\t'+str(start)+'\t'+str(end)+'\t'+name+'\t'+str(score)+'\t'+str(strand)+'\n'
			newbed.write(row)
			break

newbed.close()

#checks if bed file is correctly ordered
figure3cpeaks = pd.read_csv('figure2cpeaks.tss.bed',delimiter='\t',header=None)
genes3 = []
for gene in figure3cpeaks.iloc[:,3]:
	genes3.append(gene)

sorted = True
for i in range(len(genes3)):
	if genes[i] != genes3[i]:
		sorted = False
	else:
		continue

if sorted:
	print('Finished.')
else:
	print('Error.')