#!/usr/bin/perl -w
use strict;

open IN, $ARGV[0];
open OUT, "> $ARGV[0].uniq.txt";
my %hash;
my ($ID, $num);
my $cluster = 1;
while(<IN>){
	chomp;
	my @a = split(/\t/);
	my $key = join("\t", $a[0], $a[1]);
	my $array = join("\t", @a);
	$num += 1;
	if(!defined $ID){
	$ID = join("\t", $a[0], $a[1]);
	}
	if($ID ne $key){
	$cluster++;
	$ID = $key;
	}
	$hash{$cluster}{$num} = $array;
}

my ($id, $d, $k, $m, %hash2);
foreach my $k1(keys %hash){
	my $hash2 = $hash{$k1};
	foreach my $k2 (keys %$hash2){
		my $val = $hash{$k1}{$k2};
		my @value = split(/\t/, $val);
		$d += $value[2];
		$k += $value[3];
		$m += $value[4];
		$id = join("\t", $value[0], $value[1]);
	}
print OUT "$id\t$d\t$k\t$m\n";
$d=$k=$m = 0;
}

close IN;


