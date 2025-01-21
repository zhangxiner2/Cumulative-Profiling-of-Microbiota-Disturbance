#set environment
setwd("/data/Output_disease.network/Loops_dir")

t<- read.table("/data/Output_disease.network/J.join.level.cosine.all.txt.add.weight.change.single.txt", sep ="\t")
for (k in 1:10000){ 
	
	data = cbind(as.matrix(t[,1]),as.matrix(t[,2]), as.matrix(sample(t[,3])))
	write.table(data, file=paste("output_",k,sep=""), quote= F, sep = '\t', col.name=F, row.name=F)
}
