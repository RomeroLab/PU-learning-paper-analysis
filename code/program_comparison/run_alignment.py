import os
from subprocess import run
import sys

from Bio import Seq, SeqIO, SeqRecord

direc = sys.argv[1]

if direc[-1] != '/':
    direc += '/'

if 'rocker' in direc:
    options = f'-A {direc}uniref.aln --notextw --noali -N 1 --cpu 20' \
            ' -E 10000 --max --domE 10000 --incE 10000 --incdomE 10000'
    db = 'run_data/uniref100.fasta'
else:
    options = f'-A {direc}uniref.aln --notextw --noali -N 1 --cpu 20'
    db = 'run_data/uniref90.fasta'

cmd = f'jackhmmer {options} {direc}ref_seq.fasta {db}'
run(cmd, shell=True)

with open(f'{direc}uniref.aln') as f:
    for line in f:
        if line[0] != '#' and len(line) > 10:
            _, ref = line.split()
            ref_ind = [i for i, c in enumerate(ref) if c.isupper()]
            break


def clean(seq):
    return ''.join(seq[i] for i in ref_ind)


cov_cut = 0.5
seqs = []
with open(f'{direc}uniref.aln') as f:
    for i, line in enumerate(f):
        if line[0] != '#' and len(line) > 10:
            name, seq = line.split()
            seq = clean(seq)
            cov = 1 - seq.count('-') / len(seq)
            if cov > cov_cut and seq not in seqs:
                seqs.append((name, seq))

# add bounds to reference sequence
ref_name, ref_seq = seqs[0]
ref_name += f'/1-{len(ref_seq)}'
seqs[0] = ref_name, ref_seq

seqs = [SeqRecord.SeqRecord(Seq.Seq(seq), id=name, description='')
        for name, seq in seqs]

SeqIO.write(seqs, f'{direc}aln_filtered.fasta', 'fasta')

os.remove(f'{direc}uniref.aln')
