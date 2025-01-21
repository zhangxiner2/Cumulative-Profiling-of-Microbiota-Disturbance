#推算P值
setwd("/data/Output_FD.network")
z<-read.table("zx.level.cosine.all.txt.zvalue.change.txt", sep = "\t", header = T, row.names = 1)
p<-pt(as.matrix(z),123,lower.tail = FALSE)

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
net<-cbind(c,T1,t)
write.table(net, "zx.level.final.Pvalue.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)
