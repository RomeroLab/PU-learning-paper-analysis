import pandas as pd
import numpy as np

# load the data from the original publication: 
# A Comprehensive Biophysical Description of Pairwise Epistasis throughout an Entire Protein Domain
# https://ars.els-cdn.com/content/image/1-s2.0-S0960982214012688-mmc2.xlsx
raw = pd.read_excel('1-s2.0-S0960982214012688-mmc2.xlsx')


# data for WT
WT = [(np.nan,np.nan,raw['Unnamed: 20'][2],raw['Unnamed: 20'][2]),]

# data for single mutants
sm = raw.iloc[2:1047,13:18]
singles = [(r[1][0]+str(r[1][1])+r[1][2],np.nan,r[1][3],r[1][4]) for r in sm.iterrows()]

# data for double mutants
dm = raw.iloc[2:,1:9]
doubles = [(r[1][0]+str(r[1][1])+r[1][2],r[1][3]+str(r[1][4])+r[1][5],r[1][6],r[1][7]) for r in dm.iterrows()]


# make a data frame with all data organized 
mut_data = pd.DataFrame(WT+singles+doubles,columns=['mut1','mut2','input_count','selection_count'])


# add full sequence information
def mut2seq(mutations):
    seq = 'MQYKLILNGKTLKGETTTEAVDAATAEKVFKQYANDNGVDGEWTYDDATKTFTVTE' # WT GB1 sequence

    if len(mutations)==0: return seq
    
    for mut in mutations.split(','):
        pos = int(mut[1:-1])-1
        newAA = mut[-1]
        seq = seq[:pos]+newAA+seq[pos+1:]
    
    return seq

mutations = [','.join([i for i in (a[1]['mut1'],a[1]['mut2']) if not pd.isna(i)]) for a in mut_data.iterrows()]
sequences = [mut2seq(m) for m in mutations]
mut_data['sequences'] = sequences


# write to CSV
out = mut_data[['sequences','input_count','selection_count']]
out.to_csv('GB1_PU_dataset.txt',header=False,index_label=False)
