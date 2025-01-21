#!/usr/bin/perl -s
use strict;

my $dirname = "/data/Output_disease.network/Loops_dir";

opendir(DIR, $dirname);
my $filename;
my $num;
while($filename = readdir(DIR)){
	next, unless($filename =~/output_(\d+)$/);
	#print "$filename\n";
	$num += 1;
	system "perl /code/finder.motif.pl $filename";

}

print "$num\n";
closedir(DIR)


