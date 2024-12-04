#set environment
setwd("/data/Output_disease.network/")


d<-read.table("J.join.level.consin.all.txt.filter.20min.ID2.change.txt", header = TRUE, sep = "\t", row.names = 1)
diag(d)<-0
ds<-d
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
write.table(net, "J.join.level.consin.all.txt.filter.20min.ID2.change.txt.bar.txt", quote= F, sep = '\t', col.name=FALSE, row.name=FALSE)

library(lsa)
d<-read.table("J_dimension20.txt.finder.txt", header = T, sep = "\t", row.names = 1)
d<-as.matrix(t(d))
dd<-cosine(d)
write.table(dd, "J_dimension20_161.txt.finder.cosine.similarity.change.txt", quote=F, sep = '\t', col.name=TRUE, row.name=TRUE)

p<-read.table("J_dimension20_161.txt.finder.cosine.similarity.change.txt", sep = "\t", header = TRUE, row.names = 1)
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

dim(net)
write.table(net, "J_dimension20_161.txt.finder.cosine.similarity.txt", quote= F, sep = '\t', col.name=F, row.name=F)

