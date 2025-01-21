#!/usr/bin/perl -w
use strict;
use List::MoreUtils qw(uniq);

# USAGE:modify the file to fit the mfinder software
# Author : XIN Zhang
#
#这个程序是可以调整适合mfinder的格式
## 本次最后，自己写的程序，没有用这个mfinder的软件。

open IN, $ARGV[0];
open OUT0, "> $ARGV[0].net.id1.txt";
open OUT1, "> $ARGV[0].net.id2.txt";
my @array;
while(<IN>){
	chomp;
	my @a = split;
	push (@array, $a[0], $a[1]);
}

my @new_array = uniq @array;
my ($idex, %hash);
for my $i (@new_array){
	$idex += 1;
	print OUT0 "$idex\t$i\n";
	$hash{$i} = $idex;
}
#for my $key (keys %hash){
#print "$key\t";
#}
open IN, $ARGV[0];
while(<IN>){
	chomp;
	my @b = split;
	if($b[2] != 0 ){
	if(exists $hash{$b[0]}){
		print OUT1 "$hash{$b[0]}\t$hash{$b[1]}\t1\n";
		}
	}
}

close IN;
close OUT0;
close OUT1;




