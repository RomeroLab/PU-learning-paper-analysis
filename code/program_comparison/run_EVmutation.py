from subprocess import run
import sys

import pandas as pd

from EVmutation.model import CouplingsModel
from EVmutation import tools

direc = sys.argv[1]
if direc[-1] != '/':
    direc += '/'

print('Getting focus sequence name', flush=True)
with open(f'{direc}aln_filtered.fasta') as f:
    focus_name = f.readline()[1:].split('/')[0]

print('Running plmc', flush=True)
plmc = 'EVmutation/plmc/bin/plmc'
options = f'-n 30 -f {focus_name} -m 1250'
cmd = f'{plmc} {options} -o {direc}plmc.paramfile {direc}aln_filtered.fasta'
run(cmd, shell=True)


print('Creating CouplingsModel', flush=True)
c = CouplingsModel(f'{direc}plmc.paramfile')


def one_index(line):
    mutations = [(m[0], int(m[1:-1])+1, m[-1]) for m in line.split(',')]
    return ','.join(''.join([w, str(i), m]) for w, i, m in mutations)


print('Reading in data', flush=True)
with open(f'{direc}ref_mutations.txt') as f:
    unl_muts = [(one_index(line.strip()), 0) for line in f if line.strip()]
with open(f'{direc}sel_mutations.txt') as f:
    pos_muts = [(one_index(line.strip()), 1) for line in f if line.strip()]
muts = pd.DataFrame(unl_muts + pos_muts, columns=['mutant', 'f'])

print('Predicting with EVmutation')
pred_muts = tools.predict_mutation_table(c, muts)
pred_muts.rename(columns={'prediction_epistatic': 'pred'}, inplace=True)
# pred_muts['pred'] *= -1
# print(pred_muts)

print('Pickling predictions', flush=True)
pred_muts.to_pickle(f'{direc}EVmutation_results.p')
