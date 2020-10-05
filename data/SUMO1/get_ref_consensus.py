import sequence_tools

nreads = 100000 # read first nread sequences from each file

files = ['SUMO1_tile1_ref_R1.fastq',
'SUMO1_tile1_ref_R2.fastq',
'SUMO1_tile2_ref_R1.fastq',
'SUMO1_tile2_ref_R2.fastq',
'SUMO1_tile3_ref_R1.fastq',
'SUMO1_tile3_ref_R2.fastq']


consseqs = []
for f in files: 
    fastq = open(f)

    seqs = []
    for k in range(nreads):
        line = fastq.readline().strip()
        if k%4==1: 
            seqs.append(line)

    maxlen = max([len(l) for l in seqs])

    seqs = [s for s in seqs if len(s)==maxlen]

    consensus = ''
    frac = []
    for pos in zip(*(seqs)):
        count,base = max([(pos.count(n),n) for n in 'ACGT'])
        consensus += base
        frac.append(count/len(seqs))

    print(f+' consensus:\n%s'%consensus)
    print('Lowest confidence position: %0.2f (want this at least 0.5)'%min(frac))
    consseqs.append(consensus)



# I got this from LT735669.1 Human ORFeome Gateway entry vector pENTR223-SUMO1, complete sequence AND TRIMMED TO THE APPROX SIZE
seq = 'CAACTTTGTACAAAAAAGTTGGCATGTCTGACCAGGAGGCAAAACCTTCAACTGAGGACTTGGGGGATAAGAAGGAAGGTGAATATATTAAACTCAAAGTCATTGGACAGGATAGCAGTGAGATTCACTTCAAAGTGAAAATGACAACACATCTCAAGAAACTCAAAGAATCATACTGTCAAAGACAGGGTGTTCCAATGAATTCACTCAGGTTTCTCTTTGAGGGTCAGAGAATTGCTGATAATAATACTCCAAAAGAACTGGGAATGGAGGAAGAAGATGTGATTGAAGTTTATCAGGAACAAACGGGGGGTCATTCAACAGTTTACCCAACTTTCTTGTACAAAGTTGGCATTATAAGAAA'

align = sequence_tools.muscle_align([seq,consseqs[0],sequence_tools.reverse_complement(consseqs[1]),consseqs[2],sequence_tools.reverse_complement(consseqs[3]),consseqs[4],sequence_tools.reverse_complement(consseqs[5])])
diff = ''.join(['*' if len(set([a for a in p if a in 'ACGT']))==1 else '#' for p in align])
align = [align[p]+(diff[p],) for p in range(len(align))]

sequence_tools.print_alignment(align)
