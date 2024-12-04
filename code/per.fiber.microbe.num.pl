#!/usr/bin/perl -w
use strict;


open IN, $ARGV[0];
my %hash;
while(<IN>){
	chomp;
	my @line = split(/\t/);
	$hash{$line[0]}++;
	
}

foreach my $key (sort {$hash{$b} <=> $hash{$a}} keys %hash){
	print "$key\t$hash{$key}\n";

}

close IN;


