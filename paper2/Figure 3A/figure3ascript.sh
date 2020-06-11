/projects/p20742/tools/buildPipelineScripts.pl \
    -o /projects/b1025/brian/paper2/figure3a/outputfigure3a \
    -f /projects/b1025/brian/paper2/figure3a/ \
    -c figure3acomparisons.csv \
    -t RNA \
    -acc b1025 \
    -q buyin \
    -g hg19 \
    -runAlign 1 \
    -htseq 1 \
    -runEdgeR 1 \
    >& logfigure3a.log &\