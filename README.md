# FRAP
![fragment recruitment assembly purification!](FRAP_pic.png)

Fragment Recruitment Assembly Purification 

Quick and simple bioinformatics!

FRAP is a robust and simple algorithm to compare a genomic dataset to a database

![jmf!](jmf_pic.png)

By using the same method across databases and datasets the comparissons are eassier 

### Use ###

Use: jmf3.pl [path to directory containing the datasets] [path to database fasta file] [path to results folder] [mapper to use: smalt or hisat]

### I/O ### 
Input 
Database: fasta file containing the sequences to compare
Dataset: fasta file with query sequences

Output
Normalized hits 
Number of hits

Optional outputs
fasta file with reads that map to the refenrence database
fasta file with reads that do not map to the reference database

### Dependencies ###

FRAP require a set of tools, most of these tools are installed using the setup.sh script if they are already not in your path.
  
### Installing <this software> from Github

1. `git clone https://github.com/yinacobian/frap/`
2. `bash setup.sh -I`
  
The following tools are downloaded and installed by setup.sh file if not already installed and in your path
* **SMALT** http://www.sanger.ac.uk/science/tools/smalt-0
* **hisat2** https://ccb.jhu.edu/software/hisat2/index.shtml
* **diamond** https://github.com/bbuchfink/diamond

