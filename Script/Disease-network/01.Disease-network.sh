################### Disease network ##########################
##1. Feature Statistics
mkdir -p /data/Output_disease.network/
cd /data/Output_disease.network/
cpan install List::MoreUtils

perl /code/add.aritle.num.pl /data/all.disease.raw.database.de.final.txt > all.disease.raw.database.de.final.num.txt
#change disease'ID to J_group.summary ID 
perl /code/chang_ID_to_J.pl /data/J_ID.txt  all.disease.raw.database.de.final.num.txt > J.disease.final.txt
sort J.disease.final.txt | uniq > J.disease.final.uniq.txt
perl /code/calcu.info.pl J.disease.final.uniq.txt disease

#Union the bacteria ID and annotation
sort J.disease.final.uniq.txt | uniq | cut -f 2-6 > J.disease.final.uniq2.txt

# find the anno 
perl /code/Bacteria.ID.anno.pl /data/all.Bacteria.anno.uniq.txt J.disease.final.uniq2.txt > J.disease.final.uniq2.ano.txt
#unfind the file
perl /code/no.anno.pl J.disease.final.uniq2.ano.txt J.disease.final.uniq2.txt > J.no.anno.txt

#use the finder file to analysis
#1. add the index into the file
perl /code/add.aritle.num.pl J.disease.final.uniq2.ano.txt > J.disease.final.uniq2.ano.num.txt

#2. calculate the distrubtion in total 
perl /code/calcu.select.info.pl J.disease.final.uniq2.ano.num.txt
perl /code/microbe.up.down.num.pl J.disease.final.uniq2.ano.num.txt.heatmap.up.down.txt > J.disease.final.uniq2.ano.num.txt.heatmap.up.down.bar.txt

#several microbes for each disease
perl /code/per.fiber.microbe.num.pl J.disease.final.uniq2.ano.num.txt.heatmap.txt > J.disease.final.uniq2.ano.num.txt.heatmap.per.disease.microbe.num.txt

##1. Filter
perl /code/del.disease.gt.3.pl J.disease.final.uniq2.ano.num.txt.heatmap.per.disease.microbe.num.txt J.disease.final.uniq2.ano.txt
perl /code/add.aritle.num.pl J.disease.gt3.txt > J.disease.gt3.num.txt
perl /code/calcu.info.pl J.disease.gt3.num.txt disease
perl /code/calcu.select.info.pl J.disease.gt3.num.txt 
perl /code/per.fiber.microbe.num.pl J.disease.gt3.num.txt.heatmap.txt > J.disease.gt3.num.txt.per.disease.microbe.num.txt
perl /code/microbe.up.down.num.pl J.disease.gt3.num.txt.heatmap.up.down.txt > J.disease.gt3.num.txt.heatmap.up.down.txt.bar.txt
perl /code/filter.prevotella.pl J.disease.gt3.num.txt.heatmap.up.down.txt | head -n 51 >  J.disease.gt3.num.txt.heatmap.up.down.Prevotella.top50.bar.txt
head -n 10 J.disease.gt3.num.txt.disease.info.txt > J.disease.gt3.num.txt.disease.info.top10.txt
head -n 10 J.disease.gt3.num.txt.microbe.info.txt > J.disease.gt3.num.txt.microbe.info.top10.txt


#Filter diseases consistent with 20dim
perl /code/select.J.dimension20.ID.pl /data/J_dimension20.txt J.disease.gt3.num.txt.per.disease.microbe.num.txt
mv unfinder.txt  J_dimension20.161.unfinder.ID.txt
perl /code/selct.20dim.ID.pl J_dimension20.161.unfinder.ID.txt J.disease.gt3.num.txt
perl /code/calcu.info.pl J.disease.gt3.Z.20dim.txt disease
perl /code/calcu.select.info.pl J.disease.gt3.Z.20dim.txt

#2. classify the level
rm J.disease.final.uniq2.ano.num.txt.heatmap.up.down.txt.*
perl /code/classify.level.pl J.disease.gt3.Z.20dim.txt J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt

#Species
perl /code/identify.num_of_object.pl J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.species.txt
perl /code/quantitative_strength_of_the_relationship.level.pl J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.species.txt.N.disease.of.micrbobe.txt J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.species.txt J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.species.txt.total.num.disease.txt
perl /code/change.info.to.heatmap.type.pl J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.species.txt.quantitative_strength_of_the_relationship.txt > J.join.Species.quantitative_strength_of_the_relationship.change.txt

