#!/usr/bin/perl -w
use strict;

open IN0, $ARGV[0];
open IN1, $ARGV[1];
open OUT, " > $ARGV[1].final.txt";
my %hash;
while(<IN0>){
	chomp;
	my @a = split(/\t/);
	my $k = join("\t", $a[0], $a[1]);
	$hash{$k} = $a[2];

}
while(<IN1>){
	chomp;
	my @b = split(/\t/);
	my $key = join("\t", $b[0], $b[1]);
	if(exists $hash{$key}){
		print OUT join("\t", $key, $hash{$key}), "\n";
	}else{
		print OUT join("\t", @b), "\n";
	}

}
close IN0;
close IN1;
close OUT;

