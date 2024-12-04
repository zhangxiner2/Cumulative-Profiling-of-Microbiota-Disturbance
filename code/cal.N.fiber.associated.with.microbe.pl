#!/usr/bin/perl -w
use strict;


open IN0, $ARGV[0];

my %hash;
while(<IN0>){
	chomp;
	my @line = split(/\t/);
	$hash{$line[1]}++;
}

foreach my $key (sort {$hash{$b} <=> $hash{$a}}keys %hash){
	print "$key\t$hash{$key}\n";

}
close IN0;


