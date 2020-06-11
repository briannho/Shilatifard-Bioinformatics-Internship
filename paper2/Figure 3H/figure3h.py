#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Mar  31 3:27:56 2020

@author: BrianHo
"""

import pandas as pd 

tssregions = pd.read_csv('figure3h.tss.bed', delimiter='\t')
bedgraph_minus = pd.read_csv('DMSO_PRO.minus.bedgraph', delimiter='\t')
bedgraph_plus = pd.read_csv('DMSO_PRO.plus.bedgraph', delimiter='\t')

pausingsites = open('figure3h.pausingsites.bed', 'w')
print('Finished loading dataframes.')

for i in tssregions.index:

	chromosome = tssregions.iat[i,0]
	start = tssregions.iat[i,1]
	end = tssregions.iat[i,2]
	name = tssregions.iat[i,3]
	strand = tssregions.iat[i,5]
	
	max_coverage = 0

	print('processing row' + ' ' + str(i))

	if strand == '+':
		
		for j in bedgraph_plus.index:

			chromosome_bedg = bedgraph_plus.iat[j,0]

			if chromosome_bedg == chromosome:

				start_bg = bedgraph_plus.iat[j,1]
				end_bg = bedgraph_plus.iat[j,2]

				if start_bg >= start and end_bg <= end:

					coverage = bedgraph_plus.iat[j,3]

					if coverage > max_coverage:

						max_coverage = coverage
						max_index = j
						continue

				#positions not within tss region
				else:
					continue

			#chromosome not the same
			else:
				continue

		max_start = bedgraph_plus.iat[max_index,1]
		max_end = bedgraph_plus.iat[max_index,2]
		row = chromosome+'\t'+str(max_start)+'\t'+str(max_end)+'\t'+name+'\t'+str(max_coverage)+'\t'+str(strand)+'\n'
		pausingsites.write(row)


	elif strand  == '-':
		
		for j in bedgraph_minus.index:

			chromosome_bedg = bedgraph_minus.iat[j,0]

			if chromosome_bedg == chromosome:

				start_bg = bedgraph_minus.iat[j,1]
				end_bg = bedgraph_minus.iat[j,2]

				if start_bg >= start and end_bg <= end:

					coverage = abs(bedgraph_minus.iat[j,3])

					if coverage > max_coverage:

						max_coverage = coverage
						max_index = j
						continue

				#positions not within tss region
				else:
					continue

			#chromosome not the same
			else:
				continue

		max_start = bedgraph_minus.iat[max_index,1]
		max_end = bedgraph_minus.iat[max_index,2]
		row = chromosome+'\t'+str(max_start)+'\t'+str(max_end)+'\t'+name+'\t'+str(max_coverage)+'\t'+str(strand)+'\n'
		pausingsites.write(row)

pausingsites.close()
print('Finished.')


