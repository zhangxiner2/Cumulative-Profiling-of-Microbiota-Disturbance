#!/usr/bin/perl -w
use strict;


open IN0, $ARGV[0];		
open IN1, $ARGV[1];		

my %hash;
while(<IN0>){
	chomp;
	my @a = split(/\t/);
	my $key = join("\t", $a[0], $a[1], $a[2], $a[3],$a[4]);
	$hash{$key} = $key;
#	print "$key\n";
}


while(<IN1>){
	chomp;
	my @b = split(/\t/);
	my $k = join("\t", $b[0], $b[1], $b[2], $b[3],$b[4]);
	if(exists $hash{$k}){
		next;
	}else{
	print join("\t", @b), "\n";
	}
}

close IN0;
close IN1;


