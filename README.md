# This repository contains necessary scirpts to reproduce all the results and figures in the MIST manuscript.

## Clone MIST to the current directory

	git clone https://github.com/linhuawang/MIST.git

## Dependencies
  * python=3.7
  * pandas=0.25.3
  * numpy=1.18.5
  * matplotlib=3.3.4
  * statsmodels=0.12.0
  * scipy=1.6.1
  * tqdm=4.56.0
  * imageio
  * scanpy=1.8.1
  *	anndata=0.7.6
  * magic-impute

## Run MIST

	bash run.sh

This script includes all command lines that are needed to generate imputed data and holdout experiment results. Running MIST for every sample using 10 cpus takes about an hour. Running the whole bash script will take 1 - 2 days with 10 cpus.

## Data for manuscripts
	
### raw count data (without imputation): 
* ./data/MouseWT/raw.csv
* ./data/MouseAD/raw.csv
* ./data/Melanoma/raw.csv
* ./data/Prostate/raw.csv

Resulted data will be available by running the bash scripts mentioned above. Specific commands for every pieces of data are also listed below in the corresponding sections.

### Mouse brain ST meta data: 
* ./data/spot_meta.tsv

### Imputed data

1. MIST imputed data
	Running each sample takes too much time with one core, 'n=10' will take about an hour to execute. 

			python3 MIST.py -f ./data/[sample_name]/raw.csv -o ./data/[sample_name]/MIST_imputed.csv -l cpm -n 10
	The following files will be generated using the above command:
		* ./data/[sample_name]_cpm_imputed.csv
		* ./data/[sample_name]_imputed_cluster_info.csv

2. To get imputed data from other imputation method, run the following script:

		python3 run_other_imputers.py [path_to_fn] [method_name]
	The following files will be generated using the above command:
		* ./data/[sample_name]/[method_name]_imputed.csv


## Holdout experiments

To generate holdout data, run the experiments and evaluate peformance, please refer to holdout/holdout.README.

## Figures for manuscript

1. Figure 2 and extended (run in the listed order):
* Figure 2 more clustering (scanpy).ipynb
* Figure 2 a-f (part of Fig. 1).ipynb
* Melanoma region Rank-sum Test for fig 2 g & h.ipynb
* Figure2g.R
* Figure2h.R

2. Figure 3 and extended:
* Figure 3a-c - HO Performance.ipynb
* Figure 3d-h.ipynb
* Figure 3i overall improvement of SCC in holdout experiments.ipynb

3. Figure 4 and extended:
* Figure 4 a-c Mouse Brain UMAP.ipynb
* Figure 4 d-f cortex AD activated genes.ipynb

4. Figure 5 and extended:
* Figure 5. Improved co-expression patterns.ipynb
* Figure 5. ABA reference spatial correlation.ipynb
