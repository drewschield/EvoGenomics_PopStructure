### Read in data

# (This assumes you're in the EvoGenomics_PopStructure folder!)

chr5 <- read.table('viridis_vs_oreganus_chr5.100kb.windowed.weir.fst',header=T)
chrZ <- read.table('viridis_vs_oreganus_chrZ.100kb.windowed.weir.fst',header=T)

### Plot Fst sliding windows on the two chromosomes

# First, specify how many plotting panels (rows, columns) to use
par(mfrow=c(2,1))
# Then plot the plots!
plot(chr5$BIN_START,chr5$MEAN_FST,type='l',col='blue',ylab='Fst',xlab='Chromosome Position (bp)',main='Chromosome 5')
plot(chrZ$BIN_START,chrZ$MEAN_FST,type='l',col='aquamarine4',ylab='Fst',xlab='Chromosome Position (bp)',main='Z chromosome')

### Try out some summary statistics

# mean values
mean(chr5$MEAN_FST)
mean(chrZ$MEAN_FST)

# standard deviations
sd(chr5$MEAN_FST)
sd(chrZ$MEAN_FST)

### Test whether Chromosome 5 and Z distributions are significantly different

# Use a wilcox test (not a t-test), because our values are NOT normally distributed
wilcox.test(chr5$MEAN_FST,chrZ$MEAN_FST)
