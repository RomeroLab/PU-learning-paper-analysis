DIR_LIST=( $( cat dataset_dirs.csv ) )

if [[ ! -f EVmutation/plmc/bin/plmc ]]
then
    cd ../..
    git submodule update --init --recursive
    cd code/program_comparison/EVmutation/plmc/
    make all-openmp
    cd ../..
fi

for d in ${DIR_LIST[@]} ; do
    echo $d

    nice nohup python run_EVmutation.py run_data/$d &> run_data/"$d"2_EVmutation.log &

    wait
done
