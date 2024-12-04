#!/usr/bin/perl -w
use strict;


open IN0, $ARGV[0];
my @ID;
while(<IN0>){
        chomp;
        my @line = split(/\t/, $_);
        push (@ID, $line[0]);
}

print join("\t", @ID), "\n";

my %hash;
open IN1, $ARGV[1];
while(<IN1>){
        chomp;
        my @line = split(/\t/);
        my $key = join("\t", $line[0], $line[1]);
        $hash{$key} = $line[2];
}

foreach my $k (@ID){
	print "$k";
	foreach my $f (@ID){
		my $y = join("\t", $k, $f);
		if (exists $hash{$y}){
			print "\t$hash{$y}";
			}else{
			print "\t0";
			}
	}print "\n";
}

close IN0;
close IN1;




