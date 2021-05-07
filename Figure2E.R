setwd("~/Documents/GitHub/MIST_manuscript/")
library(clusterProfiler)
library(enrichplot)
library(ggplot2)
library(organism, character.only = TRUE)

organism = org.Hs.eg.db
BiocManager::install(organism, character.only = TRUE) # Install reference
# READ DEG list
deg_df <- read.csv(file = "raw_melanoma_deg_list.csv")
deg_df$padj <- p.adjust(deg_df$pval)
deg_df = deg_df[!duplicated(deg_df$gene),]
deg_df = deg_df[abs(deg_df$lfc) >= .59 & deg_df$padj < 1E-5,]
original_gene_list <- deg_df$lfc
names(original_gene_list) <- deg_df$gene
gene_list<-na.omit(original_gene_list)
# sort the list in decreasing order (required for clusterProfiler)
gene_list = sort(gene_list, decreasing = TRUE)

## GSEA analysis
gse <- gseGO(geneList=gene_list, 
             ont ="ALL", 
             keyType = "SYMBOL", 
             minGSSize = 10, 
             maxGSSize = 800, 
             pvalueCutoff = 0.05, 
             verbose = TRUE, 
             OrgDb = org.Hs.eg.db, 
             pAdjustMethod = "none")

require(DOSE)
## Plot results
res <- gse@result
sig <- -log10(res$p.adjust)
gse@result$Sig <- sig
dotplot(gse, showCategory=5, x='Sig',split=".sign",  orderBy='count') + facet_grid(.~.sign)
