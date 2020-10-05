

# wget all the files from SRA
wget https://sra-download.ncbi.nlm.nih.gov/traces/sra73/SRR/008045/SRR8238223 # Amplicon sequencing of PyKS: tile 1 reference population
wget https://sra-download.ncbi.nlm.nih.gov/traces/sra73/SRR/008045/SRR8238222 # Amplicon sequencing of PyKS: tile 1 selected population
wget https://sra-download.ncbi.nlm.nih.gov/traces/sra73/SRR/008045/SRR8238221 # Amplicon sequencing of PyKS: tile 2 reference population
wget https://sra-download.ncbi.nlm.nih.gov/traces/sra73/SRR/008045/SRR8238220 # Amplicon sequencing of PyKS: tile 2 selected population
wget https://sra-download.ncbi.nlm.nih.gov/traces/sra73/SRR/008045/SRR8238219 # Amplicon sequencing of PyKS: tile 4 reference population
wget https://sra-download.ncbi.nlm.nih.gov/traces/sra73/SRR/008045/SRR8238218 # Amplicon sequencing of PyKS: tile 4 selected population
wget https://sra-download.ncbi.nlm.nih.gov/traces/sra73/SRR/008045/SRR8238217 # Amplicon sequencing of PyKS: tile 5 reference population
wget https://sra-download.ncbi.nlm.nih.gov/traces/sra73/SRR/008045/SRR8238216 # Amplicon sequencing of PyKS: tile 5 selected population

# convert to fastq
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR8238223
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR8238222
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR8238221
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR8238220
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR8238219
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR8238218
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR8238217
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR8238216


#rename 
# tile 1
mv SRR8238223_1.fastq PyKS_tile1_ref_R1.fastq
mv SRR8238223_2.fastq PyKS_tile1_ref_R2.fastq
mv SRR8238222_1.fastq PyKS_tile1_sel_R1.fastq
mv SRR8238222_2.fastq PyKS_tile1_sel_R2.fastq

# tile 2
mv SRR8238221_1.fastq PyKS_tile2_ref_R1.fastq
mv SRR8238221_2.fastq PyKS_tile2_ref_R2.fastq
mv SRR8238220_1.fastq PyKS_tile2_sel_R1.fastq
mv SRR8238220_2.fastq PyKS_tile2_sel_R2.fastq

# tile 4
mv SRR8238219_1.fastq PyKS_tile4_ref_R1.fastq
mv SRR8238219_2.fastq PyKS_tile4_ref_R2.fastq
mv SRR8238218_1.fastq PyKS_tile4_sel_R1.fastq
mv SRR8238218_2.fastq PyKS_tile4_sel_R2.fastq

# tile 5
mv SRR8238217_1.fastq PyKS_tile5_ref_R1.fastq
mv SRR8238217_2.fastq PyKS_tile5_ref_R2.fastq
mv SRR8238216_1.fastq PyKS_tile5_sel_R1.fastq
mv SRR8238216_2.fastq PyKS_tile5_sel_R2.fastq
