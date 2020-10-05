
# wget all the files from SRA
# only doing the first replicate

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680697/SRR5680697.1 # DMS-TileSEQ for UBE2I, tile 1, non-selective condition, replicate 1 
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680703/SRR5680703.1 # DMS-TileSEQ for UBE2I, tile 2, non-selective condition, replicate 1 
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680713/SRR5680713.1 # DMS-TileSEQ for UBE2I, tile 3, non-selective condition, replicate 1 
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680715/SRR5680715.1 # DMS-TileSEQ for UBE2I, tile 4, non-selective condition, replicate 1 

# NOTE: there is an error in the SRA entry and there is no replicate 1 for tile 5, non-selective condition.  There are two entires for replicate 2: 
#    SRX2915957: DMS-TileSEQ for UBE2I, tile 5, non-selective condition, replicate 2
#    SRX2915954: DMS-TileSEQ for UBE2I, tile 5, non-selective condition, replicate 2
# I kinda arbitrarily chose this one: 
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680731/SRR5680731.1 # DMS-TileSEQ for UBE2I, tile 5, non-selective condition, replicate 2 (I THINK THIS IS 1)


wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680699/SRR5680699.1 # DMS-TileSEQ for UBE2I, tile 1, selective condition, replicate 1
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680705/SRR5680705.1 # DMS-TileSEQ for UBE2I, tile 2, selective condition, replicate 1
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680707/SRR5680707.1 # DMS-TileSEQ for UBE2I, tile 3, selective condition, replicate 1 
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680727/SRR5680727.1 # DMS-TileSEQ for UBE2I, tile 4, selective condition, replicate 1 
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680733/SRR5680733.1 # DMS-TileSEQ for UBE2I, tile 5, selective condition, replicate 1 


# convert to fastq
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680697.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680703.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680713.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680715.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680731.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680699.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680705.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680707.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680727.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680733.1

#rename 
mv SRR5680697.1_1.fastq UBE2I_tile1_ref_R1.fastq
mv SRR5680703.1_1.fastq UBE2I_tile2_ref_R1.fastq
mv SRR5680713.1_1.fastq UBE2I_tile3_ref_R1.fastq
mv SRR5680715.1_1.fastq UBE2I_tile4_ref_R1.fastq
mv SRR5680731.1_1.fastq UBE2I_tile5_ref_R1.fastq
mv SRR5680699.1_1.fastq UBE2I_tile1_sel_R1.fastq
mv SRR5680705.1_1.fastq UBE2I_tile2_sel_R1.fastq
mv SRR5680707.1_1.fastq UBE2I_tile3_sel_R1.fastq
mv SRR5680727.1_1.fastq UBE2I_tile4_sel_R1.fastq
mv SRR5680733.1_1.fastq UBE2I_tile5_sel_R1.fastq

mv SRR5680697.1_2.fastq UBE2I_tile1_ref_R2.fastq
mv SRR5680703.1_2.fastq UBE2I_tile2_ref_R2.fastq
mv SRR5680713.1_2.fastq UBE2I_tile3_ref_R2.fastq
mv SRR5680715.1_2.fastq UBE2I_tile4_ref_R2.fastq
mv SRR5680731.1_2.fastq UBE2I_tile5_ref_R2.fastq
mv SRR5680699.1_2.fastq UBE2I_tile1_sel_R2.fastq
mv SRR5680705.1_2.fastq UBE2I_tile2_sel_R2.fastq
mv SRR5680707.1_2.fastq UBE2I_tile3_sel_R2.fastq
mv SRR5680727.1_2.fastq UBE2I_tile4_sel_R2.fastq
mv SRR5680733.1_2.fastq UBE2I_tile5_sel_R2.fastq
