#!/usr/bin/perl -w 
use strict;



open IN0, $ARGV[0]; 
open IN1, $ARGV[1];

open OUT, "> J.join.$ARGV[2].uniq.txt";

my %hash;
while(<IN0>){
	chomp;
	my @a = split(/\t/);
	my $key = join("\t", $a[0], $a[1]);
	$hash{$key} = $_;
}
my $n;
my %est;
while(<IN1>){
	chomp;
	my @b = split(/\t/);
	my $key = join("\t", $b[0], $b[1]);
	if(exists $hash{$key}){
 $n += 1;
	my @array = split(/\t/, $hash{$key});
	my $e = join("\t", $array[0], $array[1]);
	$est{$e} = 1;
#print "$e\n";
	my $k = $b[2] + $array[2];
	my $j = $b[3] + $array[3];
	my $h = $b[4] + $array[4];
	print OUT join("\t", $key, $k, $j, $h),"\n";
	}else{
	print OUT join("\t", @b),"\n";;
	}

}
#print "$n\n";
my $num;
open IN2, $ARGV[0];
while(<IN2>){
	chomp;
	my @a = split(/\t/);
	my $r = join("\t", $a[0], $a[1]);
	if(exists $est{$r}){
$num += 1;
#print "$r\n";
	next;
	}else{
	print OUT join("\t", @a),"\n";
	}
}

#print "$num\n";

close IN0;
close IN1;
close OUT ;

