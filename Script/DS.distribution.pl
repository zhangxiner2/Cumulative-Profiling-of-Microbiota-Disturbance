#!/usr/bin/perl -w
use strict;

open IN, $ARGV[0];
open OUT, "> $ARGV[0].distribution.txt";
use List::Util qw(max min);
use POSIX; 


my @array;
my $step = $ARGV[1];   #defined your step
while(<IN>){
	chomp;
	my @a = split(/\t/, $_);
	push (@array, $a[2]);
}
my $min = floor (min @array); 
my $max = ceil (max @array);
my $p = ($max-$min)/$step;
my $part = ceil $p;

my ($n, $J);
my $lim = $part + 1;
for ($n = 1; $n < $lim; $n = $n + 1){
my $D_n =0;
	my $left = $min + $step*($n-1);
	my $right = $min + $step*$n;
	foreach my $key(@array){
		if($left < $key && $key < $right){
			$D_n += 1;
		}
	}
	$J = join("-", $left, $right);
#	print OUT "$J\t$D_n\n"; 	#输出结果为区段
	print OUT "$right\t$D_n\n";
}

close IN;



