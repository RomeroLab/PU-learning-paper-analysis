Make sure that the working directory is this README's containing directory before you run. I.e. you should be about to run step one below verbatim, without more complicated addressing to run 0_make_datalinks.sh. 

DEPENDENCIES:
python (python3)
jackhmmer
EVmutation: numba, pandas
DeepSequence: python2, pandas, theano
Rosetta
plots.py: scikit-learn matplotlib pandas

TO RUN:
1) Run "bash 0_make_datalinks.sh".

2) Create a symbolic link in run_data to uniref90 and uniref100 databases. On the Romero Lab server, this would be:
	ln -s /mnt/scratch/databases/uniprot/uniref100.fasta run_data/uniref100.fasta
	ln -s /mnt/scratch/databases/uniprot/uniref90.fasta run_data/uniref90.fasta

3) Run "bash 1_alignment.sh".

4) Use bash to run the remaining numbered .sh files in the desired order.

5) Run "python run_plots.py

Note that EVmutation and DeepSequence prequisites can easily be set up with Conda:

conda create --name EVmutation numba pandas
conda activate EVmutation
bash 2_EVmutation.sh

conda create --name DeepSequence python=2.7 pandas theano
conda activate DeepSequence
bash 3_DeepSequence.sh

conda create --name Plot scikit-learn matplotlib
conda activate Plot
python run_plots.py

You may be able to speed up DeepSequence by running it on a GPU. See https://github.com/debbiemarkslab/DeepSequence for details.
