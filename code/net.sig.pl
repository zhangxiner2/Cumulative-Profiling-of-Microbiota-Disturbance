#!/usr/bin/perl -w
use strict;


my %hash;
open IN0, $ARGV[0];
open IN1, $ARGV[1];
open OUT0, "> $ARGV[1].all.P.value.txt";
open OUT1, "> $ARGV[1].only.P.sign.txt";


while(<IN0>){
	chomp;
	my @a = split;
	my $key = join("\t", $a[0], $a[1]);
	$hash{$key} = 1;
}

print OUT0 "Form\tTo\tSimilarity\tds\tRelation\tSignificance\n";
print OUT1 "Form\tTo\tSimilarity\tds\tRelation\tSignificance\n";

while(<IN1>){
	chomp;
	my @b = split;
	my $k = join("\t", $b[0], $b[1]);
	if(exists $hash{$k}){
		print OUT0 "$k\t$b[2]\t$b[3]\t$b[4]\tYes\n";
		print OUT1 "$k\t$b[2]\t$b[3]\t$b[4]\tYes\n";
	}else{
	
		print OUT0 "$k\t$b[2]\t$b[3]\t$b[4]\tNo\n";
	}
}

close IN0;
close IN1;


