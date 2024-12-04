#!/usr/bin/perl -w
use strict;

open IN, $ARGV[0];
my $PWD = "/data/Output_disease.network/pos.Dir";


while(<IN>){
	chomp;
	my @a = split(/\t/, $_);
	next, if(/^#/);
	if ($a[2] > 1){
		my $dir = $a[0];
		opendir (DIR, $dir);
		my @dir = readdir DIR;
		for my $file(@dir){
        	if($file =~ /^(\S+).quantitative_strength_of_the_relationship.txt.score.txt/){
			open IN0, "< $PWD/$dir/$file";
                	open OUT, ">> $PWD/All.29.pos.score.txt";
			while(<IN0>){
				chomp;
				my @b = split(/\t/, $_);
		#		next, if($b[3] == 0);
				print OUT join("\t", @b), "\n";
				}
			}
		}
	}
}

close IN;
close IN0;

