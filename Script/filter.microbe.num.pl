#之前的过滤条件为 if microbe 少于三种 type fiber 则delete
##本脚本继续过滤，条件为：if 只有1种fiber引起的microbe波动，则该种evidence>3 保留，否则delete.
## filter.microbe.num.pl
#!/usr/bin/perl -w
use strict;
open IN0, $ARGV[0]; #filter.fiber.gt.3.txt.N.fiber.associated.with.microbe.txt
open IN1, $ARGV[1]; #filter.fiber.gt.3.txt.microbe.info.txt
open IN2, $ARGV[2]; #filter.fiber.gt.3.txt

my (%hash, %in, %title); 
while(<IN0>){
	chomp;
	my @l = split(/\t/);
	if($l[1] <= $ARGV[3]){     #设置每种microbe下的fiber种类为cutoff
	$hash{$l[0]} = 1;
	}else{
	$in{$l[0]}=1;
	}
}
#Test
#foreach my $key(keys %in){
#	print "$key\n";     #34种microbe
#}
#my %add;

while(<IN1>){
	chomp;
	my @line = split(/\t/);
	if (exists $hash{$line[0]}){
		if($line[1] >= $ARGV[4]) {   #设置文章证据个数为cutoff
		$in{$line[0]}= $line[0];
		}
	}
}
#Test
#foreach my $key(keys %in){
#       print "$key\n";
#}

while(<IN2>){
	chomp;
	my @key = split(/\t/);
	if(exists $in{$key[3]}){
		print join("\t", @key), "\n" ;
	}
	
}

close IN0;
close IN1;
close IN2;


