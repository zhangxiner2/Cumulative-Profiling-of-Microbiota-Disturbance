#!/usr/bin/perl -w
use strict;

open IN0, $ARGV[0];  #Database.raw.txt.N.fiber.associated.with.microbe.txt
open IN1, $ARGV[1]; #Database.raw.txt.heatmap.up.down.txt

my %hash;
while(<IN0>){
	chomp;
	my @line = split(/\t/);
	$hash{$line[0]}=$line[1];
}
my ($E_value, $N);
$N = $ARGV[2];  #N is the number of all fibers in the data set
while(<IN1>){
	chomp;
	my @array = split(/\t/);
	if($array[3] >= $array[4]){
		$E_value = 1;
	}else{
		$E_value = -1;
	}

	if(exists $hash{$array[1]}){
		my $n = $hash{$array[1]};
		my $w_value = $E_value * $array[2] * log($N/$n);
		print "$array[0]\t$array[1]\t$w_value\n";
	}
}
close IN0;
close IN1;


