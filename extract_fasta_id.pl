#!/usr/bin/perl
#  ./extract_fasta_id.pl id fasta

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
    
