setwd("/data/Output_fiber.network/")

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

p<-read.table("J.join.level.final.Pvalue.txt.final.single.txt", sep = "\t", header = FALSE)
t<-p.adjust(p$V3, method = "BH")
fdr<-cbind(as.matrix(p$V1),as.matrix(p$V2),as.matrix(t))
write.table(fdr, "J.join.level.final.Pvalue.txt.final.FDR.single.txt", quote = FALSE, sep = "\t", row.names = FALSE, col.names = FALSE)


P<-read.table("J.join.level.final.Pvalue.txt.final.FDR.change.txt", sep ="\t", header = T, row.names = 1)
ds<-P
t1<-colnames(ds)
t2<-rownames(ds)
T1<-rep(t2, times=dim(ds)[2])
t<-ds[,1]
c<-rep(t1[1], times=dim(ds)[1])
for (i in 2:dim(ds)[2]){
    tt<-ds[,i]
    t<-append(t,tt)
    c2<-rep(t1[i], times=dim(ds)[1])
    c<-append(c,c2)
}
net<-cbind(T1,c,t)
write.table(net, "J.join.level.final.Pvalue.txt.final.FDR.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)





