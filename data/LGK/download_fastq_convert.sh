

# wget all the files from SRA
wget https://sra-download.ncbi.nlm.nih.gov/traces/sra73/SRR/008045/SRR8238225 # Amplicon sequencing of LGK: tile 1 reference population
wget https://sra-download.ncbi.nlm.nih.gov/traces/sra73/SRR/008045/SRR8238224 # Amplicon sequencing of LGK: tile 1 selected population

wget https://sra-download.ncbi.nlm.nih.gov/traces/sra73/SRR/008045/SRR8238229 # Amplicon sequencing of LGK: tile 2 reference population
wget https://sra-download.ncbi.nlm.nih.gov/traces/sra73/SRR/008045/SRR8238228 # Amplicon sequencing of LGK: tile 2 selected population

wget https://sra-download.ncbi.nlm.nih.gov/traces/sra73/SRR/008045/SRR8238231 # Amplicon sequencing of LGK: tile 3 reference population
wget https://sra-download.ncbi.nlm.nih.gov/traces/sra73/SRR/008045/SRR8238230 # Amplicon sequencing of LGK: tile 3 selected population

wget https://sra-download.ncbi.nlm.nih.gov/traces/sra73/SRR/008045/SRR8238227 # Amplicon sequencing of LGK: tile 4 reference population
wget https://sra-download.ncbi.nlm.nih.gov/traces/sra73/SRR/008045/SRR8238226 # Amplicon sequencing of LGK: tile 4 selected population


# convert to fastq
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR8238224
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR8238225
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR8238226
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR8238227
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR8238228
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR8238229
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR8238230
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR8238231


#rename 
# tile 1
mv SRR8238225_1.fastq LGK_tile1_ref_R1.fastq
mv SRR8238225_2.fastq LGK_tile1_ref_R2.fastq
mv SRR8238224_1.fastq LGK_tile1_sel_R1.fastq
mv SRR8238224_2.fastq LGK_tile1_sel_R2.fastq

# tile 2
mv SRR8238229_1.fastq LGK_tile2_ref_R1.fastq
mv SRR8238229_2.fastq LGK_tile2_ref_R2.fastq
mv SRR8238228_1.fastq LGK_tile2_sel_R1.fastq
mv SRR8238228_2.fastq LGK_tile2_sel_R2.fastq

# tile 3
mv SRR8238231_1.fastq LGK_tile3_ref_R1.fastq
mv SRR8238231_2.fastq LGK_tile3_ref_R2.fastq
mv SRR8238230_1.fastq LGK_tile3_sel_R1.fastq
mv SRR8238230_2.fastq LGK_tile3_sel_R2.fastq

# tile 4
mv SRR8238227_1.fastq LGK_tile4_ref_R1.fastq
mv SRR8238227_2.fastq LGK_tile4_ref_R2.fastq
mv SRR8238226_1.fastq LGK_tile4_sel_R1.fastq
mv SRR8238226_2.fastq LGK_tile4_sel_R2.fastq
