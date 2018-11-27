#!/usr/bin/python

import os, glob

types = ('*.fna', '*.fasta')
files_grabbed = []
for files in types:
	files_grabbed.extend(glob.glob(files))

for filename in files_grabbed:
	with open(filename) as  file1:
		with open("database.fasta", "a") as file2:
			header= file1.readline()
			file2.write(header)
			for line in file1:
				if line.startswith(">"):
					next
				else:
					file2.write(line.strip("\n"))
			file2.write('\n')

with open("database.fasta", "r") as database:
	with open("db_id_name.txt", "w") as file3:
		for line in database:
			if line.startswith(">"):
				genome_name = line.split()
				myID = "".join(genome_name[0])
				myID = myID.split(">")
				myID = "".join(myID[1])
				LongName = " ".join(genome_name[1:-1])
				
			else:
				Length = len(line)
				
				file3.write(myID+"\t"+LongName+"\t"+str(Length)+"\n")


