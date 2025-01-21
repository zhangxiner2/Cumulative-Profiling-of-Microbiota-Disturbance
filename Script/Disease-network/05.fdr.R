#set environment
setwd("/data/Output_disease.network/")

p<-read.table("J.join.level.final.Pvalue.txt.final.change.txt", sep = "\t", header = TRUE, row.names = 1)
ds<-p
t1<-colnames(ds)
c<-rep(t1[1], times=dim(ds)[1])

t<-ds[,1]
for (i in 2:dim(ds)[1]){
	        t2<-ds[,i]
        dt<-c(1:i)
	        t2<-as.matrix(t2)
	        t3<-t2[-dt,]
		        t<-append(t,t3)

		        c2<-rep(t1[i], times=length(t3))
			        c<-append(c,c2)

			        t1<-as.matrix(t1)
				        c1<-t1[-dt,]
				        if (i==2){
						        T1<-append(t1, c1)
					        }
					        if (i>2){
							        T1<-append(T1, c1)
						        }
}
net<-cbind(T1,c,t)
net<-net[-1,]
dim(net)
write.table(net, "J.join.level.final.Pvalue.txt.final.single.txt", quote= F, sep = '\t', col.name=F, row.name=F)



#adjust P value: FDR
p<-read.table("J.join.level.final.Pvalue.txt.final.single.txt", sep = "\t")
t<-p.adjust(p$V3, method = "BH")
fdr<- cbind(as.matrix(p$V1), as.matrix(p$V2), as.matrix(t))
write.table(fdr, "J.join.level.final.Pvalue.txt.final.FDR.single.txt", quote = FALSE, row.names = FALSE, col.names = FALSE, sep = "\t")
