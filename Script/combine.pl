#!/usr/biin/perl -w
use strict;

open IN0, $ARGV[0];
open IN1, $ARGV[1];
my %hash;
while(<IN0>){
	chomp;
	my @a = split(/\t/, $_);
	my $key = join("\t", $a[0], $a[1]);
	$hash{$key} = $a[2];
}

print "#ID1\tID2\tMicrobe\t20Dim\n";
while(<IN1>){
	chomp;
	my @b = split(/\t/, $_);
	my $k = join("\t", $b[0], $b[1]);
	if(exists $hash{$k}){
		print "$k\t$hash{$k}\t$b[2]\n";
	}
}

close IN0;
close IN1;

