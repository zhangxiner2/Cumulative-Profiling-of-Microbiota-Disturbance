#!/usr/bin/perl -w
use strict;

#只关注作用于胃肠道的
open IN, $ARGV[0];
while(<IN>){
	chomp;
	my @line = split(/\t/);
	next, if($line[5] ne "Gastrointestinal tract");
	print join("\t", @line), "\n";	
}


close IN;


