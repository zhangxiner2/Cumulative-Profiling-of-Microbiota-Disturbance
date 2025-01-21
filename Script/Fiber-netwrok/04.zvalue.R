setwd("/data/Output_fiber.network/")

z2<-read.table("J.join.level.cosine.all.txt.zvalue_2.txt", header=FALSE, sep = '\t')
z2<-as.matrix(z2)
t<-z2[,3]
c = matrix(nrow=dim(z2)[1], ncol=1)
for (i in 1:dim(z2)[1]){
	    tt<-pt(as.numeric(t[i]), df=32, lower.tail = TRUE)
    c[i]<-tt
}
T<-cbind(z2[,1], z2[,2], c)
write.table(T, "J.join.level.cosine.all.txt.zvlue_2.p.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)



