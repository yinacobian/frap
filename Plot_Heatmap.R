args = commandArgs(trailingOnly=TRUE)

path <- args[1] #path to results folder

tabFile <- paste (path, "/","all_normalized_per_million.txt", sep="")

library(gplots)
library(RColorBrewer)

data <- read.table(tabFile, sep = "\t", header = T)
rnames <- data[,1]                            # assign labels in column 1 to "rnames"
mat_data <- data.matrix(data[2:(ncol(data)-1)]) # transform column 2 to end into a matrix
rownames(mat_data) <- rnames                  # assign row names

# creates a own color palette from red to green
my_palette <- colorRampPalette(c("violet", "blue", "green", "yellow", "red"))(n = 499)

outname = paste (path, "/","heatmap_all_normalized_per_million.png", sep="")
png(outname,
  width = 5*800,    
  height = 5*400,
  res = 350,            
  pointsize = 6)       

heatmap.2(mat_data,
  key = T,
  main = "Heatmap", # heat map title
  notecol="black",      # change font color of cell labels to black
  density.info="none",  # turns off density plot inside color legend
  trace="none",         # turns off trace lines inside the heat map
  margins =c(15,32),    # widens margins around plot
  #col=my_palette,       # use on color palette defined earlier
  dendrogram="both",    # only draw a row dendrogram
  keysize = 0.8,
  #lhei = c(3,7),
  cexRow = 1.2,
  key.xlab = "abundance"
)

dev.off()
