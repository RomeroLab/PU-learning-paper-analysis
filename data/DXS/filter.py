


ref = open('PreSelection01_chimeras.txt').read().strip().split('\n')

filtered = []
for ch in ref:
    if 'X' not in ch:
        filtered.append(ch.replace('1','A').replace('2','B').replace('3','C').replace('4','D'))


open('DXS_ref_sequences_filtered.txt','w').write('\n'.join(filtered))





sel = open('PostSelection01_chimeras.txt').read().strip().split('\n')

filtered = []
for ch in sel:
    if 'X' not in ch:
        filtered.append(ch.replace('1','A').replace('2','B').replace('3','C').replace('4','D'))


open('DXS_sel_sequences_filtered.txt','w').write('\n'.join(filtered))

