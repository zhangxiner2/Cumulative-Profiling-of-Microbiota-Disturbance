#!/usr/bin/perl -w
use strict;
use List::MoreUtils qw(uniq);

open IN, $ARGV[0];
my %hash;
my (@fiber, @microbe);
while(<IN>){
	chomp;
	my @line = split(/\t/);
	my $key = join("\t", $line[0], $line[1]);
	$hash{$key} = $line[2];
	push (@fiber, $line[0]);
	push (@microbe, $line[1]);
}	
my @new_f = uniq @fiber;
my @new_m = uniq @microbe;
print "\t", join("\t", @new_f), "\n";

#for my $key (@new_m){
#	print "$key\n";
#}

for my $m (@new_m){
	print "$m";
	for my $f(@new_f){
	my $k = join("\t", $f, $m);
		if(exists $hash{$k}){
		print "\t$hash{$k}";
		}else{
		print "\t0";
		}
	}print "\n";
}



close IN;





