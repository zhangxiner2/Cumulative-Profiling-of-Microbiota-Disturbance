#!/usr/bin/perl -w
use strict;

open IN0, $ARGV[0];
open IN1, $ARGV[1];
open OUT, "> $ARGV[1].filter.20min.ID.txt";
my (%hash, @c);
while(<IN0>){
	chomp;
	my @a = split(/\t/);
	$hash{$a[0]} = $a[0];
}
while(<IN1>){
	chomp;
	my @b = split(/\t/);
	if(exists $hash{$b[0]}){
		next;
		}
	elsif(exists $hash{$b[1]}){
		next;
		}else{	
		 print OUT join ("\t", @b),"\n";
		}
}

close IN0;
close IN1;
close OUT;



