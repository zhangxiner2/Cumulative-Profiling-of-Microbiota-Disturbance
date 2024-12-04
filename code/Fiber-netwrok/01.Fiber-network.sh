################### Fiber network ##########################
#1. Feature Statistics（fiber_num， microbe_name, knowen_relationship）
if [! -d "/data/Output_fiber.network/"]; then
    mkdir -p /data/Output_fiber.network/    
fi

cpan install List::MoreUtils
#1. Feature of fiber-microbe dataset 
cd /data/Output_fiber.network/
perl /code/add.aritle.num.pl /data/fiber_raw.database.txt > fiber_raw.database
perl /code/calcu.info.pl fiber_raw.database fiber
wc -l /data/Output_fiber.network/fiber_raw.database.microbe.info.txt /data/Output_fiber.network/fiber_raw.database.fiber.info.txt

#2. Top 10 microbe with the largest number of published articles 
head -n 10 fiber_raw.database.microbe.info.txt > fiber_raw.database.microbe.info.txt.head10

#top 11 fibers with the most published articles.
head -n 11 fiber_raw.database.fiber.info.txt > fiber_raw.database.fiber.info.txt.head11


#3. filter
perl /code/calcu.select.info.pl fiber_raw.database
perl /code/change.info.to.heatmap.type.pl fiber_raw.database.heatmap.txt > fiber_raw.database.heatmap.txt.change.txt
perl /code/per.fiber.microbe.num.pl fiber_raw.database.heatmap.txt > per.fiber.microbe.num.txt
perl /code/filter.fiber.gt.3.pl per.fiber.microbe.num.txt fiber_raw.database > filter.fiber.gt.3.txt

#anno 
cut -f 2-6 filter.fiber.gt.3.txt > filter.fiber.gt.3.2-6.txt
perl /code/Bacteria.ID.anno.pl /data/all.Bacteria.anno.uniq.txt filter.fiber.gt.3.2-6.txt >  fiber_raw.uniq.ano.txt
#unfinder the file
perl /code/no.anno.pl fiber_raw.uniq.ano.txt  filter.fiber.gt.3.2-6.txt >  fiber.no.anno.txt

#3.1. add the index into the file
perl /code/add.aritle.num.pl fiber_raw.uniq.ano.txt > fiber_raw.uniq.ano.num.txt
#3.2. calculate the distrubtion in total
perl /code/calcu.info.pl fiber_raw.uniq.ano.num.txt fiber
perl /code/calcu.select.info.pl fiber_raw.uniq.ano.num.txt
perl /code/microbe.up.down.num.pl fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt > fiber_raw.uniq.ano.num.txt.heatmap.up.down.bar.txt

#Filtered data distribution
perl /code/change.info.to.heatmap.type.pl  fiber_raw.uniq.ano.num.txt.heatmap.txt > fiber_raw.uniq.ano.num.txt.heatmap.txt.change.txt

#4. classify the level
rm fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.*
perl /code/classify.level.pl fiber_raw.uniq.ano.num.txt fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt

echo "############"
echo "Don't worry if you receive a warning about the uninitialized variation. It means the file doesn't contain this level of information. This can't influence the final result!"
echo "############"
#4.2 Calculate the quantized association
#Species
perl /code/identify.num_of_object.pl fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.species.txt
perl /code/quantitative_strength_of_the_relationship.level.pl fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.species.txt.N.disease.of.micrbobe.txt fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.species.txt fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.species.txt.total.num.disease.txt
perl /code/change.info.to.heatmap.type.pl fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.species.txt.quantitative_strength_of_the_relationship.txt > fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.species.txt.quantitative_strength_of_the_relationship.change.txt
mv fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.species.txt.quantitative_strength_of_the_relationship.change.txt J.join.Species.uniq.txt.quantitative_strength_of_the_relationship.change.txt

