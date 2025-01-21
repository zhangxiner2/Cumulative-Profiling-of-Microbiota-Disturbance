#!/usr/bin/perl -w
use strict;


open IN, $ARGV[0];
my %hash;
while(<IN>){
	chomp;
	my @a = split(/\t/, $_);
	my $key = join("\t", $a[0], $a[1]);
	$hash{$key} = $a[1];

}
my (%num, $ID);
foreach my $val (sort values %hash){
		$ID = $val, if(!defined $ID);
		if ($ID eq $val){
		$num{$ID} += 1;
		}else{
		$ID = $val;
		$num{$ID} += 1;
		}
}

foreach my $key (sort {$num{$b} <=> $num{$a}} keys %num){
	print "$key\t$num{$key}\n";

}

close IN;


