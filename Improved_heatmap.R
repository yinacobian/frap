library(gplots)
library(RColorBrewer)

#########################################################
### reading in data and transform it to matrix format
#########################################################

data <- read.table("all_normalized_per_million.txt", sep = "\t", header = T)
rnames <- data[,1]                            # assign labels in column 1 to "rnames"
mat_data <- data.matrix(data[2:(ncol(data)-1)]) # transform column 2 to end into a matrix
rownames(mat_data) <- rnames                  # assign row names


data_temp <- mat_data[rowSums(mat_data) > 0,] #remove rows that sum 0. Can be changed to remove more rows

data_temp <- data.matrix(data_temp)

#########################################################
### customizing and plotting heatmap
#########################################################

# creates a own color palette from blue to purple. 
#More colors can be used (check RColorBrewer palette)
my_palette <- brewer.pal(n=9, name = "BuPu")
my_palette <- colorRampPalette(my_palette)(n = 499)

# (optional) defines the color breaks manually 
col_breaks = c(seq(0,500,length.out = 50),   # for violet
  seq(500.1, 1500,length.out=100),            # for blue
  seq(1500.1, 5000,length.out=100),
  seq(5000.1, 10000,length.out=100),
  seq(10000.1,20000,length.out=150))        # for red


# creates a png file image
png("all_normalized_improved.png",
  width = 3000,        # 3000 pixels
  height = 2000,
  res = 350,            # 350 pixels per inch
  pointsize = 7)       

heatmap.2(data_temp,
  #lmat = rbind(c(4,3), c(2,1)), #can be modified to change positions in the heatmap
  symm = FALSE,
  symbreaks = FALSE,
  symkey = FALSE,
  #cellnote = mat_data,  # same data set for cell labels
  #main = "ref_seq_bacteria", # heat map title
  notecol="black",      # change font color of cell labels to black
  density.info="none",  # turns off density plot inside color legend
  trace="none",         # turns off trace lines inside the heat map
  margins =c(12,32),     # widens margins around plot
  col=my_palette,       # use on color palette defined earlier
  breaks=col_breaks, # enable color transition at specified limits
  dendrogram = "row",     # only draw a row dendrogram
  Colv="NA",           # turn off column clustering, comment if Col Dendrogram is desired
  keysize = 0.2,
  cexCol = 0.8,
  lhei = c(1,5),
  lwid = c(1,4)
  #key.title="Relative abundance", #add a title to the key
#####the next rows are optional, if a classsification of the rows and columns is desired. 
#####Check the order in the txt file before changiing these parameters
  # RowSideColors = c(    # grouping row-variables into different
  #   rep("gray", 4),   # categories, Measurement 1-3: green
  #   rep("blue", 18),    # Measurement 4-6: blue
  #   rep("black", 3),
  #   rep("green", 7),
  #   rep("orange", 5)),
#   ColSideColors = c(
#     rep("red", 11),
#     rep("violet", 9),
#     rep("green", 6),
#     rep("black", 7),
#     rep("aquamarine", 7),
#     rep("blue", 6),
#     rep("yellow", 1))
)

######
  # par(lend = 1)           # square line ends for the color legend
  # legend("left",      # location of the legend on the heatmap plot
  #        legend = c("category1", "category2", "category3", "category4", "category5", [...]), # category labels
  #        col = c("gray", "blue", "black", "green", "orange", [...]),  # color key
  #        lty= 1,             # line style
  #        lwd = 10            # line width
  # )
  # par(lend = 1)
  # legend("topright",      # location of the legend on the heatmap plot
  #        legend = c("category1", "category2", [...]), # category labels
  #        col = c("red", "violet",[...]),  # color key
  #        lty= 1,             # line style
  #        lwd = 10            # line width
  # )

dev.off()
