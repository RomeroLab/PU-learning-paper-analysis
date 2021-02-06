DIR_LIST=( $( cat dataset_dirs.csv ) )

for d in ${DIR_LIST[@]} ; do
    echo $d

    nice nohup python run_alignment.py run_data/$d &> run_data/"$d"1_alignment.log &

    wait
done
