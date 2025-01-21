#!/usr/bin/perl -w
use strict;
use List::MoreUtils qw(uniq);


print "POS\tDisease\tDS\n";
open IN0, $ARGV[0];
my (%hash, @ID, @S, @pos, @P);
while(<IN0>){
	chomp;
	my @a = split(/\t/, $_);
	next, if(/^ID/);
	my $key = join("\t", $a[0], $a[1]);
	$hash{$key} = $a[2];
	push (@ID, $a[1]);
	push (@pos, $a[0]);
}
@S = uniq @ID;
@P = uniq @pos;
for my $p (@P){
	for my $k (@S){
		my $key2 = join("\t", $p, $k);
		if(exists $hash{$key2}){
			print join("\t", $key2, $hash{$key2}), "\n";
		}else{
			print join("\t", $key2, 0), "\n";
			}
		}
	}

close IN0;

