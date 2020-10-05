# wget all the files from SRA
# only doing the first replicate

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680677/SRR5680677.1 # DMS-TileSEQ for TPK1, tile 1, non-selective condition, replicate 1
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680635/SRR5680635.1 # DMS-TileSEQ for TPK1, tile 2, non-selective condition, replicate 1
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680674/SRR5680674.1 # DMS-TileSEQ for TPK1, tile 3, non-selective condition, replicate 1
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680718/SRR5680718.1 # DMS-TileSEQ for TPK1, tile 4, non-selective condition, replicate 1
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680717/SRR5680717.1 # DMS-TileSEQ for TPK1, tile 5, non-selective condition, replicate 1
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680693/SRR5680693.1 # DMS-TileSEQ for TPK1, tile 6, non-selective condition, replicate 1
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680694/SRR5680694.1 # DMS-TileSEQ for TPK1, tile 7, non-selective condition, replicate 1

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680669/SRR5680669.1 # DMS-TileSEQ for TPK1, tile 1, selective condition, replicate 1
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680632/SRR5680632.1 # DMS-TileSEQ for TPK1, tile 2, selective condition, replicate 1
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680722/SRR5680722.1 # DMS-TileSEQ for TPK1, tile 3, selective condition, replicate 1
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680719/SRR5680719.1 # DMS-TileSEQ for TPK1, tile 4, selective condition, replicate 1
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680689/SRR5680689.1 # DMS-TileSEQ for TPK1, tile 5, selective condition, replicate 1
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680692/SRR5680692.1 # DMS-TileSEQ for TPK1, tile 6, selective condition, replicate 1
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-11/SRR5680670/SRR5680670.1 # DMS-TileSEQ for TPK1, tile 7, selective condition, replicate 1



# convert to fastq
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680677.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680635.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680674.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680718.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680717.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680693.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680694.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680669.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680632.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680722.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680719.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680689.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680692.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR5680670.1


# rename 
mv SRR5680677.1_1.fastq TPK1_tile1_ref_R1.fastq
mv SRR5680635.1_1.fastq TPK1_tile2_ref_R1.fastq
mv SRR5680674.1_1.fastq TPK1_tile3_ref_R1.fastq
mv SRR5680718.1_1.fastq TPK1_tile4_ref_R1.fastq
mv SRR5680717.1_1.fastq TPK1_tile5_ref_R1.fastq
mv SRR5680693.1_1.fastq TPK1_tile6_ref_R1.fastq
mv SRR5680694.1_1.fastq TPK1_tile7_ref_R1.fastq
mv SRR5680669.1_1.fastq TPK1_tile1_sel_R1.fastq
mv SRR5680632.1_1.fastq TPK1_tile2_sel_R1.fastq
mv SRR5680722.1_1.fastq TPK1_tile3_sel_R1.fastq
mv SRR5680719.1_1.fastq TPK1_tile4_sel_R1.fastq
mv SRR5680689.1_1.fastq TPK1_tile5_sel_R1.fastq
mv SRR5680692.1_1.fastq TPK1_tile6_sel_R1.fastq
mv SRR5680670.1_1.fastq TPK1_tile7_sel_R1.fastq

mv SRR5680677.1_2.fastq TPK1_tile1_ref_R2.fastq
mv SRR5680635.1_2.fastq TPK1_tile2_ref_R2.fastq
mv SRR5680674.1_2.fastq TPK1_tile3_ref_R2.fastq
mv SRR5680718.1_2.fastq TPK1_tile4_ref_R2.fastq
mv SRR5680717.1_2.fastq TPK1_tile5_ref_R2.fastq
mv SRR5680693.1_2.fastq TPK1_tile6_ref_R2.fastq
mv SRR5680694.1_2.fastq TPK1_tile7_ref_R2.fastq
mv SRR5680669.1_2.fastq TPK1_tile1_sel_R2.fastq
mv SRR5680632.1_2.fastq TPK1_tile2_sel_R2.fastq
mv SRR5680722.1_2.fastq TPK1_tile3_sel_R2.fastq
mv SRR5680719.1_2.fastq TPK1_tile4_sel_R2.fastq
mv SRR5680689.1_2.fastq TPK1_tile5_sel_R2.fastq
mv SRR5680692.1_2.fastq TPK1_tile6_sel_R2.fastq
mv SRR5680670.1_2.fastq TPK1_tile7_sel_R2.fastq


