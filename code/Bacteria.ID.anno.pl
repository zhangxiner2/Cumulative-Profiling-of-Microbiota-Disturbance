#!/usr/bin/perl -w
use strict;

open IN0, $ARGV[0];		
open IN1, $ARGV[1];

my %hash;
while(<IN0>){
	chomp;
	my @a = split(/\t/);
	$hash{$a[6]} = $_;
#print "$a[6]\n";
}
#foreach my $key ( keys %hash) {
#print "$key\n";
#}
print join("\t","#ID", "Disease\/Fiber", "Microbes","Evidence","Position","Level","Phylum","Class","Order","Family","Genu","Species"),"\n";
while(<IN1>){
	chomp;
	next, if (/^#/);
	my @b = split(/\t/);
	foreach my $key (keys %hash){
		my @v = split(/\t/, $hash{$key});
#	print "$v[5]\n";
		if ($b[2] eq $v[6]){
		print join("\t", @b, "Species", $v[1], $v[2], $v[3], $v[4], $v[5], $v[6]), "\n";
		last;
		}elsif($b[2] eq $v[5]){
		print join("\t", @b, "Genu", $v[1], $v[2], $v[3], $v[4], $v[5], $v[6]), "\n";
		last;
		}elsif($b[2] eq $v[4]){
		print join("\t", @b, "Family", $v[1], $v[2], $v[3], $v[4], $v[5], $v[6]), "\n";
		last;
		}elsif($b[2] eq $v[3]){
		print join("\t", @b, "Order", $v[1], $v[2], $v[3], $v[4], $v[5], $v[6]), "\n";
		last;
		}elsif($b[2] eq $v[2]){	
		print join("\t", @b, "Class", $v[1], $v[2], $v[3], $v[4], $v[5], $v[6]), "\n";
		last;
		}elsif($b[2] eq $v[1]){
		print join("\t", @b, "Phylum", $v[1], $v[2], $v[3], $v[4], $v[5], $v[6]), "\n";
                last;
		}elsif($b[2] eq $v[0]){
		print join("\t", @b, "Kingdom", $v[1], $v[2], $v[3], $v[4], $v[5], $v[6]), "\n";
                last;
		}
	}		
}
close IN0;
close IN1;


