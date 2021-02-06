DIR_LIST=( $( cat dataset_dirs.csv ) )
DATA_FOLDER=$PWD/../../data/

if [[ ! -d run_data ]]
then
    mkdir run_data
fi

for d in ${DIR_LIST[@]} ; do
    echo $d
    if [[ ! -d run_data/"$d" ]]
    then
        mkdir run_data/"$d"
    fi

    for f in "$DATA_FOLDER$d"*
    do
	if [[ "$f" == *sel_mutations_filtered.txt ]]
        then
            ln -s $f run_data/"$d"sel_mutations.txt
	    echo $f
        fi

	if [[ "$f" == *ref_mutations_filtered.txt && "$f" != *Bgl3_Lib@(2|3)* ]]
        then
            ln -s $f run_data/"$d"ref_mutations.txt
	    echo $f
        fi

        if [[ "$f" == *ref_AA.fasta ]]
        then
            ln -s $f run_data/"$d"ref_seq.fasta
	    echo $f
        fi

        if [[ "$f" == *.pdb ]]
        then
            ln -s $f run_data/"$d"
	    echo $f
        fi

    done

    echo

done
