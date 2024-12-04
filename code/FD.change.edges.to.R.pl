#!/usr/bin/perl -w
use strict;
#
open IN0, $ARGV[0];
open IN1, $ARGV[1];
open OUT, "> FD.edges.txt";
my %hash;
while(<IN0>){
	chomp;
	my @b = split(/\t/, $_);
	next, if(/^#/);
	$hash{$b[0]}= $b[1];
}

print OUT "from\tto\tvalue\tlength\tcolor.color\tcolor.highlight\tdashes\n";
while(<IN1>){
	chomp;
	my @a = split(/\t/, $_);
	next, if (/^Form/);
	my $v1 = $a[2]*10;
	my $v2 = $a[3]*10;
	if($a[4] eq "positive"){ 
	print OUT "$a[0]\t$hash{$a[1]}\t$v1\t$v2\tred\tred\tFALSE\n";
	}elsif($a[4] eq "negative"){
	print OUT "$a[0]\t$hash{$a[1]}\t$v1\t$v2\tblue\tblue\tFALSE\n";
	}
	
}

close IN0;
close IN1;
close OUT;

