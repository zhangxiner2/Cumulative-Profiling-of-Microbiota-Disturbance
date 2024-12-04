#!/usr/bin/perl -w
use strict;
use List::MoreUtils qw(uniq);

open IN0, $ARGV[0];
open IN1, $ARGV[1];
open IN2, $ARGV[2];
open IN3, $ARGV[3];
open IN4, $ARGV[4];
open IN5, $ARGV[5];
open OUT, "> J.join.level.$ARGV[6].all.txt";
my (@ID, %h1, %h2,%h3, %h4, %h5, %h6);
while(<IN0>){
	chomp;
	my @a = split(/\t/);
	$a[2] = 0, if(/NA/);
	push (@ID, $a[0]);
	next, if($a[0] eq $a[1]);
	my $key = join("\t", $a[0], $a[1]);
	$h1{$key} = $a[2];
}
while(<IN1>){
	chomp;
	my @b = split(/\t/);
	$b[2] = 0, if(/NA/);
	push (@ID, $b[0]);
	next, if($b[0] eq $b[1]);
	my $key = join("\t", $b[0], $b[1]);
	$h2{$key} = $b[2];
}
while(<IN2>){
	chomp;
	my @c = split(/\t/);
	$c[2] = 0, if(/NA/);
	push (@ID, $c[0]);
	next, if($c[0] eq $c[1]);
	my $key = join("\t", $c[0], $c[1]);
	$h3{$key} = $c[2];
}
while(<IN3>){
	chomp;
	my @d = split(/\t/);
	$d[2] = 0, if(/NA/);
	push (@ID, $d[0]);
	next, if($d[0] eq $d[1]);
	my $key = join("\t", $d[0], $d[1]);
	$h4{$key} = $d[2];
}
while(<IN4>){
	chomp;
	my @e = split(/\t/);
	$e[2] = 0, if(/NA/);
	push (@ID, $e[0]);
	next, if($e[0] eq $e[1]);
	my $key = join("\t", $e[0], $e[1]);
	$h5{$key} = $e[2];
}

while(<IN5>){
	chomp;
	my @f = split(/\t/);
	$f[2] = 0, if(/NA/);
	push (@ID, $f[0]);
	next, if($f[0] eq $f[1]);
	my $key = join("\t", $f[0], $f[1]);
	$h6{$key} = $f[2];
}
print OUT "#ID1\tID2\tx_value\tweight\tw_S\tw_G\tw_F\tw_O\tw_C\tw_P\n", if($ARGV[6] eq "weight");
print OUT "#ID1\tID2\tw_S\tw_G\tw_F\tw_O\tw_C\tw_P\n", if($ARGV[6] eq "cosine");

my @uniq_ID = uniq @ID;
my ($x_value, $ID, $j, $k, $v1, $v2, $v3, $v4, $v5,$v6);
foreach $j(@uniq_ID){
	foreach $k (@uniq_ID) {
		my $ID = join("\t", $j, $k);
		if(exists $h1{$ID}){
			$v1 = $h1{$ID};
		}else{
			$v1 = 0;
		}
		if(exists $h2{$ID}){
			$v2 = $h2{$ID};
		}else{
			$v2 = 0;
		}
		if(exists $h3{$ID}){
			$v3 = $h3{$ID};
		}else{
			$v3 = 0;
		}
		if(exists $h4{$ID}){
			$v4 = $h4{$ID};
		}else{
			$v4 = 0;
		}
		if(exists $h5{$ID}){
			$v5 = $h5{$ID};
		}else{
			$v5 = 0;
		}
		if(exists $h6{$ID}){
			$v6 = $h6{$ID};
		}else{
			$v6 = 0;
		}

my $value = $v1+$v2+$v3+$v4+$v5+$v6;
$x_value = sqrt(1/$value), if($value>0);
$x_value = 0, if($value == 0);
print OUT "$ID\t$x_value\t$value\t$v1\t$v2\t$v3\t$v4\t$v5\t$v6\n", if($ARGV[6] eq "weight");
print OUT "$ID\t$v1\t$v2\t$v3\t$v4\t$v5\t$v6\n", if($ARGV[6] eq "cosine");
	}
}


