#tss region
dmso.tss <- read.table('DMSO_tss_1000.txt', sep='\t')
kl1.tss <- read.table('KL1_tss_1000.txt', sep='\t')
kl2.tss <- read.table('KL2_tss_1000.txt', sep='\t')

#genebody region
dmso.gb <- read.table('DMSO_gb_1000.txt', sep='\t')
kl1.gb <- read.table('KL1_gb_1000.txt', sep='\t')
kl2.gb <- read.table('KL2_gb_1000.txt', sep='\t')

#pausing index
dmso.cov <- log2(dmso.tss$V7/dmso.gb$V7)
dmso.cov[which(is.infinite(dmso.cov))] <- 0
#dmso.cov <- subset(dmso.cov, dmso.cov >= 0)

kl1.cov <- log2(kl1.tss$V7/kl1.gb$V7)
kl1.cov[which(is.infinite(kl1.cov))] <- 0
#kl1.cov <- subset(kl1.cov, kl1.cov >= 0)

kl2.cov <- log2(kl2.tss$V7/kl2.gb$V7)
kl2.cov[which(is.infinite(kl2.cov))] <- 0
#kl2.cov <- subset(kl2.cov, kl2.cov >= 0)

#ecdf functions
ecdf1 <- ecdf(dmso.cov)
ecdf2 <- ecdf(kl1.cov)
ecdf3 <- ecdf(kl2.cov)

#plots
plot(ecdf1, verticals=TRUE, do.points=FALSE, col='blue', xlab = 'Log2(Pausing index)', ylab = 'Fraction', axes=FALSE, main = 'ECDF Plot of Pausing index')
plot(ecdf2, verticals=TRUE, do.points=FALSE, add=TRUE, col='orange')
plot(ecdf3, verticals=TRUE, do.points=FALSE, add=TRUE, col='red')
axis(2, at = c(0, 0.25, 0.5, 0.75, 1.0))
axis(1)
legend('topleft', legend = c('DMSO', 'KL1', 'KL2'), text.col = c('blue', 'orange', 'red'), bty = 'n')
