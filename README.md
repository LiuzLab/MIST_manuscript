# This repository contains necessary scirpts to reproduce all the results and figures in the MIST manuscript.

## Preparing MIST

	git clone https://github.com/linhuawang/MIST.git

## Data for manuscripts
### raw count data (without imputation): 

	* ./data/MouseWT/raw.csv
	* ./data/MouseAD/raw.csv
	* ./data/Melanoma/raw.csv
	* ./data/Prostate/raw.csv

### Mouse brain ST meta data: 

	* ./data/spot_meta.tsv

### imputed data

1. MIST imputed data

	* ./data/[sample_name]_cpm_imputed.csv
	* ./data/[sample_name]_imputed_cluster_info.csv

2. To get imputed data from other imputation method, run the following script:

		python3 run_other_imputers.py [path_to_fn] [method_name]

	* ./data/[sample_name]/[sample_name]_[method_name].csv


## Holdout experiments

To generate holdout data, run the experiments and evaluate peformance, please refer to holdout/holdout.README.

## Figures for manuscript
1. Figure 2 and extended:

	* Figure 2a, b, c (part of Fig. 1).ipynb
	* Figure 2d - Melanoma region Rank-sum Test.ipynb
	* Figure2D.R
	* Figure2E.R

2. Figure 3 and extended:

	* Figure 3a-c - HO Performance.ipynb
	* Figure 3d-f.ipynb
	* Figure 3g overall improvement of SCC in holdout experiments.ipynb

3. Figure 4 and extended:

	* Figure 4 a-c Mouse Brain UMAP.ipynb
	* Figure 4 d-f cortex AD activated genes.ipynb

4. Figure 5 and extended:

	* Figure 5 a,b,d,e. Improved co-expression patterns.ipynb
	* Figure 5 c and f - ABA reference spatial correlation.ipynb
