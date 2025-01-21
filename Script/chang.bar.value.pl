#!/usr/bin/perl -w
use strict;

open IN0, $ARGV[0];
open OUT, "> $ARGV[0].change.bra_value.txt";
while(<IN0>){
	chomp;
	my @a = split(/\t/);
	my $key = $ARGV[1];
	my $k = abs($a[2]);
	if($a[2] >= $key){
		print OUT "$a[0]\t$a[1]\t$key\n";
	}	
	elsif($a[2] < 0 and $k >= $key){
		print OUT "$a[0]\t$a[1]\t-$key\n";
	}
	else{
		print OUT "$a[0]\t$a[1]\t$a[2]\n";
	}
	
}
close IN0;
close OUT;

