#!/usr/bin/perl -w
use strict;


open IN0, $ARGV[0];
open IN1, $ARGV[1];
open OUT, "> t.txt";

my %hash;
while(<IN0>){
	chomp;
	my @a = split(/\t/, $_);
	next, if (/^#/);
	$hash{$a[0]} = $a[1];
	
}
while(<IN1>){
	chomp;
	my @b = split(/\t/, $_);
	if(exists $hash{$b[2]}){
	my $key = $hash{$b[2]};
		print "$b[0]\t$b[1]\t$key\t$b[3]\t$b[4]\t$b[5]\n";
	
	}else{
print OUT "$b[0]\t$b[1]\t$b[2]\t$b[3]\t$b[4]\t$b[5]\n";	
	}
	
}

close IN0;
close IN1;
close OUT;


