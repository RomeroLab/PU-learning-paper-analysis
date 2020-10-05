
# cutoff: only include mutations that have greater than 10 mutations 
cut = 10


 ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 ##### ##### LIB1 #####

# filenames 
reffile = 'Bgl3_Lib1_ref_mutations.txt'
selfile1 = 'Bgl3_Lib1_sel1_mutations.txt'
selfile2 = 'Bgl3_Lib1_sel2_mutations.txt'
selfile3 = 'Bgl3_Lib1_sel3_mutations.txt'


# read the files
ref = open(reffile).read().strip()
sel1 = open(selfile1).read().strip()
sel2 = open(selfile2).read().strip()
sel3 = open(selfile3).read().strip()

# get a list of all the observed mutations
refmuts = ref.replace(' ','').replace('\n',',').split(',')
selmuts1 = sel1.replace(' ','').replace('\n',',').split(',')
selmuts2 = sel2.replace(' ','').replace('\n',',').split(',')
selmuts3 = sel3.replace(' ','').replace('\n',',').split(',')

# find mutations that are present at least 10 times in both ref and sel
all_muts = sorted(set(refmuts+selmuts1+selmuts2+selmuts3))
good = [m for m in all_muts if refmuts.count(m)>=cut and selmuts1.count(m)>=cut and selmuts2.count(m)>=cut and selmuts3.count(m)>=cut]


# filter the ref file and write to new file
filtered_ref = []
for line in ref.split('\n'):
    muts = [mut for mut in line.split(',') if mut in good]
    if len(muts)>0:
        filtered_ref.append(','.join(muts))

open(reffile.replace('.txt','_filtered.txt'),'w').write('\n'.join(filtered_ref))


# filter the sel file and write to new file
filtered_sel = []
for line in sel1.split('\n'):
    muts = [mut for mut in line.split(',') if mut in good]
    if len(muts)>0:
        filtered_sel.append(','.join(muts))

open(selfile1.replace('.txt','_filtered.txt'),'w').write('\n'.join(filtered_sel))

# filter the sel file and write to new file
filtered_sel = []
for line in sel2.split('\n'):
    muts = [mut for mut in line.split(',') if mut in good]
    if len(muts)>0:
        filtered_sel.append(','.join(muts))

open(selfile2.replace('.txt','_filtered.txt'),'w').write('\n'.join(filtered_sel))


# filter the sel file and write to new file
filtered_sel = []
for line in sel3.split('\n'):
    muts = [mut for mut in line.split(',') if mut in good]
    if len(muts)>0:
        filtered_sel.append(','.join(muts))

open(selfile3.replace('.txt','_filtered.txt'),'w').write('\n'.join(filtered_sel))




 ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 #####  ##### LIB2 ##### 

# filenames 
reffile = 'Bgl3_Lib2_ref_mutations.txt'
selfile1 = 'Bgl3_Lib2_sel1_mutations.txt'
selfile2 = 'Bgl3_Lib2_sel2_mutations.txt'


# read the files
ref = open(reffile).read().strip()
sel1 = open(selfile1).read().strip()
sel2 = open(selfile2).read().strip()

# get a list of all the observed mutations
refmuts = ref.replace(' ','').replace('\n',',').split(',')
selmuts1 = sel1.replace(' ','').replace('\n',',').split(',')
selmuts2 = sel2.replace(' ','').replace('\n',',').split(',')

# find mutations that are present at least 10 times in both ref and sel
all_muts = sorted(set(refmuts+selmuts1+selmuts2))
good = [m for m in all_muts if refmuts.count(m)>=cut and selmuts1.count(m)>=cut and selmuts2.count(m)>=cut]


# filter the ref file and write to new file
filtered_ref = []
for line in ref.split('\n'):
    muts = [mut for mut in line.split(',') if mut in good]
    if len(muts)>0:
        filtered_ref.append(','.join(muts))

open(reffile.replace('.txt','_filtered.txt'),'w').write('\n'.join(filtered_ref))


# filter the sel file and write to new file
filtered_sel = []
for line in sel1.split('\n'):
    muts = [mut for mut in line.split(',') if mut in good]
    if len(muts)>0:
        filtered_sel.append(','.join(muts))

open(selfile1.replace('.txt','_filtered.txt'),'w').write('\n'.join(filtered_sel))

# filter the sel file and write to new file
filtered_sel = []
for line in sel2.split('\n'):
    muts = [mut for mut in line.split(',') if mut in good]
    if len(muts)>0:
        filtered_sel.append(','.join(muts))

open(selfile2.replace('.txt','_filtered.txt'),'w').write('\n'.join(filtered_sel))





 ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 #####  ##### LIB3 ##### 

# filenames 
reffile = 'Bgl3_Lib3_ref_mutations.txt'
selfile1 = 'Bgl3_Lib3_sel1_mutations.txt'
selfile2 = 'Bgl3_Lib3_sel2_mutations.txt'
selfile3 = 'Bgl3_Lib3_sel3_mutations.txt'


# read the files
ref = open(reffile).read().strip()
sel1 = open(selfile1).read().strip()
sel2 = open(selfile2).read().strip()
sel3 = open(selfile3).read().strip()

# get a list of all the observed mutations
refmuts = ref.replace(' ','').replace('\n',',').split(',')
selmuts1 = sel1.replace(' ','').replace('\n',',').split(',')
selmuts2 = sel2.replace(' ','').replace('\n',',').split(',')
selmuts3 = sel3.replace(' ','').replace('\n',',').split(',')

# find mutations that are present at least 10 times in both ref and sel
all_muts = sorted(set(refmuts+selmuts1+selmuts2+selmuts3))
good = [m for m in all_muts if refmuts.count(m)>=cut and selmuts1.count(m)>=cut and selmuts2.count(m)>=cut and selmuts3.count(m)>=cut]


# filter the ref file and write to new file
filtered_ref = []
for line in ref.split('\n'):
    muts = [mut for mut in line.split(',') if mut in good]
    if len(muts)>0:
        filtered_ref.append(','.join(muts))

open(reffile.replace('.txt','_filtered.txt'),'w').write('\n'.join(filtered_ref))


# filter the sel file and write to new file
filtered_sel = []
for line in sel1.split('\n'):
    muts = [mut for mut in line.split(',') if mut in good]
    if len(muts)>0:
        filtered_sel.append(','.join(muts))

open(selfile1.replace('.txt','_filtered.txt'),'w').write('\n'.join(filtered_sel))

# filter the sel file and write to new file
filtered_sel = []
for line in sel2.split('\n'):
    muts = [mut for mut in line.split(',') if mut in good]
    if len(muts)>0:
        filtered_sel.append(','.join(muts))

open(selfile2.replace('.txt','_filtered.txt'),'w').write('\n'.join(filtered_sel))


# filter the sel file and write to new file
filtered_sel = []
for line in sel3.split('\n'):
    muts = [mut for mut in line.split(',') if mut in good]
    if len(muts)>0:
        filtered_sel.append(','.join(muts))

open(selfile3.replace('.txt','_filtered.txt'),'w').write('\n'.join(filtered_sel))



