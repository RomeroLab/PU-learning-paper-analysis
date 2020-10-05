# this is a little sloppy, but made just for Bgl3 because of issues finding common varaibles across replicates 
import gzip

rcfile = 'Bgl3_Lib1_ref_read_counts.txt' # this is to get the reference sequence 
WT = dict([(int(l.split(',')[0]),l.split(',')[1].strip()) for l in open(rcfile).read().strip().split('\n')])


mutfiles = ['Bgl3_Lib1_ref_mutations_filtered.txt',
            'Bgl3_Lib1_sel1_mutations_filtered.txt',
            'Bgl3_Lib1_sel2_mutations_filtered.txt',
            'Bgl3_Lib1_sel3_mutations_filtered.txt',
            'Bgl3_Lib2_ref_mutations_filtered.txt',
            'Bgl3_Lib2_sel1_mutations_filtered.txt',
            'Bgl3_Lib2_sel2_mutations_filtered.txt',
            'Bgl3_Lib3_ref_mutations_filtered.txt',
            'Bgl3_Lib3_sel1_mutations_filtered.txt',
            'Bgl3_Lib3_sel2_mutations_filtered.txt',
            'Bgl3_Lib3_sel3_mutations_filtered.txt']


def m2s(reffile): 
    ref = open(reffile).read().strip()
    outfile = gzip.open(reffile.replace('mutations','sequences')+'.gz','wt')
    for variant in ref.split('\n'):
        variant_seq = WT.copy()

        for mut in variant.split(','):
            pos = int(mut[1:-1])
            AA = mut[-1]
            variant_seq[pos] = AA

        seq = ''.join([variant_seq[p] for p in WT])
        outfile.write(seq+'\n')


for m in mutfiles:
    print(m)
    m2s(m)
