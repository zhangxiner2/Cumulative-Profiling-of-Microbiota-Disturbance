#!/usr/bin/perl -w
use strict;

open IN0, $ARGV[0];
open IN1, $ARGV[1];
my (@ID, %hash);
my $num =0;
while(<IN0>){
	chomp;
	my @a = split(/\t/);
	$num+=1;
	next, if($num == 1);
	push(@ID, $a[0]);
}
while(<IN1>){
	chomp;
	my @b = split(/\t/);
	my $key = join("\t", $b[0], $b[1]);
	$hash{$key} = $b[2];
}

print "\t", join("\t", @ID), "\n";

for my $j(@ID){
print "$j";
	for my $i(@ID){
		my $k1 = join("\t", $j, $i);
                my $k2 = join("\t", $i, $j);
		if ($j eq $i){
		print "\tNA";
			}
		if(exists $hash{$k1}){
		print "\t$hash{$k1}";
			}
		if(exists $hash{$k2}){
		print "\t$hash{$k2}";
			}
		}
print "\n";
}

close IN0;
close IN1;
