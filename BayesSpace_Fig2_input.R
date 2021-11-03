library(SingleCellExperiment)
library(BayesSpace)
library(ggplot2)

setwd("~/Documents/spatialLIBD/")
fn1 <- "../GitHub/MIST_manuscript/data/MouseWT/raw.csv"
fn2 <- "../GitHub/MIST_manuscript/data/Melanoma/raw.csv"


runBayesSpace <- function(fn, q=6){
  data <- read.csv(fn, row.names = 1, stringsAsFactors = F, check.names = T)
  data <- t(data)
  genes <- row.names(data)
  spots <- colnames(data)
  xs <- c()
  ys <- c()
  for (i in 1:length(spots)){
    x <- strsplit(spots[i], split="x")[[1]][1]
    y <- strsplit(spots[i], split="x")[[1]][2]
    xs <- c(xs, as.numeric(x))
    ys <- c(ys, as.numeric(y))
  }
  sce <- SingleCellExperiment(assays=list(counts=as.matrix(data)),
                              colData=DataFrame(spot=spots, row=xs, col=ys),
                              rowData=DataFrame(gene=genes))
  set.seed(2021)
  sce<- spatialPreprocess(sce, platform="ST", n.PCs=7, n.HVGs=2000, log.normalize=TRUE)
  sce <- spatialCluster(sce, q=q, platform="ST", d=7,
                        init.method="mclust", model="t", gamma=2,
                        nrep=1000, burn.in=100,
                        save.chain=TRUE)
  df <- as.data.frame(sce@colData)
  return(df)
}

fns <- list.files("~/Box/data/spatial_transcriptomics/MouseData/")
fns <- fns[endsWith(x = fns, '.csv')]
length(fns)

for (fn in fns){
  in_fn <- paste("~/Box/data/spatial_transcriptomics/MouseData/", fn, sep='', collapse='')
  out_fn <- paste("~/Box/data/spatial_transcriptomics/MouseData/BayesSpace_clusters/", fn, sep='', collapse='')
  bs_region_df <- runBayesSpace(in_fn)
  write.csv(bs_region_df, out_fn)  
}



 # 
# 
# row.data <- row.names(data)
# col.data <- colnames(data)
# 
# cols <-c()
# rows <- c()
# for (i in 1:length(col.data)){
#   col <- strsplit(col.data[i], split="x")[[1]][1]
#   row <- strsplit(col.data[i], split="x")[[1]][2]
#   cols <- c(cols, as.numeric(col))
#   rows <- c(rows, as.numeric(row))
# }
# 
# sce <- SingleCellExperiment(assays=list(counts=as.matrix(data)),
#                             colData=DataFrame(spot=col.data, col=cols, row=rows),
#                             rowData=DataFrame(gene=row.data))
# 
# set.seed(2021)
# sce<- spatialPreprocess(sce, platform="ST", n.PCs=7, n.HVGs=2000, log.normalize=TRUE)
# 
# ### Didn't work
# sce <- qTune(sce, qs=seq(2, 10))
# qPlot(sce)
# q <- 3
# sce <- spatialCluster(sce, q=q, platform="ST", d=7,
#                init.method="mclust", model="t", gamma=2,
#                nrep=1000, burn.in=100,
#                save.chain=TRUE)
# clusterPlot(sce)
# df <- as.data.frame(sce@colData)
# write.csv(df, "~/Documents/GitHub/MIST_manuscript/BayesSpace_Melanoma_clusters.csv")
# meta <- read.csv('~/Documents/AppSpatialGenes/spatialAD/spot_metadata.tsv', sep='\t')
# meta <- meta[meta$Group== 'WT_12', ]
# dim(meta)
# df <- as.data.frame(sce@colData)
# row.names(meta) <- paste( meta$coord_X, meta$coord_Y, sep="x")
# 
# meta <- meta[df$spot,]
# 
# meta$region <- meta$AT
# meta[meta$Level_01 == "CX", "region"] <- "CX"
# 
# #row.names(meta) <- meta$region
# library(mclust)
# adjustedRandIndex(df$spatial.cluster,  meta$region)
# write.csv(df, "~/Documents/GitHub/MIST_manuscript/BayesSpace_MouseWT_clusters.csv")
# 
# df2 <- read.csv("~/Desktop/mouseWT_regions.csv", row.names=1)
# df2 <- df2[df2$size >= 5,]
# #row.names(df2) <- paste(df2$X, sep="x")
# df <- df[row.names(df2),]
# #df2 <- df2[row.names(meta),]
# meta <- meta[row.names(df2),]
# all(row.names(meta) == row.names(df))
# all(row.names(meta) == row.names(df2))
# 
# dim(df2)
# adjustedRandIndex(df2$cluster_name,  meta$region)
# adjustedRandIndex(df$spatial.cluster,  meta$region)
# df$spatial.cluster <- as.factor(df$spatial.cluster)
# # ggplot(df, aes(x=col, y=row, color=spatial.cluster)) +
# #   geom_point() + scale_y_reverse()
