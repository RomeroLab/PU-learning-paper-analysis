
# download via SRA toolkit (this is the correct way)
~/code/sratoolkit.2.10.4-centos_linux64/bin/fasterq-dump SRR11472224 #DMS of Bgl3 from Streptomyces, Library1, unsorted 
~/code/sratoolkit.2.10.4-centos_linux64/bin/fasterq-dump SRR11472223 #DMS of Bgl3 from Streptomyces, Library1, sort1 
~/code/sratoolkit.2.10.4-centos_linux64/bin/fasterq-dump SRR11472221 #DMS of Bgl3 from Streptomyces, Library1, sort2              
~/code/sratoolkit.2.10.4-centos_linux64/bin/fasterq-dump SRR11472220 #DMS of Bgl3 from Streptomyces, Library1, sort3              
~/code/sratoolkit.2.10.4-centos_linux64/bin/fasterq-dump SRR11472219 #High-temp DMS of Bgl3 from Streptomyces, Library2, unsorted
~/code/sratoolkit.2.10.4-centos_linux64/bin/fasterq-dump SRR11472218 #High-temp DMS of Bgl3 from Streptomyces, Library2, sort1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fasterq-dump SRR11472216 #High-temp DMS of Bgl3 from Streptomyces, Library2, sort2
~/code/sratoolkit.2.10.4-centos_linux64/bin/fasterq-dump SRR11472215 #High-temp DMS of Bgl3 from Streptomyces, Library3, unsorted
~/code/sratoolkit.2.10.4-centos_linux64/bin/fasterq-dump SRR11472214 #High-temp DMS of Bgl3 from Streptomyces, Library3, sort1
~/code/sratoolkit.2.10.4-centos_linux64/bin/fasterq-dump SRR11472217 #High-temp DMS of Bgl3 from Streptomyces, Library3, sort2
~/code/sratoolkit.2.10.4-centos_linux64/bin/fasterq-dump SRR11472222 #High-temp DMS of Bgl3 from Streptomyces, Library3, sort3


# rename 
mv SRR11472224_1.fastq Bgl3_Lib1_ref_R1.fastq
mv SRR11472223_1.fastq Bgl3_Lib1_sel1_R1.fastq
mv SRR11472221_1.fastq Bgl3_Lib1_sel2_R1.fastq
mv SRR11472220_1.fastq Bgl3_Lib1_sel3_R1.fastq
mv SRR11472219_1.fastq Bgl3_Lib2_ref_R1.fastq
mv SRR11472218_1.fastq Bgl3_Lib2_sel1_R1.fastq
mv SRR11472216_1.fastq Bgl3_Lib2_sel2_R1.fastq
mv SRR11472215_1.fastq Bgl3_Lib3_ref_R1.fastq
mv SRR11472214_1.fastq Bgl3_Lib3_sel1_R1.fastq
mv SRR11472217_1.fastq Bgl3_Lib3_sel2_R1.fastq
mv SRR11472222_1.fastq Bgl3_Lib3_sel3_R1.fastq
mv SRR11472224_2.fastq Bgl3_Lib1_ref_R2.fastq
mv SRR11472223_2.fastq Bgl3_Lib1_sel1_R2.fastq
mv SRR11472221_2.fastq Bgl3_Lib1_sel2_R2.fastq
mv SRR11472220_2.fastq Bgl3_Lib1_sel3_R2.fastq
mv SRR11472219_2.fastq Bgl3_Lib2_ref_R2.fastq
mv SRR11472218_2.fastq Bgl3_Lib2_sel1_R2.fastq
mv SRR11472216_2.fastq Bgl3_Lib2_sel2_R2.fastq
mv SRR11472215_2.fastq Bgl3_Lib3_ref_R2.fastq
mv SRR11472214_2.fastq Bgl3_Lib3_sel1_R2.fastq
mv SRR11472217_2.fastq Bgl3_Lib3_sel2_R2.fastq
mv SRR11472222_2.fastq Bgl3_Lib3_sel3_R2.fastq