#Genu
sort J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Genu2.txt > J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Genu2.sort.txt
perl /code/level.uniq.pl J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Genu2.sort.txt
perl /code/join.level.uniq.pl J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Genu2.sort.txt.uniq.txt J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Genu.txt Genu
perl /code/identify.num_of_object.pl J.join.Genu.uniq.txt
perl /code/quantitative_strength_of_the_relationship.level.pl J.join.Genu.uniq.txt.N.disease.of.micrbobe.txt J.join.Genu.uniq.txt J.join.Genu.uniq.txt.total.num.disease.txt
perl /code/change.info.to.heatmap.type.pl J.join.Genu.uniq.txt.quantitative_strength_of_the_relationship.txt > J.join.Genu.uniq.txt.quantitative_strength_of_the_relationship.change.txt

#Family
sort J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Family2.txt > J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Family2.sort.txt
perl /code/level.uniq.pl J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Family2.sort.txt
perl /code/join.level.uniq.pl J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Family2.sort.txt.uniq.txt J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Family.txt Family
perl /code/identify.num_of_object.pl J.join.Family.uniq.txt
perl /code/quantitative_strength_of_the_relationship.level.pl J.join.Family.uniq.txt.N.disease.of.micrbobe.txt J.join.Family.uniq.txt J.join.Family.uniq.txt.total.num.disease.txt
perl /code/change.info.to.heatmap.type.pl J.join.Family.uniq.txt.quantitative_strength_of_the_relationship.txt > J.join.Family.uniq.txt.quantitative_strength_of_the_relationship.change.txt

#Order
sort J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Order2.txt > J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Order2.sort.txt
perl /code/level.uniq.pl J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Order2.sort.txt
perl /code/join.level.uniq.pl J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Order2.sort.txt.uniq.txt J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Order.txt Order
perl /code/identify.num_of_object.pl J.join.Order.uniq.txt
perl /code/quantitative_strength_of_the_relationship.level.pl J.join.Order.uniq.txt.N.disease.of.micrbobe.txt J.join.Order.uniq.txt J.join.Order.uniq.txt.total.num.disease.txt
perl /code/change.info.to.heatmap.type.pl J.join.Order.uniq.txt.quantitative_strength_of_the_relationship.txt > J.join.Order.uniq.txt.quantitative_strength_of_the_relationship.change.txt

#Class
sort J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Class2.txt > J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Class2.sort.txt
perl /code/level.uniq.pl J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Class2.sort.txt
perl /code/join.level.uniq.pl J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Class2.sort.txt.uniq.txt J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Class.txt Class
perl /code/identify.num_of_object.pl J.join.Class.uniq.txt
perl /code/quantitative_strength_of_the_relationship.level.pl J.join.Class.uniq.txt.N.disease.of.micrbobe.txt J.join.Class.uniq.txt J.join.Class.uniq.txt.total.num.disease.txt
perl /code/change.info.to.heatmap.type.pl J.join.Class.uniq.txt.quantitative_strength_of_the_relationship.txt > J.join.Class.uniq.txt.quantitative_strength_of_the_relationship.change.txt

#Phylum 
sort J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Phylum2.txt > J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Phylum2.sort.txt
perl /code/level.uniq.pl J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Phylum2.sort.txt
perl /code/join.level.uniq.pl J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Phylum2.sort.txt.uniq.txt J.disease.gt3.Z.20dim.txt.heatmap.up.down.txt.Phylum.txt Phylum
perl /code/identify.num_of_object.pl J.join.Phylum.uniq.txt
perl /code/quantitative_strength_of_the_relationship.level.pl J.join.Phylum.uniq.txt.N.disease.of.micrbobe.txt J.join.Phylum.uniq.txt J.join.Phylum.uniq.txt.total.num.disease.txt
perl /code/change.info.to.heatmap.type.pl J.join.Phylum.uniq.txt.quantitative_strength_of_the_relationship.txt > J.join.Phylum.uniq.txt.quantitative_strength_of_the_relationship.change.txt

#4.Calculation weighted consine simialrity 
Rscript /code/Disease-network/02.calculation.R

# weight and cosine similarity
perl /code/join.level.weight-cosine.pl J.join.S.weigth.txt J.join.G.weigth.txt J.join.F.weigth.txt J.join.O.weigth.txt J.join.C.weigth.txt J.join.P.weigth.txt weight

perl /code/join.level.weight-cosine.pl J.join.S_consin.txt J.join.G_consin.txt J.join.F_consin.txt J.join.O_consin.txt J.join.C_consin.txt J.join.P_consin.txt cosine

