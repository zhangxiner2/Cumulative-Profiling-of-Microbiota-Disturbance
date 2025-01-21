#!/usr/bin/perl 

open IN, $ARGV[0];
my $PWD = "/data/Output_disease.network/pos.Dir";
my %hash;
while(<IN>){
	chomp;
	my @ID = split;
	my $dir = $ID[0];
	opendir (DIR, $dir);
	system ("cp /code/pos.quantitative.sh $PWD/$dir");
	system ("cd $dir && sh $PWD/$dir/pos.quantitative.sh $dir");
	my @dir = readdir DIR;
	for my $file(@dir){
        if($file =~ /^all.level.heatmap.up.down.txt.quantitative_strength_of_the_relationship.txt$/){
                open IN0, "< $PWD/$dir/$file";
		open OUT, "> $PWD/$dir/$file.score.txt";
                while(<IN0>){
                        chomp;
                        my @a = split(/\t/, $_);
#			next, if($a[2] == 0);
			my $s1 = 1/(exp $a[2]);
			my $s2 = 2/(1+$s1);
			my $s3 = $s2-1;
			my $s4 = sprintf "%.3f", $s3;
			print OUT "$dir\t$a[0]\t$a[1]\t$s4\n";
	                }
		}
	}
}
close IN;
close IN0;

