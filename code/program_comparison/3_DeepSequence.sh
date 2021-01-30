DIR_LIST=( $( cat dataset_dirs.csv ) )

if [[ ! -f DeepSequence/DeepSequence/model.py ]]
then
    cd ../..
    git submodule update --init --recursive
    cd code/program_comparison
fi

for d in ${DIR_LIST[@]} ; do
    echo $d

    nice nohup python2 run_DeepSequence.py run_data/$d &> run_data/"$d"3_DeepSequence.log &

    wait
done
