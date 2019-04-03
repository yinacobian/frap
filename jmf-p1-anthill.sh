#!/bin/bash

#$ -N toto

#$ -j y

#$ -t 1-11

# To submitt the job array : qsub -j y jmf-anthill.sh 

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



