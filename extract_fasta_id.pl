#!/usr/bin/perl
# Use: ./extract_fasta_id.pl id fasta
# Extract a set of fasta sequences from a multifasta file, to use it you need:
# 1) a file with the ids 
# 2) the multifasta file to grab the ids from

my %hash;
open ID , '<' , $ARGV[0] || die;
while (<ID>) {
    chomp;
    s/^>//;
    $hash{$_}=1;
}

open FASTA , '<' , $ARGV[1] || die $!;
my $p=0;
while(<FASTA>) {
    chomp;
    if (/^>/) {
        $p=0;
        (my $tmp_id = $_) =~ s/^>//;
        $p=1 if ($hash{$tmp_id} == 1);
        }
    print "$_\n" if ($p ==1);
}    
    
