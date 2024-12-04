#only gut
mkdir /data/Output_FD.network/ 
cd /data/Output_FD.network/ 
cpan install List::MoreUtils


grep 'Gastrointestinal tract' /data/Output_disease.network/J.disease.gt3.Z.20dim.txt | cut -f 2-13 > J.disease.gt3.Z.20dim.only.gut.txt
#info 
perl /code/add.aritle.num.pl J.disease.gt3.Z.20dim.only.gut.txt > J.disease.gt3.Z.20dim.only.gut.num.txt
perl /code/calcu.info.pl J.disease.gt3.Z.20dim.only.gut.num.txt disease
perl /code/calcu.select.info.pl J.disease.gt3.Z.20dim.only.gut.num.txt

#Calculate the quantized association
rm J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.*

perl /code/classify.level.pl J.disease.gt3.Z.20dim.only.gut.num.txt J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt

ln -s /data/Output_fiber.network/J.join.Phylum.uniq.txt.quantitative_strength_of_the_relationship.txt fiber.Phylum.quantitative.txt
ln -s /data/Output_fiber.network/J.join.Class.uniq.txt.quantitative_strength_of_the_relationship.txt fiber.Class.quantitative.txt
ln -s /data/Output_fiber.network/J.join.Order.uniq.txt.quantitative_strength_of_the_relationship.txt fiber.Order.quantitative.txt
ln -s /data/Output_fiber.network/J.join.Family.uniq.txt.quantitative_strength_of_the_relationship.txt fiber.Family.quantitative.txt
ln -s /data/Output_fiber.network/J.join.Genu.uniq.txt.quantitative_strength_of_the_relationship.txt fiber.Genu.quantitative.txt
ln -s /data/Output_fiber.network/fiber_raw.uniq.ano.num.txt.heatmap.up.down.txt.species.txt.quantitative_strength_of_the_relationship.txt fiber.Species.quantitative.txt

#Species 
perl /code/identify.num_of_object.pl J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.species.txt 
perl /code/quantitative_strength_of_the_relationship.level.pl J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.species.txt.N.disease.of.micrbobe.txt J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.species.txt J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.species.txt.total.num.disease.txt
cat fiber.Species.quantitative.txt J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.species.txt.quantitative_strength_of_the_relationship.txt > zx.fiber-disease.species.txt
perl /code/change.info.to.heatmap.type.pl zx.fiber-disease.species.txt > zx.fiber-disease.species.change.txt

#Genu
sort J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Genu2.txt > J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Genu2.sort.txt
perl /code/level.uniq.pl J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Genu2.sort.txt 
perl /code/join.level.uniq.pl J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Genu2.sort.txt.uniq.txt J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Genu.txt Genu
perl /code/identify.num_of_object.pl J.join.Genu.uniq.txt
perl /code/quantitative_strength_of_the_relationship.level.pl J.join.Genu.uniq.txt.N.disease.of.micrbobe.txt J.join.Genu.uniq.txt J.join.Genu.uniq.txt.total.num.disease.txt
cat fiber.Genu.quantitative.txt J.join.Genu.uniq.txt.quantitative_strength_of_the_relationship.txt > zx.fiber.disease.Genu.txt
perl /code/change.info.to.heatmap.type.pl zx.fiber.disease.Genu.txt > zx.fiber.disease.Genu.change.txt

#Family
sort J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Family2.txt > J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Family2.sort.txt
perl /code/level.uniq.pl J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Family2.sort.txt
perl /code/join.level.uniq.pl J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Family2.sort.txt.uniq.txt J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Family.txt Family
perl /code/identify.num_of_object.pl J.join.Family.uniq.txt
perl /code/quantitative_strength_of_the_relationship.level.pl J.join.Family.uniq.txt.N.disease.of.micrbobe.txt J.join.Family.uniq.txt J.join.Family.uniq.txt.total.num.disease.txt
cat fiber.Family.quantitative.txt J.join.Family.uniq.txt.quantitative_strength_of_the_relationship.txt > zx.fiber.disease.Family.txt
perl /code/change.info.to.heatmap.type.pl zx.fiber.disease.Family.txt > zx.fiber.disease.Family.change.txt


#Order 
sort J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Order2.txt > J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Order2.sort.txt
perl /code/level.uniq.pl J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Order2.sort.txt
perl /code/join.level.uniq.pl J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Order2.sort.txt.uniq.txt J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Order.txt Order
perl /code/identify.num_of_object.pl J.join.Order.uniq.txt
perl /code/quantitative_strength_of_the_relationship.level.pl J.join.Order.uniq.txt.N.disease.of.micrbobe.txt J.join.Order.uniq.txt J.join.Order.uniq.txt.total.num.disease.txt
cat fiber.Order.quantitative.txt J.join.Order.uniq.txt.quantitative_strength_of_the_relationship.txt > zx.fiber.disease.Order.txt
perl /code/change.info.to.heatmap.type.pl zx.fiber.disease.Order.txt > zx.fiber.disease.Order.change.txt

