#!/usr/bin/perl -w
use strict;

open IN0, $ARGV[0];
open IN1, $ARGV[1];
open OUT, "> J.disease.gt3.txt";

my %hash;
while(<IN0>){
	chomp;
	my @a = split(/\t/);
	if($a[1] < 3){
		$hash{$a[0]} =1;
	}
}

while(<IN1>){
	chomp;
	my @b = split(/\t/);
	next, if(/^#ID/);
	if(exists $hash{$b[1]}){
		next;
	}else{
	 print OUT join ("\t", @b), "\n";
	}
}

close IN0;
close IN1;

