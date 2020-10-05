import gzip

code = {'AAA': 'K','AAC': 'N','AAG': 'K','AAT': 'N','ACA': 'T','ACC': 'T','ACG': 'T','ACT': 'T','AGA': 'R','AGC': 'S','AGG': 'R','AGT': 'S','ATA': 'I','ATC': 'I','ATG': 'M','ATT': 'I',
        'CAA': 'Q','CAC': 'H','CAG': 'Q','CAT': 'H','CCA': 'P','CCC': 'P','CCG': 'P','CCT': 'P','CGA': 'R','CGC': 'R','CGG': 'R','CGT': 'R','CTA': 'L','CTC': 'L','CTG': 'L','CTT': 'L',
        'GAA': 'E','GAC': 'D','GAG': 'E','GAT': 'D','GCA': 'A','GCC': 'A','GCG': 'A','GCT': 'A','GGA': 'G','GGC': 'G','GGG': 'G','GGT': 'G','GTA': 'V','GTC': 'V','GTG': 'V','GTT': 'V',
        'TAA': '*','TAC': 'Y','TAG': '*','TAT': 'Y','TCA': 'S','TCC': 'S','TCG': 'S','TCT': 'S','TGA': '*','TGC': 'C','TGG': 'W','TGT': 'C','TTA': 'L','TTC': 'F','TTG': 'L','TTT': 'F',
        '---': '-'}

def translate(NT_seq):
    codons = [NT_seq[(3*i):(3*i)+3] for i in range(   len(NT_seq)//3 )]
    AA_seq = ''.join(code[c] if c in code else 'X' for c in codons)
    return AA_seq


def chimera2sequence(block_alignment,chimera_seq):
    blocks = sorted(set([p[0] for p in block_alignment]))
    parents = range(len(block_alignment[0][1:]))
    chimera_seq = [int(i)-1 for i in chimera_seq]
    if len(blocks)!=len(chimera_seq):
        print('chimera sequence needs contain the same number of blocks as the block alignment')
        return
    if max(chimera_seq)>max(parents):
        print('too many parents - chimera blocks are not in block alignment')
        return
    sequence = ''.join([pos[chimera_seq[blocks.index(pos[0])]+1] for pos in block_alignment])
    return sequence

def generate_chimera_seqs(parents,blocks):
    parents = [str(p) for p in range(1,parents+1)]
    seqs = ['']
    for i in range(blocks):
        ns = []
        for s in seqs:
            for p in parents:
                ns.append(s+p)
        seqs = ns
    return seqs


def make_all_chimeras(block_alignment):
    '''given a block alignment, make a dictionary with all chimera sequences'''
    num_blocks = len(set([p[0] for p in block_alignment]))
    num_parents = len(block_alignment[0][1:])
    ch_seqs = generate_chimera_seqs(num_parents,num_blocks)
    chimeras = {}
    for ch in ch_seqs:
        chimeras[ch] = chimera2sequence(block_alignment,ch)
    return chimeras


# a bunch of processing--sorry it's messy...
block_alignment = [p for p in tuple(zip(*[l for l in open('DXS_blocks_NT_alignment_and_100updown.fasta').read().strip().split('\n') if len(l)>100])) if p[0]!='u']
AAseqs = [translate(''.join(s)) for s in zip(*[p[1:] for p in block_alignment])]
NT_blocks = ''.join([p[0] for p in block_alignment]) 
codon_blocks = [NT_blocks[(3*i):(3*i)+3] for i in range(len(NT_blocks)//3 )]
AA_blocks = ''.join([c[1] for c in codon_blocks])
block_alignment = tuple(zip(*[AA_blocks,]+AAseqs))


# a dictionary that maps chimera block sequence to an amino acid sequence
ch2seq = make_all_chimeras(block_alignment) 


# load in the chimera block sequences (need to convert letters back to numbers)
ref = [s.replace('A','1').replace('B','2').replace('C','3').replace('D','4') for s in open('DXS_ref_sequences_filtered.txt').read().strip().split('\n')]
sel = [s.replace('A','1').replace('B','2').replace('C','3').replace('D','4') for s in open('DXS_sel_sequences_filtered.txt').read().strip().split('\n')]

refAAs = [ch2seq[s] for s in ref]
gzip.open('DXS_ref_AA_sequences.txt.gz','wt').write('\n'.join(refAAs))

selAAs = [ch2seq[s] for s in sel]
gzip.open('DXS_sel_AA_sequences.txt.gz','wt').write('\n'.join(selAAs))