##Class 
sort J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Class2.txt > J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Class2.sort.txt
perl /code/level.uniq.pl J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Class2.sort.txt
perl /code/join.level.uniq.pl J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Class2.sort.txt.uniq.txt J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Class.txt Class
perl /code/identify.num_of_object.pl J.join.Class.uniq.txt
perl /code/quantitative_strength_of_the_relationship.level.pl J.join.Class.uniq.txt.N.disease.of.micrbobe.txt J.join.Class.uniq.txt J.join.Class.uniq.txt.total.num.disease.txt
cat fiber.Class.quantitative.txt J.join.Class.uniq.txt.quantitative_strength_of_the_relationship.txt > zx.fiber.disease.Class.txt
perl /code/change.info.to.heatmap.type.pl zx.fiber.disease.Class.txt > zx.fiber.disease.Class.change.txt

##Phylum 
sort J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Phylum2.txt > J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Phylum2.sort.txt
perl /code/level.uniq.pl J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Phylum2.sort.txt
perl /code/join.level.uniq.pl J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Phylum2.sort.txt.uniq.txt J.disease.gt3.Z.20dim.only.gut.num.txt.heatmap.up.down.txt.Phylum.txt Phylum
perl /code/identify.num_of_object.pl J.join.Phylum.uniq.txt
perl /code/quantitative_strength_of_the_relationship.level.pl J.join.Phylum.uniq.txt.N.disease.of.micrbobe.txt J.join.Phylum.uniq.txt J.join.Phylum.uniq.txt.total.num.disease.txt
cat fiber.Phylum.quantitative.txt J.join.Phylum.uniq.txt.quantitative_strength_of_the_relationship.txt > zx.fiber.disease.Phylum.txt
perl /code/change.info.to.heatmap.type.pl zx.fiber.disease.Phylum.txt > zx.fiber.disease.Phylum.change.txt


#4.3 Calculation weighted consine simialrity 
Rscript /code/Fiber-to-Disease-netwrok/02.calculation.R

##weight
perl /code/join.fiber-disease.weight-cosine.pl zx.fiber-disease.S.weigth.txt zx.fiber-disease.G.weigth.txt zx.fiber-disease.F.weigth.txt zx.fiber-disease.O.weigth.txt zx.fiber-disease.C.weigth.txt zx.fiber-disease.P.weigth.txt weight
mv J.join.level.weight.all.txt zx.level.weight.all.txt

perl /code/join.fiber-disease.weight-cosine.pl zx.fiber-disease.S_consin.txt zx.fiber-disease.G_consin.txt zx.fiber-disease.F_consin.txt zx.fiber-disease.O_consin.txt zx.fiber-disease.C_consin.txt zx.fiber-disease.P_consin.txt cosine
mv J.join.level.cosine.all.txt zx.level.cosine.all.txt

#计cosine and z score
perl /code/final.cosine.zvalue.pl zx.level.cosine.all.txt zx.level.weight.all.txt 
perl /code/change.info.to.heatmap.type.pl zx.level.cosine.all.txt.add.weight.txt > zx.level.cosine.all.txt.add.weight.change.txt
perl /code/change.info.to.heatmap.type.pl zx.level.cosine.all.txt.zvalue.txt > zx.level.cosine.all.txt.zvalue.change.txt

#P-value
Rscript  /code/Fiber-to-Disease-netwrok/03.pvalue.R
awk '$3<0' zx.level.cosine.all.txt.zvalue.txt > zx.level.cosine.all.txt.zvalue_2.txt
Rscript  /code/Fiber-to-Disease-netwrok/04.zvalue.R
perl /code/change.negative.pvalue.pl zx.level.cosine.all.txt.zvalue_2.p.txt zx.level.final.Pvalue.txt 
perl /code/change.info.to.heatmap.type.pl zx.level.final.Pvalue.txt.final.txt > zx.level.final.Pvalue.txt.final.change.txt
#FDR
Rscript  /code/Fiber-to-Disease-netwrok/05.zvalue.R

#edges
awk '$3<0.05' zx.level.FDR.txt > zx.level.FDR.select.0.05.txt
perl /code/cal.net.value.pl zx.level.cosine.all.txt.add.weight.txt 0 > zx.level.cosine.all.txt.add.weight.net.0.txt
perl /code/net.sig.pl zx.level.FDR.select.0.05.txt zx.level.cosine.all.txt.add.weight.net.0.txt 

#UC_CD
grep 'Crohns_Disease' zx.level.cosine.all.txt.add.weight.net.0.txt.only.P.sign.txt > Crohns_Disease_Ulcerative_Colitis.fiber.only.P.sign.txt 
grep 'Ulcerative_Colitis' zx.level.cosine.all.txt.add.weight.net.0.txt.only.P.sign.txt >> Crohns_Disease_Ulcerative_Colitis.fiber.only.P.sign.txt 



#Unified with 20dim diseases name
mkdir -p /data/Output_FD.network/Network_R
cd /data/Output_FD.network/Network_R

