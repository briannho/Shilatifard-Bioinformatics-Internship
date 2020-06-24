############
#FIGURE 2a
############

#find distance to nearest TSS
export PATH="$PATH+:/projects/b1025/tools/homer/bin"
./annotatePeaks.pl ESR1_T2D.macsPeaks.bed hg19 > ESR1_T2D.macsPeaks.anno.txt &
./annotatePeaks.pl ESR1_T2E.macsPeaks.bed hg19 > ESR1_T2E.macsPeaks.anno.txt &
./annotatePeaks.pl ESR1_WTD.macsPeaks.bed hg19 > ESR1_WTD.macsPeaks.anno.txt &
./annotatePeaks.pl ESR1_WTE.macsPeaks.bed hg19 > ESR1_WTE.macsPeaks.anno.txt &

#sort peaks into tss and nontss bed files (by group type and in total)
python3 paper2_figure2a.py


# try merging all peaks
sort -k 1,1 -k2,2n allnontss.peaks.bed > allnontss.peaks.sorted.bed &
sort -k 1,1 -k2,2n alltss.peaks.bed > alltss.peaks.sorted.bed &

mergeBed -i allnontss.peaks.sorted.bed -s -c 4,5 -o distinct,max > merged.nontss.peaks.bed &
mergeBed -i alltss.peaks.sorted.bed -s -c 4,5 -o distinct,max > merged.tss.peaks.bed &

perl /projects/p20742//tools/bin/NGSplotPipeline/NGSplotFilesScripts/convertToNGSplotSortedCenteredBED.pl merged.nontss.peaks.bed merged.nontss.peaks.centered.bed &
perl /projects/p20742//tools/bin/NGSplotPipeline/NGSplotFilesScripts/convertToNGSplotSortedCenteredBED.pl merged.tss.peaks.bed merged.tss.peaks.centered.bed &

sort -k 1,1 -k2,2n merged.nontss.peaks.centered.bed > merged.nontss.peaks.centered.sorted.bed &
sort -k 1,1 -k2,2n merged.tss.peaks.centered.bed > merged.tss.peaks.centered.sorted.bed &





#try all peaks w/o merging
perl /projects/p20742//tools/bin/NGSplotPipeline/NGSplotFilesScripts/convertToNGSplotSortedCenteredBED.pl allnontss.peaks.bed allnontss.peaks.centered.bed &
perl /projects/p20742//tools/bin/NGSplotPipeline/NGSplotFilesScripts/convertToNGSplotSortedCenteredBED.pl alltss.peaks.bed alltss.peaks.centered.bed &

sort -k 1,1 -k2,2n allnontss.peaks.centered.bed > allnontss.peaks.centered.sorted.bed &
sort -k 1,1 -k2,2n alltss.peaks.centered.bed > alltss.peaks.centered.sorted.bed &



#just using WTE peaks
perl /projects/p20742//tools/bin/NGSplotPipeline/NGSplotFilesScripts/convertToNGSplotSortedCenteredBED.pl ESR1_WTE.macsPeaks.nontss.bed WTE.nontss.centered.bed &
perl /projects/p20742//tools/bin/NGSplotPipeline/NGSplotFilesScripts/convertToNGSplotSortedCenteredBED.pl ESR1_WTE.macsPeaks.tss.bed WTE.tss.centered.bed &

sort -k 1,1 -k2,2n WTE.tss.centered.bed > WTE.tss.centered.sorted.bed &
sort -k 1,1 -k2,2n WTE.nontss.centered.bed > WTE.nontss.centered.sorted.bed &




#plots
ngs.plot.r -G hg19 -R bed -C figure2a.tss.config.txt -O figure2a.tss.plots -GO km -KNC 3 -L 2500 -SC 0.0,2.0 &
ngs.plot.r -G hg19 -R bed -C figure2a.nontss.config.txt -O figure2a.nontss.plots -GO km -KNC 3 -L 2500 -SC 0.0,2.0 &


#temp
# intersectBed -wa -a hg19.Ens_75.genes.bed -b ESR1_WTD.macsPeaks.bed ESR1_WTE.macsPeaks.bed ESR1_T2D.macsPeaks.bed ESR1_T2E.macsPeaks.bed > figure2agenes.bed &
# perl /projects/p20742//tools/bin/NGSplotPipeline/NGSplotFilesScripts/convertToNGSplotSortedCenteredBED.pl figure2agenes.bed figure2agenes.centered.bed &
# ngs.plot.r -G hg19 -R bed -C figure2a.config.txt -O figure2a.plots -GO km -KNC 3 &

