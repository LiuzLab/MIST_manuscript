setwd("~/Documents/spImpute/paper_data/scripts/")
library(limma)
library(edgeR)
library(EnhancedVolcano)
library(ggpubr)

raw_df = read.csv("raw_melanoma_deg_list.csv")
raw_df$adjP <- p.adjust(raw_df$pval)
p <- EnhancedVolcano(toptable = raw_df, lab=raw_df$gene, x="lfc", y="adjP", 
                     pCutoff = 1e-5,
                     FCcutoff = 1,
                     pointSize = 2.0,
                     labSize = 3.0)
p

