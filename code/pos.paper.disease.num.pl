#!/usr/bin/perl -w
open IN, $ARGV[0];

my $PWD = "/data/Output_disease.network/pos.Dir";


print "ID\tN_paper\tN_disease\n";
while(<IN>){
        chomp;
        my @ID = split;
        my $dir = $ID[0];
        opendir (DIR, $dir);
        my @dir = readdir DIR;
        my ($n_disease, $n_file) = (0, 0);
        my $ID;
        for my $file(@dir){
        if($file =~ /(\S+).ano.txt.title.info.txt/){
                 $ID = $1;
                open IN0, "< $PWD/$ID[0]/$file";
                while(<IN0>){
                        chomp;
                        my @a = split;
                        $n_file +=1;
                }
		#        print "$ID\t$n_file\t";
        }

        if($file =~ /(\S+).ano.txt.disease.info.txt/){
                 $ID = $1;
                open IN1, "< $PWD/$ID[0]/$file";
                while(<IN1>){
                        chomp;
                        my @a = split;
                        $n_disease +=1;
                }
		#        print "$n_disease\n";
                }
        }
		print "$ID\t$n_file\t$n_disease\n";
        
}
close IN;                 
close IN0;
close IN1;
close DIR;
