#!/usr/bin/perl -w
use strict;

open IN0, $ARGV[0];
open IN1, $ARGV[1];
my %hash;
while(<IN0>){
	chomp;
	my @a = split(/\t/, $_);
	$hash{$a[0]} = $a[1];
}

while(<IN1>){
	chomp;
	my @b = split;
	if(exists $hash{$_}){
		print "$_\t$hash{$_}\n";
	}
}

close IN0;
close IN1;

