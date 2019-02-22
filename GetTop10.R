#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
path <- args[1] 

in_file <- paste (path, "/","all_normalized_per_million.txt", sep="")
T <- read.csv(in_file, sep="\t", header=TRUE)

T <- T [rowSums(T[,(2:(ncol(T)-1))]) > 0,]
T <- T[order((rowSums(T[,(2:(ncol(T)-1))])),decreasing=TRUE),]
top10 <- c(as.character(T$id[1:10]))

out_file <- paste (path, "/","top10_dbid.txt", sep="")
write(top10, file = out_file, ncolumns = 1, append = FALSE, sep = " ")
