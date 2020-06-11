/projects/p20742/tools/buildPipelineScripts.pl \
    -o /projects/b1025/brian/paper2/figure2a/outputfigure2a \
    -f /projects/b1025/brian/paper2/figure2a/ \
    -t chipseq \
    -acc b1025 \
    -q buyin \
    -g hg19 \
    -runAlign 1 \
    -runPeakCaller 1 \
    -chip /projects/b1025/brian/paper2/figure2a/chipfigure2a.csv \
    >& logfigure2a.log &\
