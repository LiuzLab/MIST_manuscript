"""Script to run other imputation methods used in the paper 
	except SAVER, which was run using separate R script.
"""
from imputers import *
import sys
sys.path.append("MIST/")
import utils
import Data
input_fn = sys.argv[1]
imputer_name = sys.argv[2]
data = Data.Data(countpath = input_fn, norm="cpm")
out_fn = "_".join((input_fn.split("_")[:-1]  + [imputer_name + ".csv"]))
print(out_fn)
imputer = Imputer(imputer_name, data)
iData = imputer.fit_transform()
iData.to_csv(out_fn)
