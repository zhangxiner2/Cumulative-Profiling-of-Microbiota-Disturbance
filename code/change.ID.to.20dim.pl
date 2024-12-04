#!/usr/bin/perl -w
use strict;
#
open IN0, $ARGV[0];
open IN1, $ARGV[1];
open OUT, "> $ARGV[1].20dim.txt";
my %hash;
while(<IN0>){
	chomp;
	my @b = split(/\t/, $_);
	next, if(/^#/);
	$hash{$b[0]}= $b[1];
}

print OUT "Form\tTo\tSimilarity\tds\tRelation\tSignificance\n";
while(<IN1>){
	chomp;
	my @a = split(/\t/, $_);
	next, if (/^Form/);
	print OUT "$a[0]\t$hash{$a[1]}\t$a[2]\t$a[3]\t$a[4]\t$a[5]\n";
	}
	

close IN0;
close IN1;
close OUT;

