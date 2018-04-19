#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)


genomename <- args[1]
covfile <- paste ("cov_mpileup_map_", genomename, "_CF146mt03292018.tab", sep="")
cov <- read.table (covfile)
plot (cov$V2, type= "lines", col="darkblue", xlab=genomename, ylab="Coverage/nt", main="CF146mt03292018")
imagename <- paste ("covplot_","CF146mt03292018_", genomename,".png", sep="")
avgcov <- sum(cov$V2)/length(cov$V2)
okavgcov <-(format (avgcov, digits=2))
xlabname <- paste (genomename, "     Average coverage ", okavgcov, "X", sep="")
png(imagename,width=25,height=10,units="cm",res=1200)
plot (cov$V2, type= "lines", col="darkblue", xlab=xlabname, ylab="Coverage/nt", main="CF146mt03292018")
dev.off()
