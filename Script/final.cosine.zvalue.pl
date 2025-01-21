#!/usr/bin/perl -w
use strict;

open IN0, $ARGV[0];
open IN1, $ARGV[1];
open OUT0, "> $ARGV[0].add.weight.txt";
open OUT1, "> $ARGV[0].zvalue.txt";

my %hash;
while(<IN0>){
	chomp;
	my @a = split(/\t/);
	next, if(/^#/);
	my $key = join("\t", $a[0], $a[1]);
	my $value = join("\t", $a[2], $a[3], $a[4], $a[5], $a[6], $a[7]);
	$hash{$key} = $value;
}

my ($Y_value, $x_value, $zvalue);
while(<IN1>){
	chomp;
	my @b = split(/\t/);
	next, if(/^#/);
	my $k = join("\t", $b[0], $b[1]);
	if(exists $hash{$k}){
		if($b[0] eq $b[1]){
		print OUT0 join("\t", $k, 1), "\n";
		print OUT1 join("\t", $k, "NA"), "\n";
		}else{
			my @V= split(/\t/, $hash{$k});
		$Y_value = ($b[4]/$b[3])*$V[0] +($b[5]/$b[3])*$V[1]+ ($b[6]/$b[3])*$V[2] + ($b[7]/$b[3])*$V[3] + ($b[8]/$b[3])*$V[4] +($b[9]/$b[3])*$V[5];
			print OUT0 join("\t", $k, $Y_value), "\n";
			$x_value = sqrt(1/$b[3]);
			$zvalue = $Y_value/$x_value;
			print OUT1 join("\t", $k, $zvalue), "\n";
		}
	}
}  
  
close IN0;
close IN1;  
close OUT0;
close OUT1;
  


