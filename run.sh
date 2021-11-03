d=$(pwd)
echo $d

for s in MouseWT MouseAD Melanoma Prostate
do
	cd $d/MIST
	echo $s
	start=$SECONDS
	python3 MIST.py -f $d/data/$s/raw.csv -o $d/data/$s/MIST_imputed.csv -l cpm -n 10
	end1=$SECONDS
	dur1=$((end1-start))

	cd $d
	for m in MAGIC knnSmooth mcImpute spKNN
	do
		python3 run_other_imputers.py $d/data/$s/raw.csv $m
	done
	time2=$SECONDS
	python3 holdout/generate_cv.py $d/data/$s
	python3 holdout/holdout_experiments.py $d/data/$s
	python3 holdout/evalHO.py $d/data/$s
	end2=$SECONDS
	dur2=$((end2-time2))
	dur3=$((end2-start))
	echo $dur1
	echo $dur2
	echo $dur3
done
