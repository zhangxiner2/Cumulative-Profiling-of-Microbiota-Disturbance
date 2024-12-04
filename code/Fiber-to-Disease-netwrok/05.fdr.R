setwd("/data/Output_FD.network")

p<-read.table("zx.level.final.Pvalue.txt.final.change.txt", sep = "\t", header = T, row.names = 1)
d<-p.adjust(p[,1],method = "BH")
i=2
while(i<=dim(p)[2]){
	d<-cbind(d,d<-p.adjust(p[,i],method = "BH"));
	i<-i+1
}
colnames(d)=colnames(p)
rownames(d)<-rownames(p)
write.table(d,"zx.level.FDR.change.txt", sep = "\t", quote = FALSE, row.names = TRUE, col.names = TRUE)

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
net<-cbind(c,T1,t)
write.table(net,"zx.level.FDR.txt", sep = "\t", quote = FALSE, row.names = FALSE, col.names = FALSE)


#node
node<-append(t1,t2)
s1<-rep("triangle", times=dim(ds)[2])
s2<-rep("ellipse", times=dim(ds)[1])
S<-append(s1,s2)
Node.txt<-cbind(node, S)
write.table(Node.txt, file="zx.filter.Node.txt", sep = "\t", row.names = F, col.names= F, quote= F)


