/projects/p20742/tools/buildPipelineScripts.pl \
    -o /projects/b1025/brian/paper2/figure4d/outputfigure4d \
    -f /projects/b1025/brian/paper2/figure4d/ \
    -t chipseq \
    -acc b1025 \
    -q buyin \
    -g hg19 \
    -runAlign 1 \
    -runPeakCaller 1 \
    -chip /projects/b1025/brian/paper2/figure4d/chipfigure4d.csv \
    >& logfigure4d.log &\