#!/bin/bash

# prepare the six index files required by bowtie
bowtie2-build TPK1.fasta index_file
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


runs="TPK1_tile1_ref
TPK1_tile2_ref
TPK1_tile3_ref
TPK1_tile4_ref
TPK1_tile5_ref
TPK1_tile6_ref
TPK1_tile7_ref
TPK1_tile1_sel
TPK1_tile2_sel
TPK1_tile3_sel
TPK1_tile4_sel
TPK1_tile5_sel
TPK1_tile6_sel
TPK1_tile7_sel"



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

