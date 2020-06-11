#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Mar  4 11:57:30 2020

@author: BrianHo
"""

import pandas as pd

groups = ['ESR1_WTD','ESR1_WTE','ESR1_T2D','ESR1_T2E']

for group in groups:
    
    data = pd.read_csv(group+'.macsPeaks.anno.txt',delimiter='\t')
    
#    print(data.iloc[0,:])

    print('Processing '+group)
    tss_file = open(group+'.macsPeaks.tss.bed', 'w')
    nontss_file = open(group+'.macsPeaks.nontss.bed', 'w')
    
    all_tss = open('alltss.peaks.bed', 'a+')
    all_nontss = open('allnontss.peaks.bed', 'a+')
    
    for i in data.index:
        dist = data.iat[i,9]
        if abs(dist) <= 1000:
            chromosome = data.iat[i,1]
            start = data.iat[i,2]
            end = data.iat[i,3]
            peakID = data.iat[i,0]
            score = data.iat[i,5]
            strand = data.iat[i,4] 
            tss_file.write(chromosome+'\t'+str(start)+'\t'+str(end)+'\t'+peakID+'\t'+str(score)+'\t'+str(strand)+'\n')
            all_tss.write(chromosome+'\t'+str(start)+'\t'+str(end)+'\t'+peakID+'\t'+str(score)+'\t'+str(strand)+'\n')
        else:
            chromosome = data.iat[i,1]
            start = data.iat[i,2]
            end = data.iat[i,3]
            peakID = data.iat[i,0]
            score = data.iat[i,5] 
            strand = data.iat[i,4]
            nontss_file.write(chromosome+'\t'+str(start)+'\t'+str(end)+'\t'+peakID+'\t'+str(score)+'\t'+str(strand)+'\n')
            all_nontss.write(chromosome+'\t'+str(start)+'\t'+str(end)+'\t'+peakID+'\t'+str(score)+'\t'+str(strand)+'\n')
    
    tss_file.close()
    nontss_file.close()
    all_tss.close()
    all_nontss.close()
    print('\n')

print('Finished.')


    