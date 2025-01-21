#!/usr/bin/perl 
use strict;


open IN, $ARGV[0];
my (%hash,%up, %down);
open OUT0, "> $ARGV[0].heatmap.txt";
open OUT1, "> $ARGV[0].heatmap.up.down.txt";
while(<IN>){
	chomp;
	my @line = split(/\t/);
	my $key = join("\t", $line[2], $line[3]);
	$hash{$key}++;
	if($line[4] eq "Increase"){
	$up{$key}++;
	}elsif($line[4] eq "Decrease"){
	$down{$key}++;
	}
	
}

for my $key (sort {$hash{$b} <=> $hash{$a}} keys %hash){
	print OUT0 "$key\t$hash{$key}\n";
}

for my $key (sort {$hash{$b} <=> $hash{$a}} keys %hash){
	if ($up{$key} eq $hash{$key}){
	print OUT1 "$key\t$hash{$key}\t$up{$key}\t0\n";
	}elsif($down{$key} eq $hash{$key}){
	print OUT1 "$key\t$hash{$key}\t0\t$down{$key}\n";
	}else{	
	print OUT1 "$key\t$hash{$key}\t$up{$key}\t$down{$key}\n";
	}
}
close IN;


