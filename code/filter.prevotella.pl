#!/usr/bin/perl -w
use strict;

open IN, $ARGV[0];
print "Item\tIncrease\tDecrease\n";
while(<IN>){
	chomp;
	my @a = split(/\t/, $_);
	if($a[1] eq "Prevotella"){
	print "$a[0]\t$a[3]\t$a[4]\n";
	}

}
close IN;


