
# wget all the files from SRA
# only doing the first replicate.  Reps 2+3 are commented out 

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-1/SRR3113656/SRR3113656.1 # mutDNA1 (I beleive this is unselected)
#wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-1/SRR3113657/SRR3113657.1 # mutDNA2 (I beleive this is unselected)
#wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-1/SRR3113658/SRR3113658.1 # mutDNA3 (I beleive this is unselected)

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-7/SRR3113660/SRR3113660.1 # mutvirus1 (I beleive this is selected)
#wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-1/SRR3113661/SRR3113661.1 # mutvirus2 (I beleive this is selected)
#wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-1/SRR3113662/SRR3113662.1 # mutvirus3 (I beleive this is selected)


# convert to fastq
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR3113656.1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fastq-dump --split-files SRR3113660.1


#rename 
mv SRR3113656.1_1.fastq HA_ref_R1.fastq
mv SRR3113656.1_2.fastq HA_ref_R2.fastq

mv SRR3113660.1_1.fastq HA_sel_R1.fastq
mv SRR3113660.1_2.fastq HA_sel_R2.fastq

