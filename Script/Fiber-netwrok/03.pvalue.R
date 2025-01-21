setwd("/data/Output_fiber.network/")

z<-read.table("J.join.level.cosine.all.txt.zvalue.change.txt", sep = "\t", header = T, row.names = 1)
z<-as.matrix(z)
p<-pt(z, df=dim(z)[1]-1,lower.tail = FALSE)

ds<-p
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
write.table(net, "J.join.level.final.Pvalue.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

