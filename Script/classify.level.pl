#!/usr/bin/perl 

open IN0, $ARGV[0];
open IN1, $ARGV[1];
open OUT0, ">> $ARGV[1].species.txt";
open OUT1, ">> $ARGV[1].Genu.txt";
open OUT2, ">> $ARGV[1].Family.txt";
open OUT3, ">> $ARGV[1].Order.txt";
open OUT4, ">> $ARGV[1].Class.txt";
open OUT5, ">> $ARGV[1].Phylum.txt";

open OUT7, ">> $ARGV[1].Genu2.txt";
open OUT8, ">> $ARGV[1].Family2.txt";
open OUT9, ">> $ARGV[1].Order2.txt";
open OUT10, ">> $ARGV[1].Class2.txt";
open OUT11, ">> $ARGV[1].Phylum2.txt";
open OUT12, "> $ARGV[1].weight.txt";

my %hash;
while(<IN0>){
	chomp;
	my @a = split(/\t/);
	my $key1 = join("\t", $a[2], $a[3]);
	my $value = join("\t", $a[6], $a[7],$a[8],$a[9],$a[10],$a[11],$a[12]);
	$hash{$key1} = $value;
}

my ($N_S, $N_G, $N_F, $N_O, $N_C, $N_P, $total);
while(<IN1>){
	chomp;
	my @b = split(/\t/);
	my $key2 = join("\t", $b[0], $b[1]);
	$total += 1;
	if(exists $hash{$key2}){
		my @array = split("\t", $hash{$key2});
#print "@array\n";
		if($array[0] eq "Species"){
			$N_S += 1;
			print OUT0 join("\t", @b),"\n";
			print OUT7 join("\t", $b[0],$array[5],$b[2], $b[3], $b[4]),"\n";
			print OUT8 join("\t", $b[0],$array[4],$b[2], $b[3], $b[4]),"\n";
			print OUT9 join("\t", $b[0],$array[3],$b[2], $b[3], $b[4]),"\n";
			print OUT10 join("\t", $b[0],$array[2],$b[2], $b[3], $b[4]),"\n";
			print OUT11 join("\t", $b[0],$array[1],$b[2], $b[3], $b[4]),"\n";
			
		}
		if($array[0] eq "Genu"){
			$N_G += 1;
			print OUT1 join("\t", @b),"\n";
			print OUT8 join("\t", $b[0],$array[4],$b[2], $b[3], $b[4]),"\n";
			print OUT9 join("\t", $b[0],$array[3],$b[2], $b[3], $b[4]),"\n";
                        print OUT10 join("\t", $b[0],$array[2],$b[2], $b[3], $b[4]),"\n";
                        print OUT11 join("\t", $b[0],$array[1],$b[2], $b[3], $b[4]),"\n";

		}
		if($array[0] eq "Family"){
			$N_F += 1;
			print OUT2 join("\t", @b),"\n";
			my $G2 = $array[3];
			print OUT9 join("\t", $b[0],$array[3],$b[2], $b[3], $b[4]),"\n";
			print OUT10 join("\t", $b[0],$array[2],$b[2], $b[3], $b[4]),"\n";
                        print OUT11 join("\t", $b[0],$array[1],$b[2], $b[3], $b[4]),"\n";

		}
		if($array[0] eq "Order"){
			$N_O += 1;
			print OUT3 join("\t", @b),"\n";
			print OUT10 join("\t", $b[0],$array[2],$b[2], $b[3], $b[4]),"\n";
			print OUT11 join("\t", $b[0],$array[1],$b[2], $b[3], $b[4]),"\n";

		}
		if($array[0] eq "Class"){
			$N_C += 1;
			print OUT4 join("\t", @b),"\n";
			print OUT11 join("\t", $b[0],$array[1],$b[2], $b[3], $b[4]),"\n";
		}
		if($array[0] eq "Phylum"){
			$N_P += 1;
			print OUT5 join("\t", @b),"\n";
		}
		
	}
}

my $S = $N_S/$total;
my $G = $N_G/$total;
my $F = $N_F/$total;
my $O = $N_O/$total;
my $C = $N_C/$total;
my $P = $N_P/$total;

print OUT12 "Species\t$S\nGenu\t$G\nFamily\t$F\nOrder\t$O\nClass\t$C\nPhylum\t$P\n";

close IN0;
close IN1;
close OUT0;
close OUT1;
close OUT2;
close OUT3;
close OUT4;
close OUT5;
close OUT7;
close OUT8;
close OUT9;
close OUT10;
close OUT11;
close OUT12;

