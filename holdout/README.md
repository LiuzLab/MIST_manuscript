## Clone MIST to the parent folder by running:
	
	git clone https://github.com/linhuawang/MIST.git

## Run the following script to generate holdout experiment data for one sample

	python3 holdout/generate_cv.py [data_folder]

## Run the holdout experiments with all imputation methods with Python version

	python3 holdout/holdout_experiments.py [data_folder]
## Run the evaluation script to get evaluation metrics

	python holdout/evalHO.py [data_folder]

Results will be saved to folder data_folder/performance
For performance visualization, please use the notebooks in the parent directory.