############
#FIGURE 2b
############
#okay i actually dont know how to do this figure yet. the below stuff is 90% wrong now
./figure2bscript.sh

#left
ngs.plot.r -G hg19 -R bed -C TET2_KO.bam:TET2_WT.bam -O figure2b_left.tss.plots -E figure2cpeaks.tss.bed -T TET2_KO_WT -CO blue:white:red -SC -2.0,2.0 -L 2500 &
ngs.plot.r -G hg19 -R bed -C TET2_KO.bam:TET2_WT.bam -O figure2b_left.nontss.plots -E figure2cpeaks.nontss.bed -T TET2_KO_WT -CO blue:white:red -SC -2.0,2.0 -L 2500 &

#right -- THIS MIGHT NOT BE RIGHT BC IT'S NEARBY GENE EXPRESSION, NOT CENTERED PEAKS. ALSO NOT SURE IF IT'S BEEN CLUSTERED
ngs.plot.r -G hg19 -R bed -C ERa_E2.bam:ERa_DMSO.bam -O figure2b_right.tss.plots -E merged.tss.peaks.centered.sorted.bed -T ERa_E2-DMSO -CO blue:white:red -SC -2.0,2.0 -L 2500 &
ngs.plot.r -G hg19 -R bed -C ERa_E2.bam:ERa_DMSO.bam -O figure2b_right.nontss.plots -E merged.nontss.peaks.centered.sorted.bed -T ERa_E2-DMSO -CO blue:white:red -SC -2.0,2.0 -L 2500 &

############
#FIGURE 2c
############
./figure2cscript.sh

#temp
ngs.plot.r -G hg19 -R bed -C TET2_WT.bam -O figure2c.nontss.plots -E ESR1_WTE.macsPeaks.nontss.bed -T a-TET2-NTD &
ngs.plot.r -G hg19 -R bed -C TET2_WT.bam -O figure2c.tss.plots -E ESR1_WTE.macsPeaks.tss.bed -T a-TET2-NTD &

ngs.plot.r -G hg19 -R bed -C ESR1_WTD.bam -O figure2c.nontss.plots -E ESR1_WTE.macsPeaks.nontss.bed -T a-TET2-NTD &
ngs.plot.r -G hg19 -R bed -C ESR1_WTD.bam -O figure2c.tss.plots -E ESR1_WTE.macsPeaks.tss.bed -T a-TET2-NTD &

#TRY THIS
ngs.plot.r -G hg19 -R bed -C a-TET2-NTD.bam -O figure2c.nontss.plots -E figure2cpeaks.nontss.bed -T a-TET2-NTD -SC 0.0,1.0 -L 2500 &
ngs.plot.r -G hg19 -R bed -C a-TET2-NTD.bam -O figure2c.tss.plots -E figure2cpeaks.tss.bed -T a-TET2-NTD -SC 0.0,1.0 -L 2500 &

############
#FIGURE 2g
############

ngs.plot.r -G hg19 -R cgi -C figure2g.config.txt -O figure2g.plots -T Well-observed_CpGs-TSS &

############
#FIGURE 2h
############

ngs.plot.r -G hg19 -R cgi -C figure2h.config.txt -O figure2h.plots -T 'Well-observed CpGs-cluster 1' &

############
#FIGURE 2i
############

ngs.plot.r -G hg19 -R cgi -C figure2i.config.txt -O figure2i.plots -T 'Well-observed CpGs-cluster 2' &

############
#FIGURE 2j
############

ngs.plot.r -G hg19 -R cgi -C figure2j.config.txt -O figure2j.plots -T 'Well-observed CpGs-cluster 3' &

############
#FIGURE 3a
############
#used BioJupies to create heatmap.
#was able to locate all genes originally highlighted in figure3a, but could not show them 

############
#FIGURE 3h
############
ngs.plot.r -G hg19 -R bed -C figure3h.config.txt -O figure3h.plots -L 5000 &

############
#FIGURE 4d
############
ngs.plot.r -G hg19 -R bed -C figure4d.config.txt -O figure4d.plots -CO blue:white:red -L 5000 -SC -1.0,1.0 &

