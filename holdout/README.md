1. Clone MIST to the parent folder by running:
	
	git clone https://github.com/linhuawang/MIST.git

2. Run the following script to generate holdout experiment data for one sample

	python3 holdout/generate_cv.py [data_folder]

3. Run the holdout experiments with all imputation methods with Python version

	python3 holdout/holdout_experiments.py [data_folder]

4. Run the evaluation script to get evaluation metrics

	python holdout/evalHO.py [data_folder]

	Results will be saved to folder data_folder/performance

5. For performance visualization, please use the notebooks in the parent directory.