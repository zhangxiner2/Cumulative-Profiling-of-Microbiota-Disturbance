#!/usr/bin/perl -w
use strict;


open IN0, $ARGV[0];
open IN1, $ARGV[1];
my %hash;
while(<IN0>){
	chomp;
	my @a = split(/\t/);
	$hash{$a[0]} = $a[1];
}
while(<IN1>){
	chomp;
	my @b = split(/\t/);
	if(exists $hash{$b[0]}){
		$b[0] ="$hash{$b[0]}";
	}
	if(exists $hash{$b[1]}){
		$b[1]= "$hash{$b[1]}";
	}
	print "$b[0]\t$b[1]\t$b[2]\n";
}

close IN0;
close IN1;