#z score
perl /code/final.cosine.zvalue.pl J.join.level.cosine.all.txt J.join.level.weight.all.txt
perl /code/change.info.to.heatmap.type.pl J.join.level.cosine.all.txt.add.weight.txt > J.join.level.cosine.all.txt.add.weight.change.txt
perl /code/change.info.to.heatmap.type.pl J.join.level.cosine.all.txt.zvalue.txt > J.join.level.cosine.all.txt.zvalue.change.txt

#P value
Rscript /code/Disease-network/03.pvalue.R
awk '$3<0' J.join.level.cosine.all.txt.zvalue.txt > J.join.level.cosine.all.txt.zvalue_2.txt
Rscript /code/Disease-network/04.zvalue.R
perl /code/change.negative.pvalue.pl  J.join.level.cosine.all.txt.zvlue_2.p.txt J.join.level.final.Pvalue.txt
perl /code/change.info.to.heatmap.type.pl J.join.level.final.Pvalue.txt.final.txt > J.join.level.final.Pvalue.txt.final.change.txt


#adjust P value: FDR
Rscript /code/Disease-network/05.fdr.R

#network
#consin 保留一半
Rscript /code/Disease-network/06.net.R

#change ID 
perl /code/select.J.dimension20.ID.pl /data/J_dimension20.txt J.disease.gt3.num.txt.per.disease.microbe.num.txt
cut -f 1 J.disease.gt3.num.txt.per.disease.microbe.num.txt.finder.txt | sort > J_dimension20_161.txt.finder.ID.txt

perl /code/finder.cluster.system.pl /data/V2.FinalPhenotypes.txt J_dimension20_161.txt.finder.ID.txt
cut -f 1 J.join.level.cosine.all.txt.add.weight.change.txt | sort | uniq | sed '1d' > J.join.level.cosine.all.txt.add.weight.change.ID.txt
paste J.join.level.cosine.all.txt.add.weight.change.ID.txt J_dimension20_161.txt.finder.ID.txt > J.join.level.consin.all.txt.filter.20min.ID2.161.txt
#consin
perl /code/change.consinID.to.20dim.ID.pl J.join.level.consin.all.txt.filter.20min.ID2.161.txt J.join.level.cosine.all.txt.add.weight.txt > J.join.level.cosine.all.txt.add.weight.20dimID.txt
perl /code/change.consinID.to.20dim.ID.pl J.join.level.consin.all.txt.filter.20min.ID2.161.txt J.join.level.cosine.all.txt.add.weight.change.single.txt > J.join.level.cosine.all.txt.add.weight.change.single.20dim.ID.txt

perl /code/change.info.to.heatmap.type.pl J.join.level.cosine.all.txt.add.weight.20dimID.txt > J.join.level.consin.all.txt.filter.20min.ID2.change.txt

#pvalue
perl /code/change.consinID.to.20dim.ID.pl J.join.level.consin.all.txt.filter.20min.ID2.161.txt J.join.level.final.Pvalue.txt.final.FDR.single.txt > J.join.level.final.Pvalue.txt.final.FDR.singel.20dim.ID.txt

##change the format
perl /code/change.consinID.to.20dim.ID.pl J.join.level.consin.all.txt.filter.20min.ID2.161.txt J.join.level.final.Pvalue.txt.final.txt > J.join.level.final.Pvalue.txt.final.20dim.ID.txt
perl /code/change.info.to.heatmap.type.pl J.join.level.final.Pvalue.txt.final.20dim.ID.txt > J.join.level.final.Pvalue.txt.final.20dim.ID.change.txt
perl /code/Fdr.change.pl J.join.level.final.Pvalue.txt.final.20dim.ID.change.txt J.join.level.final.Pvalue.txt.final.FDR.singel.20dim.ID.txt > J.join.level.final.Pvalue.txt.final.FDR.change.txt


#edges
awk '$3<0.05' J.join.level.final.Pvalue.txt.final.FDR.singel.20dim.ID.txt > J.join.level.final.Pvalue.txt.final.FDR.singel.20dim.ID.0.05.txt
perl /code/cal.net.value.pl J.join.level.cosine.all.txt.add.weight.change.single.20dim.ID.txt 0 > J.join.level.cosine.all.txt.add.weight.change.single.20dim.ID.net.0.txt
perl /code/net.sig.pl J.join.level.final.Pvalue.txt.final.FDR.singel.20dim.ID.0.05.txt J.join.level.cosine.all.txt.add.weight.change.single.20dim.ID.net.0.txt

