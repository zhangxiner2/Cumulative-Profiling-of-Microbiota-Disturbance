#!/usr/bin/perl -w
use strict;


open IN0, $ARGV[0];
open IN1, $ARGV[1];
my %hash;
while(<IN0>){
	chomp;
	my @a = split(/\t/, $_);
	$hash{$a[0]} = 1;
}
while(<IN1>){
	chomp;
	my @b = split(/\t/, $_);
	if(exists $hash{$b[0]}){
	print join("\t", @b), "\n";
	}
}
close IN0;
close IN1;


