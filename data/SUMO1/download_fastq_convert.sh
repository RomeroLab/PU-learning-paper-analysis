# wget all the files from SRA
# only doing the first replicate

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680627/SRR5680627.1 # DMS-TileSEQ for SUMO1, tile 1, non-selective condition, replicate 1 
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680629/SRR5680629.1 # DMS-TileSEQ for SUMO1, tile 2, non-selective condition, replicate 1
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680640/SRR5680640.1 # DMS-TileSEQ for SUMO1, tile 3, non-selective condition, replicate 1

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680625/SRR5680625.1 # DMS-TileSEQ for SUMO1, tile 1, selective condition, replicate 1 
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680634/SRR5680634.1 # DMS-TileSEQ for SUMO1, tile 2, selective condition, replicate 1
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680638/SRR5680638.1 # DMS-TileSEQ for SUMO1, tile 3, selective condition, replicate 1


# convert to fastq
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680627.1 
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680629.1 
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680640.1 
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680625.1 
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680634.1 
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680638.1 


#rename 
mv SRR5680627.1_1.fastq SUMO1_tile1_ref_R1.fastq
mv SRR5680629.1_1.fastq SUMO1_tile2_ref_R1.fastq
mv SRR5680640.1_1.fastq SUMO1_tile3_ref_R1.fastq
mv SRR5680625.1_1.fastq SUMO1_tile1_sel_R1.fastq
mv SRR5680634.1_1.fastq SUMO1_tile2_sel_R1.fastq
mv SRR5680638.1_1.fastq SUMO1_tile3_sel_R1.fastq

mv SRR5680627.1_2.fastq SUMO1_tile1_ref_R2.fastq
mv SRR5680629.1_2.fastq SUMO1_tile2_ref_R2.fastq
mv SRR5680640.1_2.fastq SUMO1_tile3_ref_R2.fastq
mv SRR5680625.1_2.fastq SUMO1_tile1_sel_R2.fastq
mv SRR5680634.1_2.fastq SUMO1_tile2_sel_R2.fastq
mv SRR5680638.1_2.fastq SUMO1_tile3_sel_R2.fastq
