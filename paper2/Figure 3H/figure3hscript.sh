/projects/p20742/tools/buildPipelineScripts.pl \
    -o /projects/b1025/brian/paper2/figure3h/outputfigure3h \
    -f /projects/b1025/brian/paper2/figure3h/ \
    -t chipseq \
    -acc b1025 \
    -q buyin \
    -g hg19 \
    -runAlign 1 \
    -runPeakCaller 1 \
    -chip /projects/b1025/brian/paper2/figure3h/chipfigure3h.csv \
    >& logfigure3h.log &\