#!/bin/bash

# prepare the six index files required by bowtie
bowtie2-build 1GNXpet22_SgrAI_DraIII.fasta index_file
clear 

#BOWTIE2 options:
  #alignment types:
  # --end-to-end: requires ends of reads to match (default)
  # --local: will trim off the ends of a read if it helps the alignment                                                                                                              

  # standard options:
  #--no-unal: don't write sequences that failed to align                                                       
  #--no-hd: don't have a SAM header                                                                                                                         
  #--maxins 2000: search for inserts that are up to 2000 bp (RE fragment was 1800 bp)
  # -p 7: use 7 cores
  #--dovetail: allow dovetails
  #--no-discordant: don't look for discordant alignments (instead just map reads individually)

  #--fr/--rf/--ff: relative orientation of reads (inward, outward, and same direction), default is inward


runs="Bgl3_Lib1_ref
Bgl3_Lib1_sel1
Bgl3_Lib1_sel2
Bgl3_Lib1_sel3
Bgl3_Lib2_ref
Bgl3_Lib2_sel1
Bgl3_Lib2_sel2
Bgl3_Lib3_ref
Bgl3_Lib3_sel1
Bgl3_Lib3_sel2
Bgl3_Lib3_sel3"

# save various alignment info to this file
alnstats="alignment_stats.txt"

# record the date/time
date > $alnstats
echo >> $alnstats

# record the bowtie version
bowtie2 --version >> $alnstats

for r in $runs
do
    echo >> $alnstats
    echo bowtie2 --very-sensitive-local --maxins 2000 --dovetail --no-discordant --no-unal --no-hd -p 1 -x index_file -1 "$r"_R1.fastq -2 "$r"_R2.fastq -S "$r".sam 1>> $alnstats
    bowtie2 --very-sensitive-local --maxins 2000 --dovetail --no-discordant --no-unal --no-hd -p 1 -x index_file -1 "$r"_R1.fastq -2 "$r"_R2.fastq -S "$r".sam 2>> $alnstats
done

