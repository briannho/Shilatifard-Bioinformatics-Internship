# TODO
# figure 3h
# 	write script to output bed files containing the pausing sites of genes where max coverage is based on bedgraph file with the tss region bed file
# 	run computematrix and plotheatmap and hope for the best

############
#FIGURE 2b
############

#get bed file
intersectBed -wa -a hg19.Ens_75.genes.bed -b PolII_DMSO.macsPeaks.bed PolII_KL1.macsPeaks.bed PolII_KL2.macsPeaks.bed | sort | uniq > figure2bgenes.bed
sort -k1,1 -k2,2n figure2bgenes.bed > figure2bgenes.sorted.bed
python3 paper1_figure2b.py #outputs figure2b.filtered.bed

#VISUALIZATION
#get the top 6119 genes --might actually take top 3000 instead
computeMatrix reference-point -R figure2bgenes.filtered.bed -S GSM3073977_PolII_DMSO_293T_rep1.bw GSM3073962_PolII_522_293T_rep1.bw GSM3073950_PolII_468_293T_rep1.bw -a 1000 -b 1000 -o matrix_figure2b --outFileSortedRegions figure2bgenes.sortedregions.bed --sortRegions descend -p 15 &

#uses only sorting based on control sample
computeMatrix reference-point -R figure2bgenes.filtered.bed -S GSM3073977_PolII_DMSO_293T_rep1.bw -a 1000 -b 1000 -o matrix_figure2b --outFileSortedRegions figure2bgenes.sortedregions.bed --sortRegions descend -p 15 &

head -6120 figure2bgenes.sortedregions.bed > figure2bgenes.topgenes.6119.bed &

#visualize
computeMatrix reference-point -R figure2bgenes.topgenes.6119.bed -S GSM3073977_PolII_DMSO_293T_rep1.bw GSM3073962_PolII_522_293T_rep1.bw GSM3073950_PolII_468_293T_rep1.bw -a 1000 -b 1000 -o matrix_figure2b_6119 --skipZeros -p 15 --maxThreshold 20 -bs 25 &

plotHeatmap -m matrix_figure2b_6119 -o figure2b_6119.pdf --samplesLabel DMSO KL1 KL2 --plotTitle "Pol II ChIP-Seq" --colorMap Blues &

#log2 plots
bigwigCompare -b1 GSM3073962_PolII_522_293T_rep1.bw -b2 GSM3073977_PolII_DMSO_293T_rep1.bw -of bigwig -o KL1_log2.bw &

bigwigCompare -b1 GSM3073950_PolII_468_293T_rep1.bw -b2 GSM3073977_PolII_DMSO_293T_rep1.bw -of bigwig -o KL2_log2.bw &

computeMatrix reference-point -R figure2bgenes.topgenes.6119.bed -S KL1_log2.bw KL2_log2.bw -a 1000 -b 1000 -o matrix_figure2b_log2_6119 -p 15 --skipZeros --maxThreshold 1.3 -bs 25 &

plotHeatmap -m matrix_figure2b_log2_6119 -o figure2b_log2_6119.pdf --samplesLabel KL1 KL2 --plotTitle "Log2 (Pol II FC)" --colorMap bwr --whatToShow 'heatmap and colorbar' --whatToShow 'heatmap and colorbar' &

############
#FIGURE 2e
############
head -6841 figure2bgenes.sortedregions.bed > /projects/b1025/brian/paper1/figure2f/figure2fgenes.bed &

python3 paper1_figure2e.py #outputs tssgenes.bed and gbgenes.bed

############
#FIGURE 2f
############

#get top 6840 genes

#get top 3000 genes
head -1000 tssgenes.bed > tssgenes.1000.bed &
head -1000 gbgenes.bed > gbgenes.1000.bed &

#DMSO
coverageBed -a tssgenes.1000.bed -b PolII_DMSO.bam > DMSO_tss_1000.txt &
coverageBed -a gbgenes.1000.bed -b PolII_DMSO.bam > DMSO_gb_1000.txt &

#KL1
coverageBed -a tssgenes.1000.bed -b PolII_KL1.bam > KL1_tss_1000.txt &
coverageBed -a gbgenes.1000.bed -b PolII_KL1.bam > KL1_gb_1000.txt &

