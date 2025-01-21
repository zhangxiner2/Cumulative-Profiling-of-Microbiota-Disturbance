#!/usr/bin/perl -w
use strict;

open IN, $ARGV[0];
open OUT0, "> $ARGV[0].title.info.txt";
open OUT1, "> $ARGV[0].$ARGV[1].info.txt";
open OUT2, "> $ARGV[0].microbe.info.txt";
open OUT3, "> $ARGV[0].postion.info.txt";
my ($name,$temp, $k, $pos, @line, %fiber, %microbe, %title, %postion);
# $ARGV[1] can be the "fiber" or "disease".
while (<IN>){
	chomp;
	next, if(/PMID/);
	@line = split(/\t/, $_);
	$temp = join("\t", $line[0], $line[2]);
	$k = $line[0];
	
	if(!defined $name){
	$name = $temp;
	$fiber{$line[2]}++;
#	$postion{$line[5]}++;
	}
	elsif ($name ne $temp){
		$fiber{$line[2]}++;
#		$postion{$line[5]}++;
	}	
	$name = $temp;
	$title{$line[0]}++;
	$microbe{$line[3]}++;
	if(!defined $pos){
	$pos = $k;
	$postion{$line[5]}++;
	}elsif($pos ne $k){
		$postion{$line[5]}++;
	}
	$pos = $k;
}
foreach my $key(sort {$a <=> $b} keys %title){
	print OUT0 "$key\t$title{$key}\n";
}
foreach my $key1(sort {$fiber{$b} <=> $fiber{$a} } keys %fiber){
	print OUT1 "$key1\t$fiber{$key1}\n";
}
foreach my $key2 (sort {$microbe{$b} <=> $microbe{$a} } keys %microbe){
	print OUT2 "$key2\t$microbe{$key2}\n";
}
foreach my $key3 (sort {$postion{$b} <=> $postion{$a}} keys %postion){
	print OUT3 "$key3\t$postion{$key3}\n";
}
close IN;
close OUT0;
close OUT1;
close OUT2;
close OUT3;