#Genu
sort fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Genu2.txt > fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Genu2.sort.txt
perl /code/level.uniq.pl fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Genu2.sort.txt
perl /code/join.level.uniq.pl fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Genu2.sort.txt.uniq.txt fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Genu.txt Genu
perl /code/identify.num_of_object.pl J.join.Genu.uniq.txt
perl /code/quantitative_strength_of_the_relationship.level.pl J.join.Genu.uniq.txt.N.disease.of.micrbobe.txt J.join.Genu.uniq.txt J.join.Genu.uniq.txt.total.num.disease.txt
perl /code/change.info.to.heatmap.type.pl J.join.Genu.uniq.txt.quantitative_strength_of_the_relationship.txt > J.join.Genu.uniq.txt.quantitative_strength_of_the_relationship.change.txt

##Family 
sort fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Family2.txt > fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Family2.sort.txt
perl /code/level.uniq.pl fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Family2.sort.txt
perl /code/join.level.uniq.pl fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Family2.sort.txt.uniq.txt fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Family.txt Family
perl /code/identify.num_of_object.pl J.join.Family.uniq.txt
perl /code/quantitative_strength_of_the_relationship.level.pl J.join.Family.uniq.txt.N.disease.of.micrbobe.txt J.join.Family.uniq.txt J.join.Family.uniq.txt.total.num.disease.txt
perl /code/change.info.to.heatmap.type.pl J.join.Family.uniq.txt.quantitative_strength_of_the_relationship.txt > J.join.Family.uniq.txt.quantitative_strength_of_the_relationship.change.txt

#Order 
sort fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Order2.txt > fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Order2.sort.txt
perl /code/level.uniq.pl fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Order2.sort.txt
perl /code/join.level.uniq.pl fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Order2.sort.txt.uniq.txt fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Order.txt Order
perl /code/identify.num_of_object.pl J.join.Order.uniq.txt
perl /code/quantitative_strength_of_the_relationship.level.pl J.join.Order.uniq.txt.N.disease.of.micrbobe.txt J.join.Order.uniq.txt J.join.Order.uniq.txt.total.num.disease.txt
perl /code/change.info.to.heatmap.type.pl J.join.Order.uniq.txt.quantitative_strength_of_the_relationship.txt > J.join.Order.uniq.txt.quantitative_strength_of_the_relationship.change.txt

##Class 
sort fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Class2.txt > fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Class2.sort.txt
perl /code/level.uniq.pl fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Class2.sort.txt
perl /code/join.level.uniq.pl fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Class2.sort.txt.uniq.txt fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Class.txt Class
perl /code/identify.num_of_object.pl J.join.Class.uniq.txt
perl /code/quantitative_strength_of_the_relationship.level.pl J.join.Class.uniq.txt.N.disease.of.micrbobe.txt J.join.Class.uniq.txt J.join.Class.uniq.txt.total.num.disease.txt
perl /code/change.info.to.heatmap.type.pl J.join.Class.uniq.txt.quantitative_strength_of_the_relationship.txt > J.join.Class.uniq.txt.quantitative_strength_of_the_relationship.change.txt

#Phylum association 
sort fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Phylum2.txt > fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Phylum2.sort.txt
perl /code/level.uniq.pl fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Phylum2.sort.txt
perl /code/join.level.uniq.pl fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Phylum2.sort.txt.uniq.txt fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.Phylum.txt Phylum
perl /code/identify.num_of_object.pl J.join.Phylum.uniq.txt
perl /code/quantitative_strength_of_the_relationship.level.pl J.join.Phylum.uniq.txt.N.disease.of.micrbobe.txt J.join.Phylum.uniq.txt J.join.Phylum.uniq.txt.total.num.disease.txt
perl /code/change.info.to.heatmap.type.pl J.join.Phylum.uniq.txt.quantitative_strength_of_the_relationship.txt > J.join.Phylum.uniq.txt.quantitative_strength_of_the_relationship.change.txt

#4.3 Calculation weighted consine simialrity 
Rscript /code/Fiber-network/02.calculation.R

#4.6 weight 
perl /code/join.level.weight-cosine.pl J.join.S.weigth.txt J.join.G.weigth.txt J.join.F.weigth.txt J.join.O.weigth.txt J.join.C.weigth.txt J.join.P.weigth.txt weight
perl /code/join.level.weight-cosine.pl J.join.S_consin.txt J.join.G_consin.txt J.join.F_consin.txt J.join.O_consin.txt J.join.C_consin.txt J.join.P_consin.txt cosine