#subnetwork
grep 'Ulcerative_Colitis' J.join.level.cosine.all.txt.add.weight.change.single.20dim.ID.net.0.txt.only.P.sign.txt | sort -n -k 3 > Ulcerative_Colitis.Padj.sig.txt
grep 'Crohns_Disease' J.join.level.cosine.all.txt.add.weight.change.single.20dim.ID.net.0.txt.only.P.sign.txt | sort -n -k 3 > Crohns_Disease.Padj.sig.txt

grep 'negative' Ulcerative_Colitis.Padj.sig.txt | tail -n 5 > UC_CD.top5.Padj.txt
grep 'positive' Ulcerative_Colitis.Padj.sig.txt | tail -n 5 >> UC_CD.top5.Padj.txt
grep 'positive' Crohns_Disease.Padj.sig.txt | tail -n 5  >> UC_CD.top5.Padj.txt
grep 'negative' Crohns_Disease.Padj.sig.txt | tail -n 5 >> UC_CD.top5.Padj.txt

###20-min cluster
ln /data/J_dimension20.txt ./
perl /code/select.J.dimension20.ID.pl  J.disease.gt3.num.txt.per.disease.microbe.num.txt J_dimension20.txt
perl /code/finder.cluster.system.pl /data/V2.FinalPhenotypes.txt J_dimension20.txt.finder.txt


#####################################################################
#heatmap
Rscript /code/Disease-network/07.heatmap.bar.R

perl /code/chang.bar.value.pl J.join.level.consin.all.txt.filter.20min.ID2.change.txt.bar.txt 0.5
perl /code/change.info.to.heatmap.type.pl J.join.level.consin.all.txt.filter.20min.ID2.change.txt.bar.txt.change.bra_value.txt > J.join.level.consin.all.txt.filter.20min.ID2.change.txt.bar.txt.change.bra_value.change.txt



#################################
#correlation
################################
mkdir -p /data/Output_disease.network/Correlation
cd /data/Output_disease.network/Correlation
ln -s ../J.join.level.cosine.all.txt.add.weight.20dimID.txt ./
ln -s ../J_dimension20_161.txt.finder.cosine.similarity.txt ./
ln -s ../J_dimension20.txt.finder.txt.system.txt ./
ln -s ../J.join.level.consin.all.txt.filter.20min.ID2.161.txt ./

#info
perl /code/change.consinID.to.20dim.ID.pl J.join.level.consin.all.txt.filter.20min.ID2.161.txt J_dimension20_161.txt.finder.cosine.similarity.txt > J_dimension20_161.txt.finder.cosine.similarity.20dim.ID.txt
perl /code/combine.pl J.join.level.cosine.all.txt.add.weight.20dimID.txt J_dimension20_161.txt.finder.cosine.similarity.20dim.ID.txt > 161.disease.combine.txt
#19 system's info
perl /code/split.sys.pl J_dimension20.txt.finder.txt.system.txt 161.disease.combine.txt

####################################
#Disturbance Socre 
mkdir -p /data/Output_disease.network/pos.Dir
cd /data/Output_disease.network/pos.Dir


ln -s ../J.disease.final.uniq2.ano.num.txt ./
perl /code/calcu.info.pl J.disease.final.uniq2.ano.num.txt disease
perl /code/split.postion.pl J.disease.final.uniq2.ano.num.txt.postion.info.txt J.disease.final.uniq2.ano.num.txt

#sta——info
ls * | grep "ano.txt" > pos.txt
perl /code/pos.dir.sta.pl pos.txt 
wc -l dir.txt #45 position
perl /code/pos.paper.disease.num.pl dir.txt > All.45.pos.info.txt

perl /code/pos.score.pl dir.txt

perl /code/pos.join.score.pl All.45.pos.info.txt
perl /code/Pos.disturbance.score.pl All.29.pos.score.txt > All.29.pos.disturbace.score.txt
perl /code/pos.disease_to_pos.num.pl All.29.pos.score.txt > All.29.pos.score.disease_to_pos.txt

grep 'Gastrointestinal_tract' All.29.pos.disturbace.score.txt > Top5.disturbace.score.txt
grep 'Nasal_cavity' All.29.pos.disturbace.score.txt >> Top5.disturbace.score.txt
grep 'Skin' All.29.pos.disturbace.score.txt >> Top5.disturbace.score.txt
grep 'Oral_mucosae' All.29.pos.disturbace.score.txt >> Top5.disturbace.score.txt
grep 'Saliva' All.29.pos.disturbace.score.txt >> Top5.disturbace.score.txt
perl /code/pos.score.to.all.disease.pl Top5.disturbace.score.txt  > Top5.disturbace.score.change.txt

