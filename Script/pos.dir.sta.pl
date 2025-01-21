#!/usr/bin/perl -w
use strict;


open IN, $ARGV[0];
open OUT, ">> dir.txt";

while(<IN>){
	chomp;
	my @a = split(/\t/, $_);
	if($a[0]=~/(\S+).ano.txt/){
		my $dir = $1;
		#				system ("rm -rf $dir if -d $dir");
		system ("perl /code/split.postion.pl J.disease.final.uniq2.ano.num.txt.postion.info.txt J.disease.final.uniq2.ano.num.txt if -d $dir");	
		#		system ("cd $dir && mv $a[0] ../ if -d $dir");
		system ("rm -rf $dir if -d $dir");
		system ("mkdir $dir && mv $a[0] $dir");
		system ("cd $dir && perl /code/calcu.info.pl $a[0] disease");
		system ("cd $dir && perl /code/calcu.select.info.pl $a[0]");
		system ("rm *.ano.txt");
		print OUT "$dir\n";
	}
}

close IN;