#4.7 cosine and z score
perl /code/final.cosine.zvalue.pl J.join.level.cosine.all.txt J.join.level.weight.all.txt
perl /code/change.info.to.heatmap.type.pl J.join.level.cosine.all.txt.zvalue.txt > J.join.level.cosine.all.txt.zvalue.change.txt
perl /code/change.info.to.heatmap.type.pl J.join.level.cosine.all.txt.add.weight.txt > J.join.level.cosine.all.txt.add.weight.change.txt

#4.8 P value
Rscript /code/Fiber-network/03.pvalue.R
awk '$3<0' J.join.level.cosine.all.txt.zvalue.txt > J.join.level.cosine.all.txt.zvalue_2.txt
Rscript /code/Fiber-network/04.zvalue.R
perl /code/change.negative.pvalue.pl J.join.level.cosine.all.txt.zvlue_2.p.txt J.join.level.final.Pvalue.txt
perl /code/change.info.to.heatmap.type.pl J.join.level.final.Pvalue.txt.final.txt > J.join.level.final.Pvalue.txt.final.change.txt

#5. plot preparation
#5.1 heatmap calculation
#adjust P value, FDR
Rscript /code/Fiber-network/05.fdr.R

#5.2 change the format
perl /code/Fdr.change.pl J.join.level.final.Pvalue.txt.final.change.txt J.join.level.final.Pvalue.txt.final.FDR.single.txt > J.join.level.final.Pvalue.txt.final.FDR.change.txt

#5.3 network 
#consin_single
Rscript /code/Fiber-network/06.net.R
#edges
awk '$3<0.05' J.join.level.final.Pvalue.txt.final.FDR.single.txt > J.join.level.final.Pvalue.txt.final.FDR.single.0.05.txt
perl /code/cal.net.value.pl J.join.level.cosine.all.txt.add.weight.change.single.txt 0 > J.join.level.cosine.all.txt.add.weight.change.single.net.0.txt
perl /code/net.sig.pl J.join.level.final.Pvalue.txt.final.FDR.single.0.05.txt J.join.level.cosine.all.txt.add.weight.change.single.net.0.txt

#6.Order ID for cluster and heatmap
cd /data/Output_fiber.network/
#cat fiber.ID.class.txt | awk '{gsub(/B.GOS/, "B-GOS"); print $0}' | awk '{gsub(/Agave.inulin/, "Agave inulin"); print $0}' | awk '{gsub(/β.glucan/, "β-glucan"); print $0}' > fiber.ID.class2.txt

perl /code/161.heatmap.ID.order.pl fiber.ID.class.txt J.join.level.cosine.all.txt.add.weight.txt > J.join.level.cosine.all.txt.add.weight.order.change.txt

perl /code/161.heatmap.ID.order.pl fiber.ID.class.txt J.join.level.final.Pvalue.txt.final.FDR.txt > J.join.level.final.Pvalue.txt.final.FDR.order.change.txt

Rscript /code/Fiber-network/07.similarity.distribution.R

#AXOS-Inulin
grep -w 'AXOS' 32.fiber.J.join.level.cosine.all.txt.add.weight.single.txt > 32.fiber.J.join.level.cosine.all.txt.add.weight.single.AXOS-Inulin.txt
grep -w 'Inulin' 32.fiber.J.join.level.cosine.all.txt.add.weight.single.txt >> 32.fiber.J.join.level.cosine.all.txt.add.weight.single.AXOS-Inulin.txt 



####7. motif 
# 7.1 Three-node-loops 
mkdir -p /data/Output_fiber.network/Loops_dir
cd /data/Output_fiber.network/Loops_dir
ln -s ../J.join.level.cosine.all.txt.add.weight.change.single.txt ./
perl /code/finder.motif.pl J.join.level.cosine.all.txt.add.weight.change.single.txt

#6.2 Randomizaton test
Rscript /code/Fiber-network/08.randomization.R
#multi-threaded computing
perl /code/work.multi.node.fiber.pl > test.sh
cat test.sh | parallel -j 10








