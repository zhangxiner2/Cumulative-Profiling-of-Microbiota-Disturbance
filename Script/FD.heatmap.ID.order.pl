open IN0, $ARGV[0];
open IN1, $ARGV[1];

my (@Fiber, @Disease);
while(<IN0>){
	chomp;
	my @a = split(/\t/, $_);
	push (@Fiber, $a[0]);
}

while(<IN1>){
	chomp;
	my @b = split(/\t/, $_);
	push (@Disease, $b[0]);
}

open IN2, $ARGV[2];
		while(<IN2>){
			chomp;
			my @c = split(/\t/, $_);
			my $key = join("\t", $c[0], $c[1]);
			$hash{$key} = $c[2];
}

foreach my $k2(@Disease){
print "\t$k2";
}
print "\n";

foreach my $k1(@Fiber){
	print "$k1";
	foreach my $k2(@Disease){
		my $k = join("\t", $k1, $k2);
		if (exists $hash{$k}){
			print "\t$hash{$k}";
		}else{
		print "\t0";
		}
		
		
	}print "\n";
}

close IN0;
close IN1;
close IN2;
