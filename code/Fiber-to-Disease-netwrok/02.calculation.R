## set environment
setwd("/data/Output_FD.network/")
library(Hmisc)
library(lsa)

S<-read.table("zx.fiber-disease.species.change.txt", sep = "\t", header = T, row.names = 1)
S<-as.matrix(S)
Y<-cosine(S)
p<-rcorr(S)$P
Y1<-Y[1:11,12:91]
p1<-p[1:11,12:91]
p1[p1== 0.0000000] <- 2.2e-16
p1[p1==1] <- 0.999999
z<-qt(p1/2, df = dim(S)[1]-1,lower.tail = FALSE)
x<-Y1/z
w_S<-1/(x*x)
w_S[w_S==Inf]<-2.2e-16

G<-read.table("zx.fiber.disease.Genu.change.txt", sep = "\t", header = T, row.names = 1)
G<-as.matrix(G)
Y<-cosine(G)
p<-rcorr(G)$P
Y2<-Y[1:32,33:155]
p2<-p[1:32,33:155]
p2[p2== 0.0000000] <- 2.2e-16
p2[p2==1] <- 0.999999
z<-qt(p2/2, df = dim(S)[1]-1,lower.tail = FALSE)
x<-Y2/z
w_G<-1/(x*x)
w_G[w_G==Inf]<-2.2e-16

F<-read.table("zx.fiber.disease.Family.change.txt", sep = "\t", header = T, row.names = 1)
F<-as.matrix(F)
Y<-cosine(F)
p<-rcorr(F)$P
Y3<-Y[1:32,33:155]
p3<-p[1:32,33:155]
p3[p3== 0.0000000] <- 2.2e-16
p3[p3==1] <- 0.999999
z<-qt(p3/2, df = dim(F)[1]-1,lower.tail = FALSE)
x<-Y3/z
w_F<-1/(x*x)
w_F[w_F==Inf]<-2.2e-16

O<-read.table("zx.fiber.disease.Order.change.txt", sep = "\t", header = T, row.names = 1)
O<-as.matrix(O)
Y<-cosine(O)
p<-rcorr(O)$P
Y4<-Y[1:32,33:155]
p4<-p[1:32,33:155]
p4[p4== 0.0000000] <- 2.2e-16
p4[p4==1] <- 0.999999
z<-qt(p4/2, df = dim(O)[1]-1,lower.tail = FALSE)
x<-Y4/z
w_O<-1/(x*x)
w_O[w_O==Inf]<-2.2e-16

C<-read.table("zx.fiber.disease.Class.change.txt", sep = "\t", header = T, row.names = 1)
C<-as.matrix(C)
Y<-cosine(C)
p<-rcorr(C)$P
Y5<-Y[1:32,33:155]
p5<-p[1:32,33:155]
p5[p5== 0.0000000] <- 2.2e-16
p5[p5==1] <- 0.999999
z<-qt(p5/2, df = dim(C)[1]-1,lower.tail = FALSE)
x<-Y5/z
w_C<-1/(x*x)
w_C[w_C==Inf]<-2.2e-16

P<-read.table("zx.fiber.disease.Phylum.change.txt", sep = "\t", header = T, row.names = 1)
P<-as.matrix(P)
Y<-cosine(P)
p<-rcorr(P)$P
Y6<-Y[1:32,33:155]
p6<-p[1:32,33:155]
p6[p6== 0.0000000] <- 2.2e-16
p6[p6==1] <- 0.999999
z<-qt(p6/2, df = dim(F)[1]-1,lower.tail = FALSE)
x<-Y6/z
w_P<-1/(x*x)
w_P[w_P==Inf]<-2.2e-16
###########################

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
write.table(net, "zx.fiber-disease.S.weigth.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

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
write.table(net, "zx.fiber-disease.G.weigth.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

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
write.table(net, "zx.fiber-disease.F.weigth.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

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
write.table(net, "zx.fiber-disease.O.weigth.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

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
write.table(net, "zx.fiber-disease.C.weigth.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

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
write.table(net, "zx.fiber-disease.P.weigth.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

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
write.table(net, "zx.fiber-disease.S_consin.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

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
write.table(net, "zx.fiber-disease.G_consin.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

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
write.table(net, "zx.fiber-disease.F_consin.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

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
write.table(net, "zx.fiber-disease.O_consin.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

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
write.table(net, "zx.fiber-disease.C_consin.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)


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
write.table(net, "zx.fiber-disease.P_consin.txt", sep = '\t',quote = FALSE, row.names = FALSE, col.names = FALSE)

