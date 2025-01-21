#!/usr/bin/perl -w
use strict;


open IN, $ARGV[0];

while(<IN>){
	chomp;
	my @a = split(/\t/);
	print join("\t", $a[2], $a[4], $a[0], $a[1], $a[3]), "\n";

}

close IN;

