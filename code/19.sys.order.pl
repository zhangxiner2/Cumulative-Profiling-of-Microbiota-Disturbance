#!/usr/bin/perl -w
use strict;

open IN0, $ARGV[0];
my @ID;
while(<IN0>){
	chomp;
	my @line = split(/\t/, $_);
	push (@ID, $line[0]);
}
#my $len = @ID;
#print "$len\n";
foreach my $k (@ID){
#print "$k\n";
open IN1, $ARGV[1];
while(<IN1>){
	chomp;
	my @key = split(/\t/, $_);
	next, if(/^ID/);
	if($k eq $key[1]){
		print "$key[0]\t$key[1]\n";
		}
	}
	
}

close IN0;
close IN1;


