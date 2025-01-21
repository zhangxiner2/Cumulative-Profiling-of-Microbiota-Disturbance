#!/usr/bin/perl -w
use strict;


open IN0, $ARGV[0];
open IN1, $ARGV[1];
open IN2, $ARGV[2];
my (%hash1, %hash2, $val);
open OUT, ">FD.nodes.txt";
while(<IN0>){
	chomp;
	my @a = split;
	next, if(/^#/);
	$hash1{$a[0]} = $a[1];

}
while(<IN1>){
	chomp;
	my @b = split;
	next, if(/^ID/);
	$hash2{$b[0]} = $b[1];

}

print OUT "id\tlabel\tgroup\tshape\tshadow\n";
while(<IN2>){
	chomp;
	my @c = split;
	next, if(/^Name/);
	if(exists $hash1{$c[0]}){
		$val = $hash1{$c[0]};
		print OUT "$val\t$val\t$hash2{$val}\tellipse\tTRUE\n";
	}else{
		$val = $c[0];
		print OUT "$c[0]\t$val\tDietary fiber\tdiamond\tTRUE\n";
		
	}
}

close IN0;
close IN1;
close IN2;

