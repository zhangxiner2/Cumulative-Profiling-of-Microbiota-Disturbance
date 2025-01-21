#4.3 计算相似性和权重
#根据这个gt.3 的结果，进一步优化weight和计算P value
#优化依据：P值越小（越显著），权重就要越大，加权的占比也就变大啦。
setwd("/data/Output_fiber.network/")

library(Hmisc)
library(lsa)

S<-read.table("J.join.Species.uniq.txt.quantitative_strength_of_the_relationship.change.txt", sep = "\t", header = T, row.names = 1)
S<-as.matrix(S)
Y1<-cosine(S)
p<-rcorr(S)$P
p[p== 0.0000000] <- 2.2e-16
p[p==1] <- 0.999999
z<-qt(p/2, df = dim(S)[1]-1,lower.tail = FALSE)
x<-Y1/z
w_S<-1/(x*x)
w_S[w_S==Inf]<-2.2e-16

G<-read.table("J.join.Genu.uniq.txt.quantitative_strength_of_the_relationship.change.txt", sep = "\t", header = T, row.names = 1)
G<-as.matrix(G)
Y2<-cosine(G)
p<-rcorr(G)$P
p[p== 0.0000000] <- 2.2e-16
p[p==1] <- 0.999999
z<-qt(p/2, df = dim(S)[1]-1,lower.tail = FALSE)
x<-Y2/z
w_G<-1/(x*x)
w_G[w_G==Inf]<-2.2e-16

F<-read.table("J.join.Family.uniq.txt.quantitative_strength_of_the_relationship.change.txt", sep = "\t", header = T, row.names = 1)
F<-as.matrix(F)
Y3<-cosine(F)
p<-rcorr(F)$P
p[p== 0.0000000] <- 2.2e-16
p[p==1] <- 0.999999
z<-qt(p/2, df = dim(F)[1]-1,lower.tail = FALSE)
x<-Y3/z
w_F<-1/(x*x)
w_F[w_F==Inf]<-2.2e-16

O<-read.table("J.join.Order.uniq.txt.quantitative_strength_of_the_relationship.change.txt", sep = "\t", header = T, row.names = 1)
O<-as.matrix(O)
Y4<-cosine(O)
p<-rcorr(O)$P
p[p== 0.0000000] <- 2.2e-16
p[p==1] <- 0.999999
z<-qt(p/2, df = dim(O)[1]-1,lower.tail = FALSE)
x<-Y4/z
w_O<-1/(x*x)
w_O[w_O==Inf]<-2.2e-16

C<-read.table("J.join.Class.uniq.txt.quantitative_strength_of_the_relationship.change.txt", sep = "\t", header = T, row.names = 1)
C<-as.matrix(C)
Y5<-cosine(C)
p<-rcorr(C)$P
p[p== 0.0000000] <- 2.2e-16
p[p==1] <- 0.999999
z<-qt(p/2, df = dim(C)[1]-1,lower.tail = FALSE)
x<-Y5/z
w_C<-1/(x*x)
w_C[w_C==Inf]<-2.2e-16

P<-read.table("J.join.Phylum.uniq.txt.quantitative_strength_of_the_relationship.change.txt", sep = "\t", header = T, row.names = 1)
P<-as.matrix(P)
Y6<-cosine(P)
p<-rcorr(P)$P
p[p== 0.0000000] <- 2.2e-16
p[p==1] <- 0.999999
z<-qt(p/2, df = dim(F)[1]-1,lower.tail = FALSE)
x<-Y6/z
w_P<-1/(x*x)
w_P[w_P==Inf]<-2.2e-16

##4.4 保存权重文件
ds<-w_S
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
write.table(net, "J.join.S.weigth.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

ds<-w_G
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
write.table(net, "J.join.G.weigth.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

ds<-w_F
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
write.table(net, "J.join.F.weigth.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

ds<-w_O
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
write.table(net, "J.join.O.weigth.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

ds<-w_C
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
write.table(net, "J.join.C.weigth.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

ds<-w_P
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
write.table(net, "J.join.P.weigth.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

#4.5 保存相似性文件
ds<-Y1
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
write.table(net, "J.join.S_consin.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

ds<-Y2
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
write.table(net, "J.join.G_consin.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

ds<-Y3
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
write.table(net, "J.join.F_consin.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

ds<-Y4
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
write.table(net, "J.join.O_consin.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

ds<-Y5
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
write.table(net, "J.join.C_consin.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

ds<-Y6
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
write.table(net, "J.join.P_consin.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)
