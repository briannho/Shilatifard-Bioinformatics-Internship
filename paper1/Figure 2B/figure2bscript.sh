/projects/p20742/tools/buildPipelineScripts.pl \
    -o /projects/b1025/brian/paper1/figure2b/rep1/outputfigure2b \
    -f /projects/b1025/brian/paper1/figure2b/rep1 \
    -t chipseq \
    -acc b1025 \
    -q buyin \
    -g hg19 \
    -runAlign 1 \
    -runPeakCaller 1 \
    -chip /projects/b1025/brian/paper1/figure2b/rep1/chipfigure2b.csv \
    >& logfigure2b.log &
