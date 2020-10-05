# this script inputs the mutation files and outputs files containing full sequences
import gzip


# filenames                                                                                                                                                                                                                      
rcfile = 'PyKS_ref_read_counts.txt' # this is to get the reference sequence 
reffile = 'PyKS_ref_mutations_filtered.txt'
selfile = 'PyKS_sel_mutations_filtered.txt'


# read the files                                                                                                                                                                                                             
ref = open(reffile).read().strip()
sel = open(selfile).read().strip()


# we can either write the full sequence or just the sequence positions that have mutations
# the full sequence is better for interpretation because we can map the coeffcients back to the original sequence
# the varying sequence positions only is better for speed/effciency and is suffcient if we only want to evaluate model performance 

minimal = True # this means only write the varying sequence positions 

if minimal:
    # get a list of all the observed mutations                                                                                                                                                                                      
    refmuts = ref.replace(' ','').replace('\n',',').split(',')
    selmuts = sel.replace(' ','').replace('\n',',').split(',')
    all_muts = sorted(set(refmuts+selmuts))

    positions = sorted(set([int(p[1:-1]) for p in all_muts])) # these are the positions that have mutations 
    WT = dict((pos,[m for m in all_muts if int(m[1:-1])==pos][0][0]) for pos in positions) 

if not minimal: 
    # determine WT sequence from read_counts file 
    WT = dict([(int(l.split(',')[0]),l.split(',')[1].strip()) for l in open(rcfile).read().strip().split('\n')])


# write sequences for the reference
outfile = gzip.open(reffile.replace('mutations','sequences')+'.gz','wt')
for variant in ref.split('\n'):
    variant_seq = WT.copy()

    for mut in variant.split(','):
        pos = int(mut[1:-1])
        AA = mut[-1]
        variant_seq[pos] = AA

    seq = ''.join([variant_seq[p] for p in WT])
    outfile.write(seq+'\n')


# write sequences for the selected
outfile = gzip.open(selfile.replace('mutations','sequences')+'.gz','wt')
for variant in sel.split('\n'):
    variant_seq = WT.copy()

    for mut in variant.split(','):
        pos = int(mut[1:-1])
        AA = mut[-1]
        variant_seq[pos] = AA

    seq = ''.join([variant_seq[p] for p in WT])
    outfile.write(seq+'\n')