ln -s /data/Output_disease.network/J.join.level.consin.all.txt.filter.20min.ID2.161.txt ./
ln -s ../zx.level.cosine.all.txt.add.weight.net.0.txt.all.P.value.txt
perl /code/change.ID.to.20dim.pl J.join.level.consin.all.txt.filter.20min.ID2.161.txt zx.level.cosine.all.txt.add.weight.net.0.txt.all.P.value.txt > zx.level.cosine.all.txt.add.weight.net.0.txt.all.P.value.txt.20dim.txt

ln -s ../zx.level.cosine.all.txt.add.weight.net.0.txt.only.P.sign.txt ./
perl /code/change.ID.to.20dim.pl J.join.level.consin.all.txt.filter.20min.ID2.161.txt zx.level.cosine.all.txt.add.weight.net.0.txt.only.P.sign.txt > zx.level.cosine.all.txt.add.weight.net.0.txt.only.P.sign.txt.20dim.txt

#nodes
ln -s ../zx.filter.Node.txt ./
ln -s /data/Output_disease.network/J_dimension20_161.txt.finder.ID.txt.system.txt ./
perl /code/FD.change.node.to.R.pl J.join.level.consin.all.txt.filter.20min.ID2.161.txt J_dimension20_161.txt.finder.ID.txt.system.txt zx.filter.Node.txt

#edges
perl /code/FD.change.edges.to.R.pl J.join.level.consin.all.txt.filter.20min.ID2.161.txt zx.level.cosine.all.txt.add.weight.net.0.txt.only.P.sign.txt

#dietary guidance
perl /code/fiber.disease.advice.pl zx.level.cosine.all.txt.add.weight.net.0.txt.only.P.sign.txt.20dim.txt > zx.level.cosine.all.txt.add.weight.net.0.txt.only.P.sign.txt.advice.txt
cp  zx.level.cosine.all.txt.add.weight.net.0.txt.only.P.sign.txt.advice.txt /results/Dietary-Fiber-Intake-Recommendations.txt

#FD: order ID
cd /data/Output_FD.network/

perl /code/change.consinID.to.20dim.ID.pl ../Output_disease.network/J.join.level.consin.all.txt.filter.20min.ID2.161.txt zx.level.cosine.all.txt.add.weight.txt > zx.level.cosine.all.txt.add.weight.20dim.txt
awk '{gsub(/_/, " "); print $0}' zx.level.cosine.all.txt.add.weight.20dim.txt > zx.level.cosine.all.txt.add.weight.20dim2.txt
cp ../Output_fiber.network/fiber.ID.class.txt ./
cp ../Output_disease.network/J_dimension20_161.txt.finder.ID.txt.system.Order2.txt ./ 
cut -f 2 zx.level.cosine.all.txt.add.weight.20dim2.txt | sort | uniq > zx.level.cosine.all.txt.add.weight.txt.123disese.ID.txt
awk '{gsub(/_/, " "); print $0}' zx.level.cosine.all.txt.add.weight.txt.123disese.ID.txt > zx.level.cosine.all.txt.add.weight.txt.123disese.ID2.txt
perl /code/123.diesese.ID.order.pl zx.level.cosine.all.txt.add.weight.txt.123disese.ID2.txt J_dimension20_161.txt.finder.ID.txt.system.Order2.txt > 123.disease.ID.order.txt
perl /code/FD.heatmap.ID.order.pl fiber.ID.class.txt 123.disease.ID.order.txt zx.level.cosine.all.txt.add.weight.20dim2.txt > zx.level.cosine.all.txt.add.weight.20dim2.order.change.txt

#FDR
perl /code/change.consinID.to.20dim.ID.pl ../Output_disease.network/J.join.level.consin.all.txt.filter.20min.ID2.161.txt zx.level.FDR.txt > zx.level.FDR.20dim.txt
awk '{gsub(/_/, " "); print $0}' zx.level.FDR.20dim.txt > zx.level.FDR.20dim.2.txt
perl /code/FD.heatmap.ID.order.pl fiber.ID.class.txt 123.disease.ID.order.txt zx.level.FDR.20dim.2.txt > zx.level.FDR.20dim2.change.order.txt

grep -w 'Inulin' zx.level.cosine.all.txt.add.weight.20dim2.txt > zx.level.cosine.all.txt.add.weight.20dim2.Inulin.AXOS.txt
grep -w 'AXOS' zx.level.cosine.all.txt.add.weight.20dim2.txt >> zx.level.cosine.all.txt.add.weight.20dim2.Inulin.AXOS.txt 

grep -w 'Crohns Disease' zx.level.cosine.all.txt.add.weight.20dim2.txt > zx.level.cosine.all.txt.add.weight.20dim2.CD.UC.txt
grep -w 'Ulcerative Colitis' zx.level.cosine.all.txt.add.weight.20dim2.txt >> zx.level.cosine.all.txt.add.weight.20dim2.CD.UC.txt 
grep -w 'IBS' zx.level.cosine.all.txt.add.weight.20dim2.txt > zx.level.cosine.all.txt.add.weight.20dim2.IBS.txt 
cat zx.level.cosine.all.txt.add.weight.20dim2.CD.UC.txt zx.level.cosine.all.txt.add.weight.20dim2.IBS.txt > zx.level.cosine.all.txt.add.weight.20dim2.CD.UC.IBS.txt 