#KL2
coverageBed -a tssgenes.1000.bed -b PolII_KL2.bam > KL2_tss_1000.txt &
coverageBed -a gbgenes.1000.bed -b PolII_KL2.bam > KL2_gb_1000.txt &

#python3 paper1_figure2f.py
r paper1_figure2f.R

############
#FIGURE 2h
############
./figure2hscript.sh

head -1000 tssgenes.bed > tssgenes.1000.bed &
head -1000 gbgenes.bed > gbgenes.1000.bed &

#shGFP
coverageBed -a tssgenes.1000.bed -b shGFP.bam > shGFP_tss_1000.txt &
coverageBed -a gbgenes.1000.bed -b shGFP.bam > shGFP_gb_1000.txt &

#shAFF1 and AFF4 rep1
coverageBed -a tssgenes.1000.bed -b shAFF1AFF4_rep1.bam > shAFF1AFF4_rep1_tss_1000.txt &
coverageBed -a gbgenes.1000.bed -b shAFF1AFF4_rep1.bam > shAFF1AFF4_rep1_gb_1000.txt &

#shAFF1 and AFF4 rep2
coverageBed -a tssgenes.1000.bed -b shAFF1AFF4_rep2.bam > shAFF1AFF4_rep2_tss_1000.txt &
coverageBed -a gbgenes.1000.bed -b shAFF1AFF4_rep2.bam > shAFF1AFF4_rep2_gb_1000.txt &

#python3 paper1_figure2h.py
r paper1_figure2h.R

############
#FIGURE 3d
############

head -1058 figure2bgenes.sortedregions.bed > /projects/b1025/brian/paper1/figure3d/figure3dgenes.bed &

#DMSO
computeMatrix reference-point -R figure3dgenes.bed -S GSM3073979_PolII_DMSO_FAST_293T_895.bw GSM3073988_PolII_DMSO_WT_293T_895.bw GSM3073987_PolII_DMSO_SLOW_293T_894.bw --referencePoint TES -a 7500 -b 0 -o matrix_figure3d --skipZeros -p 12 &

plotProfile -m matrix_figure3d -o figure3d.pdf --samplesLabel "Fast Pol II" "WT Pol II" "Slow Pol II" --perGroup --colors red blue purple -y 'Reads Per Million' &

#KL1
# computeMatrix reference-point -R figure2bgenes.filtered.bed -S GSM3073964_PolII_522_FAST_293T_895.bw  GSM3073973_PolII_522_WT_293T_895.bw GSM3073972_PolII_522_SLOW_293T_894.bw --referencePoint TES -a 7500 -b 0 -o matrix_figure3d_KL1 &
# plotProfile -m matrix_figure3d_KL1 -o figure3d_KL1.pdf --samplesLabel "Fast Pol II" "WT Pol II" "Slow Pol II" --perGroup --colors red blue purple &

#KL2
# computeMatrix reference-point -R figure2bgenes.filtered.bed -S GSM3073952_PolII_468_FAST_293T_895.bw GSM3073961_PolII_468_WT_293T_895.bw GSM3073960_PolII_468_SLOW_293T_894.bw --referencePoint TES -a 7500 -b 0 -o matrix_figure3d_KL2 &
# plotProfile -m matrix_figure3d_KL2 -o figure3d_KL2.pdf --samplesLabel "Fast Pol II" "WT Pol II" "Slow Pol II" --perGroup --colors red blue purple &

############
#FIGURE 3e
############
computeMatrix reference-point -R figure3dgenes.bed -S GSM3073979_PolII_DMSO_FAST_293T_895.bw GSM3073964_PolII_522_FAST_293T_895.bw GSM3073952_PolII_468_FAST_293T_895.bw --referencePoint TES -a 7500 -b 0 -o matrix_figure3e --skipZeros -p 12 &

plotProfile -m matrix_figure3e -o figure3e.pdf --samplesLabel DMSO KL1 KL2 --perGroup --colors blue orange red -y 'Reads Per Million' &

############
#FIGURE 3h
############

