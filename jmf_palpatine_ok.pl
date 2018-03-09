#jmf_palpatine.pl [path to fasta file that would be the database] [path to datasets containing folder] [path to results directory that would be created]

#$ARGV[0]  = database fasta file, complete path
#$ARGV[1] = path to folder with datasets
#$ARGV[2]= path to results folder that would be created

$run="mkdir -p $ARGV[2]";
#system $run;

##1. contruct database index

# hisat2-build /home/acobian/frap_map/example_files/DB_viral_refseq/all_viruses.fna all_viruses
# /home/acobian/frap_map/example_files/DB_viral_refseq/all_viruses.fna
# db_id=  split by slash, take the last element, split by dot, take the first element

my @db_name = split (/\//,$ARGV[0]);
my $last_name = pop @db_name;
my $db_id = (split(/\./,$last_name))[0];
my $db_id_path = (split(/\./,$ARGV[0]))[0];

#$run="hisat2-build $ARGV[0] $db_id_path";
#system $run;

##2. map datasets to database

#2.1 get ids list

$run="ls $ARGV[1] | grep 'fasta' | cut -d '.' -f1 > $ARGV[2]/IDS.txt";
system $run;

my $x = "/IDS.txt";
my $path_to_ids = $ARGV[2].$x;

open my $handle, '<', $path_to_ids;
chomp(my @IDS = <$handle>);
close $handle;

print "@IDS\n";

#2.2 map

foreach(@IDS) {
        $run="hisat2  -x $db_id_path -f -U $ARGV[1]/$_.fasta -S $ARGV[2]/$_"."_vs_$db_id.sam";
#        print "$run\n";
#        system $run;
}

##3. get hits individual tables
foreach(@IDS){
               $run = "grep -v ^@ $ARGV[2]/$_"."_vs_$db_id.sam | cut -f1,3 | sort | uniq | cut -f2 | sort | uniq -c | sort -nr  | sed -e \"s/^ *//\" | tr \" \" \"\t\"  > $ARGV[2]/$_"."_vs_$db_id"."_hits.tab";
                print "$run\n";
#                system $run;
}

##4. create number of reads per dataset table 

my $tj='';

foreach(@IDS){
	$tj.=`echo -n "$_ "; grep -c ">" $ARGV[1]/$_.fasta`;
}

open OUT, '>' , "$ARGV[2]/tj.txt";
print OUT $tj;
close OUT;

##5. FRAP normalization