grep 'Gastrointestinal_tract' All.29.pos.disturbace.score.txt > GI.disturbance.score.txt
#calculation distribution of GI score: 1 is the step length
perl /code/DS.distribution.pl GI.disturbance.score.txt 1

perl /code/pos.disease_to_pos.num.pl All.29.pos.disturbace.score.txt > All.29.pos.disturbace.score.disease_to_pos.txt
head -n 20 All.29.pos.disturbace.score.disease_to_pos.txt > All.29.pos.disturbace.score.disease_to_pos.head20.txt

grep -w 'Gastrointestinal_tract' All.29.pos.disturbace.score.txt > Top5.disturbace.score.txt
grep -w 'Nasal_cavity' All.29.pos.disturbace.score.txt >> Top5.disturbace.score.txt
grep -w 'Skin' All.29.pos.disturbace.score.txt >> Top5.disturbace.score.txt
grep -w 'Oral_mucosae' All.29.pos.disturbace.score.txt >> Top5.disturbace.score.txt
grep -w 'Saliva' All.29.pos.disturbace.score.txt >> Top5.disturbace.score.txt
perl ../../../code/pos.score.to.all.disease.pl  Top5.disturbace.score.txt > Top5.disturbace.score.change.txt 
awk '{gsub(/_/, " "); print $0}' Top5.disturbace.score.change.txt > Top5.disturbace.score.change2.txt



##############################################
####order ID  for cluster or heatmap
#1.  prepare the file 
cut -f  2 J_dimension20_161.txt.finder.ID.txt.system.txt | sort | uniq | awk '!/^Class/ {printf "%s\n", $0}' > 19.sys.ID.txt
perl /code/19.sys.order.pl 19.sys.ID.txt J_dimension20_161.txt.finder.ID.txt.system.txt > J_dimension20_161.txt.finder.ID.txt.system.Order.txt
awk '{gsub(/_/, " "); print $0}' J_dimension20_161.txt.finder.ID.txt.system.Order.txt > J_dimension20_161.txt.finder.ID.txt.system.Order2.txt

### 2. Order diseases ID for the heatmap matrix 
#20dim-based data
perl /code/change.consinID.to.20dim.ID.pl J.join.level.consin.all.txt.filter.20min.ID2.161.txt  J_dimension20_161.txt.finder.cosine.similarity.txt > J_dimension20_161.txt.finder.cosine.similarity.20dim.txt
perl /code/161.heatmap.ID.order.pl J_dimension20_161.txt.finder.ID.txt.system.Order.txt J_dimension20_161.txt.finder.cosine.similarity.20dim.txt > J_dimension20_161.txt.finder.cosine.similarity.20dim.order.change.txt
awk '{gsub(/_/, " "); print $0}' J_dimension20_161.txt.finder.cosine.similarity.20dim.order.change.txt > J_dimension20_161.txt.finder.cosine.similarity.20dim.order.change2.txt

#microbe-based data
perl /code/change.consinID.to.20dim.ID.pl J.join.level.consin.all.txt.filter.20min.ID2.161.txt J.join.level.cosine.all.txt.add.weight.txt > J.join.level.cosine.all.txt.add.weight.20dim.txt
perl /code/161.heatmap.ID.order.pl J_dimension20_161.txt.finder.ID.txt.system.Order.txt J.join.level.cosine.all.txt.add.weight.20dim.txt > J.join.level.cosine.all.txt.add.weight.20dim.order.change.txt
awk '{gsub(/_/, " "); print $0}' J.join.level.cosine.all.txt.add.weight.20dim.order.change.txt > J.join.level.cosine.all.txt.add.weight.20dim.order.change2.txt

# get J-dim's cluster ID
Rscript /code/Disease-network/08.order.ID.R 


#######################
#three node loops
#######################
####6. motif 
# 6.1 Three-node-loops 
mkdir -p /data/Output_disease.network/Loops_dir
cd /data/Output_disease.network/Loops_dir
ln -s ../J.join.level.cosine.all.txt.add.weight.change.single.txt ./
perl /code/finder.motif.pl J.join.level.cosine.all.txt.add.weight.change.single.txt

#6.2 Randomizaton test
Rscript /code/Disease-network/08.randomization.R

#multi-route
perl /code/work.multi.node.fiber.pl > test.sh
cat test.sh | parallel -j 10