# genomeCoverageBed -ibam DMSO_PRO.bam -strand -bg > DMSO_PRO_2.bedgraph &
# 
bamCoverage -b DMSO_PRO.bam -o DMSO_PRO.bedgraph -of bedgraph &
bamCoverage -b KL1_PRO.bam -o KL1_PRO.bedgraph -of bedgraph &
bamCoverage -b KL2_PRO.bam -o KL2_PRO.bedgraph -of bedgraph &

export PATH="$PATH+:/projects/b1025/tools/"
bigWigToBedGraph GSM3073997_PRO_DMSO_293T_rep1.minus.bw DMSO_PRO.minus.bedgraph &
bigWigToBedGraph GSM3073997_PRO_DMSO_293T_rep1.plus.bw DMSO_PRO.plus.bedgraph &

python3 figure3h_tss.py & #outputs tss region bed file (tss to 500 bp downstream)
python3 figure3h_.py & #takes bedgraph files and tss region bed to output bed files of pausing sites based on max coverage


#top 2000 genes
head -2001 figure2fgenes.bed > figure3hgenes.bed

computeMatrix reference-point -R figure3hgenes.bed -S GSM3073997_PRO_DMSO_293T_rep1.plus.bw GSM3073996_PRO_522_293T_rep1.plus.bw GSM3073995_PRO_468_293T_rep1.plus.bw -a 50000 -b 500 -o matrix_figure3h -bs 50 -p 15 --skipZeros --missingDataAsZero &

computeMatrixOperations filterStrand -m matrix_figure3h -o matrix_figure3h_positive -s + &

plotHeatmap -m matrix_figure3h_positive -o figure3h.pdf --samplesLabel DMSO KL1 KL2 --plotTitle "PRO-Seq Signals" --colorMap Blues --sortUsing region_length --sortRegions ascend &

#log2 plots
bigwigCompare -b1 GSM3073996_PRO_522_293T_rep1.plus.bw -b2 GSM3073997_PRO_DMSO_293T_rep1.plus.bw -of bigwig -o PRO_KL1_log2.bw &

bigwigCompare -b1 GSM3073995_PRO_468_293T_rep1.plus.bw -b2 GSM3073997_PRO_DMSO_293T_rep1.plus.bw -of bigwig -o PRO_KL2_log2.bw &

computeMatrix reference-point -R figure3hgenes.bed -S PRO_KL1_log2.bw PRO_KL2_log2.bw -a 50000 -b 500 -o matrix_figure3h_log2 -bs 50 -p 15 --skipZeros --missingDataAsZero &

computeMatrixOperations filterStrand -m matrix_figure3h_log2 -o matrix_figure3h_log2_positive -s + &

plotHeatmap -m matrix_figure3h_log2_positive -o figure3h_log2.pdf --samplesLabel KL1 KL2 --plotTitle "Log2 (Fold Changes)" --colorMap coolwarm --sortUsing region_length --sortRegions ascend &

############
#FIGURE 3i
############
#ngs.plot.r -G hg19 -R genebody -C figure3i.config.txt -O figure3i.plots & 

computeMatrix scale-regions -R figure2fgenes.bed -S GSM3073997_PRO_DMSO_293T_rep1.plus.bw GSM3073996_PRO_522_293T_rep1.plus.bw GSM3073995_PRO_468_293T_rep1.plus.bw -m 5000 -a 2000 -b 2000 -o matrix_figure3i -p 15 &

plotProfile -m matrix_figure3i -o figure3i.pdf --samplesLabel DMSO KL1 KL2 --perGroup --colors blue orange red -y 'Reads Per Million' &

############
#FIGURE 3j
############
#ngs.plot.r -G hg19 -R tes -C figure3i.config.txt -O figure3j.plots &

computeMatrix reference-point -R figure2fgenes.bed -S GSM3073997_PRO_DMSO_293T_rep1.plus.bw GSM3073996_PRO_522_293T_rep1.plus.bw GSM3073995_PRO_468_293T_rep1.plus.bw -a 5000 -b 5000 -o matrix_figure3j --referencePoint TES -p 15 &

plotProfile -m matrix_figure3j -o figure3j.pdf --samplesLabel DMSO KL1 KL2 --perGroup --colors blue orange red -y 'Reads Per Million' &

