#!/usr/bin/perl -w 
use strict;


open IN0, $ARGV[0];
open IN1, $ARGV[1];
open OUT, "> $ARGV[1].system.txt";
my %hash;
while(<IN0>){
	chomp;
	my @a = split(/\t/);
	next, if(/^Disease/);
	$hash{$a[0]} = $a[1];
}

print OUT "ID\tClass\n";
while(<IN1>){
	chomp;
	my @b = split(/\t/);
	if(exists $hash{$b[0]}){
		print OUT "$b[0]\t$hash{$b[0]}\n";
	}else{
	print "$b[0]\n";
	}
}


close IN0;
close IN1;
close OUT;

