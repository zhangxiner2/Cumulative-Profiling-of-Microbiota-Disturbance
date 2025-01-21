#!/usr/bin/perl -w
use strict;

#筛选出fiber下至少有三种microbe波动证据的信息
#

open IN0, $ARGV[0];  #per.fiber.microbe.num.txt 
open IN1, $ARGV[1];	#Database.raw.txt
my %hash;
while(<IN0>){
	chomp;
	my @line = split(/\t/);
	if($line[1]>2){
		$hash{$line[0]} = 1;
	}
}

while(<IN1>){
	chomp;
	my @key = split(/\t/);
	if(exists $hash{$key[2]}){
		print join("\t", @key), "\n";
	}
}
close IN0;
close IN1;
