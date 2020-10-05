import pickle


WT = "MYYKEIAHALFSALFALSELYIAVRY*" # the wild-type Rocker amino acid sequence.  From Emily.  I double checked.
ref = pickle.load(open("18.Feb.2019_MAEN8_unsorted_S4_aaseqs.pkl", "rb"))[1]
sel = pickle.load(open("18.Feb.2019_MAEN8_active_S1_aaseqs.pkl", "rb"))[1]


# determine the ref mutations
ref_muts = []
for seq in ref:
    if seq != WT:
        muts = []
        for p in range(len(WT)):
            if seq[p] != WT[p]:
                muts.append(WT[p]+str(p)+seq[p])
        ref_muts.append(','.join(muts))



# determine the sel mutations
sel_muts = []
for seq in sel:
    if seq != WT:
        muts = []
        for p in range(len(WT)):
            if seq[p] != WT[p]:
                muts.append(WT[p]+str(p)+seq[p])
        sel_muts.append(','.join(muts))





# filter less than 10 like I've been doing with the other DMS data sets

# cutoff: only include mutations that have greater than 10 mutations                                                                                                                                                                        
cut = 10

# get a list of all the observed mutations                                                                                                                                                                                   
refmuts = ','.join(ref_muts).split(',')
selmuts = ','.join(sel_muts).split(',')

# find mutations that are present at least 10 times in both ref and sel                                                                                                                                                                
all_muts = sorted(set(refmuts+selmuts))
good = [m for m in all_muts if refmuts.count(m)>=cut and selmuts.count(m)>=cut]


# filter the ref file and write to new file                                                                                                                                                                                  
filtered_ref = []
for line in ref_muts:
    muts = [mut for mut in line.split(',') if mut in good]
    if len(muts)>0:
        filtered_ref.append(','.join(muts))

open('Rocker_ref_mutations_filtered.txt','w').write('\n'.join(filtered_ref))


# filter the sel file and write to new file                                                                                                                                                                                         
filtered_sel = []
for line in sel_muts:
    muts = [mut for mut in line.split(',') if mut in good]
    if len(muts)>0:
        filtered_sel.append(','.join(muts))

open('Rocker_sel_mutations_filtered.txt','w').write('\n'.join(filtered_sel))
