#!/usr/bin/perl -w
use strict;

print "Item\tIncrease\tDecrease\n";

open IN, $ARGV[0];
my (%up, %down);
while(<IN>){
	chomp;
	my @line = split(/\t/);
	$up{$line[1]}+=$line[3];
	$down{$line[1]}+=$line[4];
}

for my $key(sort keys %up){
	print "$key\t$up{$key}\t$down{$key}\n";
	
}

close IN;

