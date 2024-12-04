#!/usr/bin/perl -w
use strict;

open IN, $ARGV[0];
my $key = $ARGV[1];

#print "Form\tTo\tSimilarity\tds\tRelation\n";

while(<IN>){
	chomp;
	my @a = split(/\t/);
	if($a[2] == 0){
	next;
	}
	if($a[0] eq $a[1]){
	next;
	}
	if(abs($a[2]) < $key){
	next;
	}elsif($a[2]>0){
		my $value = 1-$a[2];
		my $sim = abs($a[2]);
		print "$a[0]\t$a[1]\t$sim\t$value\tpositive\n";
	}else{
		my $value = 1-abs($a[2]);
		my $sim = abs($a[2]);
		print "$a[0]\t$a[1]\t$sim\t$value\tnegative\n";
	}
	
		
}


close IN;

