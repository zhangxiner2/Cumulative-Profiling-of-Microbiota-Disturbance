#!/bin/bash
 
perl /code/classify.level.pl $1.ano.txt $1.ano.txt.heatmap.up.down.txt

sort $1.ano.txt.heatmap.up.down.txt.Genu2.txt > $1.ano.txt.heatmap.up.down.txt.Genu2.sort.txt
perl /code/level.uniq.pl $1.ano.txt.heatmap.up.down.txt.Genu2.sort.txt
perl /code/join.level.uniq.pl $1.ano.txt.heatmap.up.down.txt.Genu2.sort.txt.uniq.txt $1.ano.txt.heatmap.up.down.txt.Genu.txt Genu

sort $1.ano.txt.heatmap.up.down.txt.Family2.txt > $1.ano.txt.heatmap.up.down.txt.Family2.sort.txt
perl /code/level.uniq.pl $1.ano.txt.heatmap.up.down.txt.Family2.sort.txt
perl /code/join.level.uniq.pl $1.ano.txt.heatmap.up.down.txt.Family2.sort.txt.uniq.txt $1.ano.txt.heatmap.up.down.txt.Family.txt Family

sort $1.ano.txt.heatmap.up.down.txt.Order2.txt > $1.ano.txt.heatmap.up.down.txt.Order2.sort.txt
perl /code/level.uniq.pl $1.ano.txt.heatmap.up.down.txt.Order2.sort.txt
perl /code/join.level.uniq.pl $1.ano.txt.heatmap.up.down.txt.Order2.sort.txt.uniq.txt $1.ano.txt.heatmap.up.down.txt.Order.txt Order

sort $1.ano.txt.heatmap.up.down.txt.Class2.txt > $1.ano.txt.heatmap.up.down.txt.Class2.sort.txt
perl /code/level.uniq.pl $1.ano.txt.heatmap.up.down.txt.Class2.sort.txt
perl /code/join.level.uniq.pl $1.ano.txt.heatmap.up.down.txt.Class2.sort.txt.uniq.txt $1.ano.txt.heatmap.up.down.txt.Class.txt Class

sort $1.ano.txt.heatmap.up.down.txt.Phylum2.txt > $1.ano.txt.heatmap.up.down.txt.Phylum2.sort.txt
perl /code/level.uniq.pl $1.ano.txt.heatmap.up.down.txt.Phylum2.sort.txt
perl /code/join.level.uniq.pl $1.ano.txt.heatmap.up.down.txt.Phylum2.sort.txt.uniq.txt $1.ano.txt.heatmap.up.down.txt.Phylum.txt Phylum

cat $1.ano.txt.heatmap.up.down.txt.species.txt J.join.Genu.uniq.txt J.join.Family.uniq.txt J.join.Order.uniq.txt J.join.Class.uniq.txt J.join.Phylum.uniq.txt | sort | uniq > all.level.heatmap.up.down.txt

perl /code/identify.num_of_object.pl all.level.heatmap.up.down.txt
perl /code/quantitative_strength_of_the_relationship.level.pl all.level.heatmap.up.down.txt.N.disease.of.micrbobe.txt all.level.heatmap.up.down.txt all.level.heatmap.up.down.txt.total.num.disease.txt

