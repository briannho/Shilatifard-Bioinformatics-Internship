#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Feb 28 12:48:23 2020

@author: BrianHo
"""
import pandas as pd

genes = pd.read_csv('figure2bgenes.sorted.bed',delimiter='\t', header=None)
#genes = pd.read_csv('figure2btrans.sorted.bed',delimiter='\t', header=None)

#remove genes shorter than 2kb
print('Removing genes shorter than 2kb.')
print(len(genes))
count=0
remove_genes = []


for i in genes.index:
    start = genes.iat[i,1]
    end = genes.iat[i,2]
    dist = end - start
    if abs(dist) < 2000:
        count += 1
        remove_genes.append(i)
        
print('count: ' + str(count))
genes = genes.drop(remove_genes)
print(len(genes))

genes = genes.reset_index(drop=True)

#remove overlapping genes
print('\nRemoving overlapping genes')
remove_genes = []
count = 0
for i in genes.index:
    
    if i == 0:
        pass
    
    else:
        gene_start = genes.iat[i,1]
        gene_end = genes.iat[i,2]
        prev_start = genes.iat[i-1, 1]
        prev_end = genes.iat[i-1,2]
        
        if gene_start >= prev_start and gene_start <= prev_end:
            count+=1
            remove_genes.append(i)
            
        elif gene_end >= prev_start and gene_end <= prev_end:
            count+=1
            remove_genes.append(i)
            remove_genes.append(i-1)
        
print('count: ' + str(count))
genes = genes.drop(remove_genes)
genes = genes.reset_index(drop=True)
print(len(genes))

#remove genes that are less than 2kb away from the nearest gene
print('\nRemoving genes that are less than 2kb away from adjacent genes.')

print(len(genes))
count = 10000
while count !=0:
    if count == 0: 
        break
    else:
        
        remove_genes = []
        count = 0
        
        for i in genes.index:
            if i == len(genes) - 1 or i == 0:
                pass
            
            else:
                gene_start = genes.iat[i,1]
                gene_end = genes.iat[i,2]
                gene_next = genes.iat[i+1,1]
                gene_prev = genes.iat[i-1,2]
                
                dist1 = gene_end - gene_next
                dist2 = gene_start - gene_prev
                
                if abs(dist1) >= 2000 and abs(dist2) >= 2000:
                    pass
                
                else:
                    count +=1
                    remove_genes.append(i)
        
        print('count: ' + str(count))
        genes = genes.drop(remove_genes)
        genes = genes.reset_index(drop=True)
        print(len(genes))       

genes.to_csv('figure2bgenes.filtered.bed', sep='\t', index=False, header=False)

print('Finished.')