
# cutoff: only include mutations that have greater than 10 mutations 
cut = 10

# filenames 
reffile = 'LGK_ref_mutations.txt'
selfile = 'LGK_sel_mutations.txt'

# read the files
ref = open(reffile).read().strip()
sel = open(selfile).read().strip()

# get a list of all the observed mutations
refmuts = ref.replace(' ','').replace('\n',',').split(',')
selmuts = sel.replace(' ','').replace('\n',',').split(',')

# find mutations that are present at least 10 times in both ref and sel
all_muts = sorted(set(refmuts+selmuts))
good = [m for m in all_muts if refmuts.count(m)>=cut and selmuts.count(m)>=cut]


# filter the ref file and write to new file
filtered_ref = []
for line in ref.split('\n'):
    muts = [mut for mut in line.split(',') if mut in good]
    if len(muts)>0:
        filtered_ref.append(','.join(muts))

open(reffile.replace('.txt','_filtered.txt'),'w').write('\n'.join(filtered_ref))


# filter the sel file and write to new file
filtered_sel = []
for line in sel.split('\n'):
    muts = [mut for mut in line.split(',') if mut in good]
    if len(muts)>0:
        filtered_sel.append(','.join(muts))

open(selfile.replace('.txt','_filtered.txt'),'w').write('\n'.join(filtered_sel))

