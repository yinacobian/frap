#samsoft to fasta of the reads that do not map on the alignemnt
#This script get the reads that map to the database 
#USE: perl samsoft2fasta_sihits.pl file.sam > hits.fasta 

open (SAMSOFT, $ARGV[0]);
my @line;

while (<SAMSOFT>){
        $line=$_;
        if ($line =~ m/^@/){}
                else {
                @columns=split(/\t/, $line);
                        if ($columns[1]!=4){
                                print STDOUT ">$columns[0]\n$columns[9]\n";
                                }
                        else {}
                        }
                }


