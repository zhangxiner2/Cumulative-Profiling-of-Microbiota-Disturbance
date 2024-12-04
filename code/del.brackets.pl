#!/usr/bin/perl -w
use strict;


open IN, $ARGV[0];

while(<IN>){
	chomp;
	my @a = split(/\t/);
	if(/\(/){
	$a[2]=~ s/\s*\([^()]+\)\s*$//g;
	print join("\t", $a[0], $a[1], $a[2], $a[3], $a[4], $a[5]), "\n";
	}else{
	print join("\t", $a[0], $a[1], $a[2], $a[3], $a[4], $a[5]), "\n";
	}

}
close IN;


