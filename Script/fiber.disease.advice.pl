#!/usr/bin/perl -w

open IN, $ARGV[0];

print "Disease\tFIber\tSimilarity\tRelationship\tRecommended_intake\n";
while(<IN>){
	chomp;
	my @a = split(/\t/, $_);
	next, if(/Similarity/);
	my $val = sprintf("%.3f", $a[2]);
	if($a[4] eq "positive"){
	print "$a[1]\t$a[0]\t$val\t$a[4]\tNo\n";
	}elsif($a[4] eq "negative"){
	print "$a[1]\t$a[0]\t$val\t$a[4]\tYes\n";
	}
}

close IN;

