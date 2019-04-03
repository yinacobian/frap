#!/bin/bash

#$ -N mg_vs_bact

#$ -j y

#$ -t 1-176

#qsub jmf-anthill.sh 

DS_FOLDER=/home1/mlittle/metagenomes_and_viromes_for_FRAP
DB_PATH=/home1/mlittle/DBs
DB_NAME=globalvirome_cobian2016_reference_library_cdhit98 
OUT_FOLDER=/home1/mlittle/FRAP_virus_80

#mkdir $OUT_FOLDER
#mkdir /home1/mlittle/FRAP_virus_80
#ls /home1/mlittle/metagenomes_and_viromes_for_FRAP | grep 'fasta' | cut -d '.' -f1 > /home1/mlittle/FRAP_virus_80/IDS.txt

#IDSFILE=$OUT_FOLDER/IDS.txt

IDSFILE=/home1/mlittle/FRAP_virus_80/IDS.txt
ID=$(cat $IDSFILE | head -n $SGE_TASK_ID | tail -n 1)
$ID
#smalt map -f sam -y 0.96 -o $OUT_FOLDER/$ID"."_vs_$DB_NAME.sam $DB_PATH/$DB_NAME $DS_FOLDER/$ID.fasta

PATH=$PATH:~/bin/smalt
smalt map -f sam -y 0.96 -o /home1/mlittle/FRAP_virus_80/${ID}_vs_$DB_NAME.sam $DB_PATH/$DB_NAME $DS_FOLDER/$ID.fasta

#echo smalt map -f sam -y 0.96 -o /home1/mlittle/FRAP_virus_80/${ID}_vs_$DB_NAME.sam $DB_PATH/$DB_NAME $DS_FOLDER/$ID.fasta

#test case that works:
smalt map -f sam -y 0.96 -o /home1/mlittle/FRAP_virus_80/FM5_1A_vs_globalvirome_cobian2016_reference_library_cdhit98.sam /home1/mlittle/DBs/globalvirome_cobian2016_reference_library_cdhit98 /home1/mlittle/metagenomes_and_viromes_for_FRAP/FM5_1A.fasta
