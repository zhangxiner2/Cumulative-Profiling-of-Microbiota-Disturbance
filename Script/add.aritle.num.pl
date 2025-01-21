#!/usr/bin/perl -w
use strict;


open IN, $ARGV[0];
my $num = 1;
my $id;
while(<IN>){
	chomp;
	next, if(/^#/);
	my @a = split(/\t/);
	if(!defined $id){
	$id = $a[0];
	}
	if ($id eq $a[0]){
	print join ("\t", $num, @a),"\n";
	}elsif($id ne $a[0]){
	$num +=1;
	print join ("\t", $num, @a),"\n";
	$id = $a[0];
	}

}

close IN;


