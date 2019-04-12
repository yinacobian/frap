#!/bin/bash

#$ -N toto

#$ -j y

#$ -t 1-11

# To submitt the job array : qsub jmf-p1-anthill.sh 

##To be able to use, make sure you have smalt in your path. To so so:
## 0.Find the path to smalt on the server  or download it to your home bin folder ans install it there (if your don't have a bin folder, create one "mkdir bin"), then download smalt: https://www.sanger.ac.uk/science/tools/smalt-0
## 1.Go to your home folder and type nano .bashrc
## 2.In that file add the following line at the end (replace /home3/acobian with your home directory: export PATH=$PATH:/home3/acobian/bin/smalt
## 3.Exit from nano and save the changes: (ctrl + x) then yes
## 4.Reload your .bashrc file: exec bash
## 5.Test that smalt works byt typing: smalt (you should get the help commands when you type smalt)



DS_FOLDER=/home3/acobian/cobian2018CF/P04_polished
DB_PATH=/home3/acobian/DBS
DB_NAME=all_viral 
OUT_FOLDER=/home3/acobian/frap-anthill/cobian2019_vs_viralrefseq

#PATH=$PATH:~/bin/smalt
PATH=$PATH:/usr/local/smalt/bin/

if [ $SGE_TASK_ID == 1 ]; then
	mkdir $OUT_FOLDER
	ls $DS_FOLDER | grep 'fasta' | cut -d '.' -f1 > ${OUT_FOLDER}/IDS.txt
	smalt index -k 15 -s 5 ${DB_PATH}/${DB_NAME} ${DB_PATH}/${DB_NAME}.fasta
	fi

until [ -e ${DB_PATH}/${DB_NAME}.smi ] && [ -e ${OUT_FOLDER}/IDS.txt ]; do
	sleep 5
	done  

	IDSFILE=${OUT_FOLDER}/IDS.txt
	ID=$(cat $IDSFILE | head -n $SGE_TASK_ID | tail -n 1)
	smalt map -f sam -y 0.96 -o ${OUT_FOLDER}/${ID}_vs_${DB_NAME}.sam ${DB_PATH}/${DB_NAME} ${DS_FOLDER}/${ID}.fasta



