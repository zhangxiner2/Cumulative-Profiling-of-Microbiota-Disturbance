#!/usr/bin/perl -w

use strict;
use List::MoreUtils qw(uniq);

open IN, $ARGV[0];
open OUT0, "> $ARGV[0].N.disease.of.micrbobe.txt";
open OUT1, "> $ARGV[0].total.num.disease.txt";
 
my (%microbe, @disease, );
while(<IN>){
	chomp;
	my @a = split(/\t/);
	$microbe{$a[1]}++;
	push (@disease, $a[0]);
}

my @uniq_d = uniq @disease;
my $length = @uniq_d;

foreach my $k(keys %microbe) {
	print OUT0 "$k\t$microbe{$k}\n";

}
print OUT1 "$length\n";

close IN;
close OUT0;
close OUT1;



