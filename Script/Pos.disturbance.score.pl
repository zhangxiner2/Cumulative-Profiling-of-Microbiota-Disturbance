#!/usr/bin/perl -w
use strict;

open IN0, $ARGV[0];

my ($ID, $line, $cluster,%hash,  @b, $v, $id);
$v = 0;
$line =0;
$cluster = 0;
while(<IN0>){
	chomp;
	my @a = split;
	next, if(/POS/);
	my $key = join("\t", $a[0], $a[1]);
	if (!defined $ID){
	$ID = $key;
	}
	if($ID ne $key){
	$cluster++;
	$ID = $key;
	}
	$hash{$cluster}{$line} = $_;
	$line++;	
#print "$cluster\n";
#print "$ID\n";
}			
my ($key1, $key2);
foreach $key1 (sort {$a <=> $b} keys %hash){
		my $hash2 = $hash{$key1};
		$v = 0;
		foreach $key2 (sort {$a <=> $b} keys %$hash2){
		my $val = $hash{$key1}{$key2};
#print "$key1\n";
		@b = split(/\t/,$val);
		$v += $b[3]*$b[3];
		$id = join("\t", $b[0], $b[1]);
#print "$id\n";

		}
		my $value = sqrt($v);
		print "$id\t$value\n";
	}

close IN0;	




