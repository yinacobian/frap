#!/usr/bin/python

import readline


filename = raw_input("enter file name: ")

with open(filename) as  file1:
	number_genomes = 0
	total_size =0
	genome_size= 0
	for line in file1:
		if line.startswith(">"):
			partial_size =0
			genome_size=0
			print line
			number_genomes += 1
		else:
			line=line.strip()
			partial_size = len(line)
			genome_size += partial_size
			print genome_size
			total_size += partial_size
print total_size
print "The number of genomes is: ", number_genomes
print "Mean = ", (total_size/number_genomes), "bp"