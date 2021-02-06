DIR_LIST=( $( cat dataset_dirs.csv ) )

if [[ ! -f DeepSequence/DeepSequence/model.py ]]
then
    cd ../..
    git submodule update --init --recursive
    cd code/program_comparison
fi

[ ! -d "logs/" ] && mkdir "logs/"
[ ! -d "params/" ] && mkdir "params/"

for d in ${DIR_LIST[@]} ; do
    echo $d

    # CPU version
    # nice nohup python2 run_DeepSequence.py run_data/$d &> run_data/"$d"3_DeepSequence.log &

    # GPU version
    # THEANO_FLAGS='floatX=float32,device=cuda' nice nohup python2 run_DeepSequence.py run_data/$d &> run_data/"$d"3_DeepSequence.log &

    wait
done
