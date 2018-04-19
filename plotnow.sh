#!/bin/bash
#make a list of IDS:
#ls | grep 'fasta' > IDS.txt

#Map to reference genomes
#cat $1 | xargs -I{id} sh -c 'smalt index -k 10 -s 5 {id} {id}.fasta'
#cat $1 | xargs -I{id} sh -c 'smalt map -x -y 0.7 -n 20 -f samsoft -o map_{id}_CF146mt03292018.samsoft {id} /home/acobian/CF146_042018/polish/CF146mt03292018_polish.fasta'

#Create mpileup files with coverage 
cat $1 | xargs -I{id} sh -c '/home/SOFTWARE/samtools-1.6/samtools view -b -T {id}.fasta map_{id}_CF146mt03292018.samsoft -o map_{id}_CF146mt03292018.bam'
cat $1 | xargs -I{id} sh -c '/home/SOFTWARE/samtools-1.6/samtools sort -O bam -T toto map_{id}_CF146mt03292018.bam -o sorted_map_{id}_CF146mt03292018.bam'
cat $1 | xargs -I{id} sh -c '/home/SOFTWARE/samtools-1.6/samtools mpileup -d 10000000 -a --reference {id}.fasta sorted_map_{id}_CF146mt03292018.bam -o mpileup_map_{id}_CF146mt03292018.tab'
cat $1 | xargs -I{id} sh -c 'cut -f 1,4 mpileup_map_{id}_CF146mt03292018.tab > cov_mpileup_map_{id}_CF146mt03292018.tab'

#Coverage plots, needs the script PlotCoverage.R
cat $1 | xargs -I{id} sh -c 'Rscript PlotCoverage.R {id}'

#cat $1 | xargs -I{id} sh -c ''


