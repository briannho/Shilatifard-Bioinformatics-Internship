#tss region
shGFP.tss <- read.table('shGFP_tss_1000.txt', sep='\t')
shAFF1AFF4_rep1.tss <- read.table('shAFF1AFF4_rep1_tss_1000.txt', sep='\t')
shAFF1AFF4_rep2.tss <- read.table('shAFF1AFF4_rep2_tss_1000.txt', sep='\t')

#genebody region
shGFP.gb <- read.table('shGFP_gb_1000.txt', sep='\t')
shAFF1AFF4_rep1.gb <- read.table('shAFF1AFF4_rep1_gb_1000.txt', sep='\t')
shAFF1AFF4_rep2.gb <- read.table('shAFF1AFF4_rep2_gb_1000.txt', sep='\t')

#pausing index
shGFP.cov <- log2(shGFP.tss$V7/shGFP.gb$V7)
shGFP.cov[which(is.infinite(shGFP.cov))] <- 0

shAFF1AFF4_rep1.cov <- log2(shAFF1AFF4_rep1.tss$V7/shAFF1AFF4_rep1.gb$V7)
shAFF1AFF4_rep1.cov[which(is.infinite(shAFF1AFF4_rep1.cov))] <- 0

shAFF1AFF4_rep2.cov <- log2(shAFF1AFF4_rep2.tss$V7/shAFF1AFF4_rep2.gb$V7)
shAFF1AFF4_rep2.cov[which(is.infinite(shAFF1AFF4_rep2.cov))] <- 0

#ecdf functions
ecdf1 <- ecdf(shGFP.cov)
ecdf2 <- ecdf(shAFF1AFF4_rep1.cov)
ecdf3 <- ecdf(shAFF1AFF4_rep2.cov)

#plots
plot(ecdf1, verticals=TRUE, do.points=FALSE, col='blue', xlab = 'Log2(Pausing index)', ylab = 'Fraction', axes=FALSE, main = 'ECDF Plot of Pausing index')
plot(ecdf2, verticals=TRUE, do.points=FALSE, add=TRUE, col='purple')
plot(ecdf3, verticals=TRUE, do.points=FALSE, add=TRUE, col='maroon')
axis(2, at = c(0, 0.25, 0.5, 0.75, 1.0))
axis(1)
legend('topleft', legend = c('shGFP', 'shAFF1 & AFF4 #1', 'shAFF1 & AFF4 #2'), text.col = c('blue', 'purple', 'maroon'), bty = 'n')

