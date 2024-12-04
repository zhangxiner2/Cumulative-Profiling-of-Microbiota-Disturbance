#!/usr/bin/perl -w
use strict;
use List::MoreUtils qw(uniq);
#Author : Xin Zhang 
#The script is used to find three node loops motif of network. 

open IN, $ARGV[0];
open OUT, "> $ARGV[0].motif.txt";
my (@array, $edges);
$edges = 0;
while(<IN>){
	chomp;
	my @a = split;
	push (@array, $a[0], $a[1]);
	$edges +=1, if($a[2] != 0);
}

my @new_array = uniq @array;
my $node_num = @new_array;
print OUT "######################### Summary ############################", "\n";
print OUT "The total number of Node is: $node_num\n";
print OUT "The total number of Edge is: $edges\n";

my ($idex, %hash, $num, @motif, @id, $num_Incoherent, $num_coherent);
my $num_motif = $num_Incoherent = $num_coherent = 0;
for my $i (@new_array){
	for my $j (@new_array){
		for my $k (@new_array){
			if(($i ne $j) and ($i ne $k) and ($j ne $k)){
				$num += 1;
				my $val = join("\t", sort($i, $j, $k));
				$hash{$val}=$num;
			}
		}
	}	
}

my $length = keys %hash;
print OUT "The theory num of three node loop is :$length\n\n";
print OUT "#################### List of threee node loop ################", "\n";
for my $key (sort keys %hash){
	my @value = split(/\t/, $key);
	my $k1 = join("\t", sort($value[0], $value[1]));
	my $k2 = join("\t", sort($value[0], $value[2]));
	my $k3 = join("\t", sort($value[1], $value[2]));
#print "$k1\t$k2\t$k3\n";	
	my @new_array;
	push(@new_array, $k1, $k2, $k3);
	open IN, $ARGV[0];
	while(<IN>){
		chomp;
		my @b = split;
		my $k4 = join("\t", sort($b[0], $b[1]));
#print "$k4\n";
#print "@new_array\n";
		if(grep /^$k4$/, @new_array){
			my $v = join("\t", @b);
			push (@motif, $v);			
		}
	}
my $len = @motif;
#print "$len\t@motif\n";
if($len == 3){
#	print "@motif\nNext\n";
	my @s1 = split(/\t/,$motif[0]);
	my @s2 = split(/\t/,$motif[1]);
	my @s3 = split(/\t/,$motif[2]);
	my $multip = $s1[2] * $s2[2] * $s3[2];
	push (@id, $s1[0],$s1[1],$s2[0],$s2[1]);
	if($multip > 0){
		my @uniq_id = uniq @id;
		my $type = "Coherent";
		print OUT join ("\t",@uniq_id),"\t$type\n";
		$num_coherent +=1;
		}
	if($multip < 0){
		my @uniq_id = uniq @id;
                my $type = "Incoherent";
                print OUT join ("\t",@uniq_id),"\t$type\n";
		$num_Incoherent += 1;
		}
	@id=();
	}

@motif=();
}
$num_motif = $num_coherent + $num_Incoherent;
my $ratio = $num_coherent/$num_Incoherent;
print "$ratio\n";
print OUT "\n######################### Conclusion #########################", "\n";
print OUT "The real num of threee node loop is: $num_motif\n";
print OUT "The real num of Coherent loop is: $num_coherent\n";
print OUT "The real num of Incoherent loop is: $num_Incoherent\n";
print OUT "The ratio of Coherent/Incoherent loop is: $ratio\n";
close IN;


