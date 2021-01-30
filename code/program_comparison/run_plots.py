import sys

import matplotlib.pyplot as plt
from sklearn.metrics import auc, roc_curve
import pandas as pd

with open('dataset_dirs.csv') as f:
    datasets = [line.strip() for line in f]

pis = {"DXS/": 0.001000000, "Bgl3/": 0.2,
       "GB1/": 0.070252808, "HA/": 0.001000000,
       "LGK/": 0.013690157, "PyKS/": 0.036522591, "rocker/": 0.007117153,
       "SUMO1/": 0.001000000, "TPK1/": 0.002667799, "UBE2I/": 0.001}

# programs = ['EVmutation', 'DeepSequence', 'Rosetta']
programs = ['EVmutation', 'DeepSequence']

for program in programs:
    plt.figure()
    plt.title(program + ' corrected_ROC curve')
    for dataset, pi in pis.items():
        direc = 'run_data/' + dataset
        print(program, direc, pi)
        data = pd.read_pickle(f'{direc}{program}_results.p')
        data = data[data.pred.notnull()]
        y_true = data.loc[:, 'f']
        y_score = data.loc[:, 'pred']
        fpr, tpr, _ = roc_curve(y_true, y_score)
        roc_auc = auc(fpr, tpr)

        corrected_fpr = (fpr - pi*tpr) / (1 - pi)
        corrected_roc_auc = (roc_auc - pi / 2) / (1 - pi)
        plt.plot(corrected_fpr, tpr,
                 lw=2, label='%s (area = %0.2f) pi = %s'
                 % (direc, corrected_roc_auc, pi))

    plt.legend()
    # plt.savefig('PU_' + program + '.eps')

plt.show()
