#set environment
setwd("/data/Output_disease.network/")
#top10 info
dir.create("/results/Disease-network")
library(ggplot2)

ggsave("/results/Disease-network/Top10.microbe.pdf")
t<- read.table("J.disease.gt3.num.txt.microbe.info.top10.txt")
P1<-ggplot(t,aes(x=V1, y=V2))+geom_bar(position="dodge",stat="identity",fill="lightskyblue")+ ylab("Publication evidence") + coord_flip()+theme(axis.text.x = element_blank(),panel.background = element_blank(), axis.text.y = element_text(size =9), axis.title.y = element_blank(),axis.title.x  =element_text(size = 8),axis.ticks=element_blank())+geom_text(aes(x=V1, y=V2, label=V2), position=position_dodge(width=0.9),size=3)
ggsave(P1, filename="/results/Disease-network/Top10.microbe.pdf")

## 2. top 10 disease 
ggsave("/results/Disease-network/Top10.disease.pdf")
t<- read.table("J.disease.gt3.num.txt.disease.info.top10.txt", sep = "\t")
library(RColorBrewer)    
cc<-brewer.pal(name = "Set3",10) # 10：bar num
P2<-ggplot(t,aes(x=V1,y=V2,fill=V1))+geom_bar(position="dodge",stat="identity") + ylab("Publication evidence") +theme(axis.text.y = element_blank(),axis.ticks=element_blank(), panel.background = element_blank())+geom_text(aes(x=V1, y= V2, label=V2), position=position_dodge(width=0.9)) +scale_fill_manual(values = cc)+guides(fill= "none")+ coord_flip()
ggsave(P2, filename="/results/Disease-network/Top10.disease.pdf")


#3. Top 50 microbe
library("ggplot2")

ggsave("/results/Disease-network/Disease-dataset.distribution.pdf")
t<-read.table("J.disease.gt3.num.txt.heatmap.up.down.txt.bar.txt", header = T, sep = "\t")
t$sum<-rowSums(t[,2:3])
t1<-head(t[order(t$sum, decreasing = TRUE),], 50)
t2<-t1[,-4]
write.table(t1, "J.disease.gt3.num.txt.heatmap.up.down.bar.top50.txt", quote= F, sep = '\t', col.name=T, row.name=F)
library(reshape2)
df<-melt(t2)
P3<-ggplot(df, aes(x=reorder(Item, -value), y=ifelse(variable=="Increase", value, -value), fill = variable))+geom_bar(stat = "identity")+coord_flip()+scale_y_continuous(labels = abs, expand = expansion(mult = c(0.1,0.1)))+ylab("Evidence count")+ xlab("Microbe_type") + theme_classic() + theme(axis.text.y = element_text(size =6),axis.title.y  = element_blank()) 
ggsave(P3, filename="/results/Disease-network/Disease-dataset.distribution.pdf")



#4.top50 Prevotella
ggsave("/results/Disease-network/Prevotella.distribution.pdf")
t_P<-read.table("J.disease.gt3.num.txt.heatmap.up.down.Prevotella.top50.bar.txt", header = T, sep = "\t")
df<-melt(t_P)
P4<-ggplot(df, aes(x=factor(Item,levels = unique(Item)), y=ifelse(variable=="Increase", value, -value), fill = variable))+geom_bar(stat = "identity")+coord_flip()+scale_y_continuous(labels = abs, expand = expansion(mult = c(0.1,0.1)))+ylab("Frequency of evidence")+ xlab("Microbe_type") + theme_classic() + theme(axis.text.y = element_text(size =6),axis.title.y  = element_blank())
ggsave(P4, filename="/results/Disease-network/Prevotella.distribution.pdf")

#5.画聚类图
#挑选group，画聚类图
# 加载R包, 按照这个流程，聚类结果和pheatmap结果一致
library("ggtree")
library("lsa")
library("ape")
library("ggplot2")

ggsave("/results/Disease-network/M-cluster.distribution.pdf")
d<-read.table("J.join.level.consin.all.txt.filter.20min.ID2.change.txt", sep = "\t", header = T, row.names = 1)
diag(d)<-1
tree<-hclust(dist(d))
d_tree<-as.phylo(tree)
group_file <- read.table("J_dimension20.txt.finder.txt.system.txt",header = TRUE,sep = "\t")
groupInfo <- split(group_file$ID, group_file$Class)
d_tree <- groupOTU(d_tree, groupInfo)
P5<-ggtree(d_tree, layout="fan", ladderize = FALSE, branch.length = "none",aes(color=group)) +xlim(NA,23) + geom_tiplab2(size=2.5) + theme(legend.position = "right")
ggsave(P5, filename = "/results/Disease-network/M-cluster.distribution.pdf")

#6. 20dim data
ggsave("/results/Disease-network/J-cluster.distribution.pdf")
J<-read.table("J_dimension20.txt.finder.txt", sep = "\t", header = T, row.names = 1)
Js<-cosine(t(J))
tree<-hclust(dist(Js))
J_tree<-as.phylo(tree)
group_file <- read.table("J_dimension20.txt.finder.txt.system.txt",header = TRUE,sep = "\t")
groupInfo <- split(group_file$ID, group_file$Class)
J_tree <- groupOTU(J_tree, groupInfo)
P6<-ggtree(J_tree, layout="fan", ladderize = FALSE, branch.length = "none",aes(color=group)) +xlim(NA,16) + geom_tiplab2(size=2.5) + theme(legend.position = "right")
ggsave(P6, filename = "/results/Disease-network/J-cluster.distribution.pdf")



##7. heatmap
library(lsa)
library(pheatmap)
library(RColorBrewer)
library(reshape2)
annotation_row <-read.table("J_dimension20_161.txt.finder.ID.txt.system.Order.txt", header = F, row.names = 1,sep="\t")
J20dim<-read.table("J_dimension20_161.txt.finder.cosine.similarity.20dim.order.change2.txt", header = T, row.names = 1, sep ="\t")
row.names(annotation_row) <-rownames(J20dim)
colnames(J20dim) = rownames(J20dim)
colnames(annotation_row) <- c("System")
#pheatmap(J20dim, cluster_rows = T, cluster_cols = T, color = colorRampPalette(c("navy", "white", "firebrick3"))(100), fontsize = 7, annotation_row = annotation_row, annotation_col = annotation_row,   fontsize_col = 7, fontsize_row = 7, legend_labels = 10, clustering_method = "complete", show_rownames = T)
out<-pheatmap(J20dim, cluster_rows = T, cluster_cols = T, color = colorRampPalette(c("navy", "white", "firebrick3"))(100), fontsize = 7, annotation_row = annotation_row, annotation_col = annotation_row,   fontsize_col = 7, fontsize_row = 7, legend_labels = 10, clustering_method = "complete", show_rownames = T)
#得到聚类的ID号
rowJ20cluster<-rownames(J20dim[out$tree_row[["order"]],])
write.table(rowJ20cluster,file='rowJ20cluster.txt', row.names=F, col.names = F, quote=F)

#20dim-based和microbe-based data整合为1个不对称的matrix
A<-J20dim
M<-read.table("J.join.level.cosine.all.txt.add.weight.20dim.order.change2.txt", header = T, row.names = 1, sep = "\t")
A[upper.tri(A)]<- M[upper.tri(M)]
diag(A)<-0
#pheatmap(A, cluster_rows = F, cluster_cols = F, color = colorRampPalette(c("navy", "white", "firebrick3"))(100), fontsize = 7, show_colnames = T, border_color = NA, scale = "row", show_rownames = T, annotation_row = annotation_row, annotation_col = annotation_row)


###M聚类热图
M<-read.table("J.join.level.cosine.all.txt.add.weight.20dim.order.change2.txt", header = T, row.names = 1, sep = "\t")
row.names(annotation_row) <-rownames(M)
colnames(M) = rownames(M)
colnames(annotation_row) <- c("System")
#pheatmap(M, cluster_rows = T, cluster_cols = T, color = colorRampPalette(c("navy", "white", "firebrick3"))(100), fontsize = 7, annotation_row = annotation_row, annotation_col = annotation_row,   fontsize_col = 7, fontsize_row = 7, legend_labels = 10, clustering_method = "complete", show_rownames = T)

##Deta value 趋势图
A<-J20dim
Deta<-A-M

ds<-Deta
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
write.table(net, "J20dim-Microbe-Deta.single.txt", quote= F, sep = '\t', col.name=F, row.name=F)

ggsave("/results/Disease-network/Deta-density.pdf")
t<-read.table("J20dim-Microbe-Deta.single.txt", sep = "\t", header = F)
P7<-ggplot(t, aes(x=V3)) + geom_density(color = "plum3",fill = "thistle3", alpha=0.5, lwd = 1.2)+ geom_vline(xintercept = median(t[,3]), linetype = "dashed") + xlab("Difference in etiology-based and microbiota-based data")+ ylab("Density") + theme_classic() + annotate("text", x= -0.2, y = 1.7, label = "Median= -0.01", size = 15) +  theme(axis.text = element_text(size = 25), legend.text = element_text(size = 25), text = element_text(size = 25))
ggsave(P7, filename="/results/Disease-network/Deta-density.pdf")

#### plot  一个折线图显示两个数据各自的趋势
A<-J20dim
ds<-A
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
write.table(net, "J_dimension20_161.txt.finder.cosine.similarity.single.txt", quote= F, sep = '\t', col.name=F, row.name=F)

ds<-M
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
write.table(net, "J.join.level.cosine.all.txt.add.weight.single.txt", quote= F, sep = '\t', col.name=F, row.name=F)

ggsave("/results/Disease-network/J-m.density.pdf")
 J20<-read.table("J_dimension20_161.txt.finder.cosine.similarity.single.txt", sep = "\t", header = F)
 M20<-read.table("J.join.level.cosine.all.txt.add.weight.single.txt", sep = "\t", header = F)
 J20[,2] <- c(rep("20dim-based data", 12880))
 M20[,2] <- c(rep("Microbe-based data", 12880))
 t<-rbind(J20, M20)
 colnames(t)<-c("ID", "Group", "Similarity")
 
P8<-ggplot(t, aes(x=Similarity, fill = Group)) + geom_density(alpha=0.5) + xlab("Similarity")+ ylab("Density") + theme_classic() + theme(legend.position = "top", axis.text = element_text(size = 20), legend.text = element_text(size = 20), text = element_text(size = 20)) + geom_vline(xintercept = 0.012, linetype = "dashed", col = "cyan4")  + geom_vline(xintercept = 0.02, linetype = "dashed", col = "lightcoral") + annotate("text", x= -0.35, y = 7.5, label = "Median= 0.014", size = 8, col = "lightcoral") +  annotate("text", x= 0.35, y = 7.5, label = "Median= 0.001", size = 8, col = "#20B2AA")
ggsave(P8, filename="/results/Disease-network/J-m.density.pdf")



############################### 
###按照J20dim聚类的ID排序M聚类


##plot heatmap
annotation_row <-read.table("rowJ20cluster.sys.ID.txt", header = F, row.names = 1,sep="\t")
M<-read.table("J.join.level.cosine.all.txt.add.weight.20dim.order.change.txt.rowJ20.txt", header = T, row.names = 1, sep = "\t")
row.names(annotation_row) <-rownames(M)
colnames(M) = rownames(M)
colnames(annotation_row) <- c("System")
#pheatmap(M, cluster_rows = T, cluster_cols = T, color = colorRampPalette(c("navy", "white", "firebrick3"))(100), fontsize = 7, annotation_row = annotation_row, annotation_col = annotation_row,   fontsize_col = 7, fontsize_row = 7, legend_labels = 10, clustering_method = "complete", show_rownames = T)

J<-read.table("J_dimension20_161.txt.finder.cosine.similarity.20dim.order.change.txt.rowJ20.txt", header = T, row.names = 1, sep = "\t")
row.names(annotation_row) <-rownames(J)
colnames(J) = rownames(J)
colnames(annotation_row) <- c("System")
#pheatmap(J, cluster_rows = T, cluster_cols = T, color = colorRampPalette(c("navy", "white", "firebrick3"))(100), fontsize = 7, annotation_row = annotation_row, annotation_col = annotation_row,   fontsize_col = 7, fontsize_row = 7, legend_labels = 10, clustering_method = "complete", show_rownames = T)

#20dim-based和microbe-based data整合为1个不对称的matrix
AJ<-J
AJ[upper.tri(AJ)]<- M[upper.tri(M)]
diag(AJ)<-0
#pheatmap(AJ, cluster_rows = F, cluster_cols = F, color = colorRampPalette(c("navy", "white", "firebrick3"))(100), fontsize = 7, show_colnames = T, border_color = NA, scale = "row", show_rownames = T, annotation_row = annotation_row, annotation_col = annotation_row)
ggsave("/results/Disease-network/J-M.heatmap.pdf")
###增加M色度
diag(J) <-0
M<-as.matrix(M)
diag(M)<-0
M[M<(-0.1)] <--0.4
M[M>0.1] <-0.4
A<-J
A[upper.tri(A)]<- M[upper.tri(M)]
diag(A)<-0
P9<-pheatmap(A, cluster_rows = F, cluster_cols = F, color = colorRampPalette(c("mediumblue", "white", "red1"))(100), fontsize = 7, show_colnames = T, border_color = NA, scale = "row", show_rownames = T, annotation_row = annotation_row, annotation_col = annotation_row)
ggsave(P9, filename = "/results/Disease-network/J-M.heatmap.pdf")



###########Deta
MJdeta<- J-M
ds<-MJdeta
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
write.table(net, "J-M.deta.single.txt", quote= F, sep = '\t', col.name=F, row.name=F)

ggsave("/results/Disease-network/Deta.density.pdf")
t<-read.table("J-M.deta.single.txt", sep = "\t", header = F)
P10<-ggplot(t, aes(x=V3)) + geom_density(color = "plum3",fill = "thistle3", alpha=0.5, lwd = 1.2)+ geom_vline(xintercept = median(t[,3]), linetype = "dashed",size = 1) + xlab("Difference in etiology-based and microbe-based data")+ ylab("Density") + theme_classic() + annotate("text", x= -0.2, y = 1.7, label = "Median= -0.01", size = 10) +  theme(axis.text = element_text(size = 20), legend.text = element_text(size = 20), text = element_text(size = 20))
ggsave(P10, filename="/results/Disease-network/Deta.density.pdf")



# 计算disease 存在pos的情况，并绘图

 setwd("/data/Output_disease.network/pos.Dir/")
library(ggplot2)

t<-read.table("All.45.pos.info.txt", sep = "\t", header = T)
library(reshape2)
df<-melt(t)
ggplot(df, aes(x=reorder(ID, -value), y=ifelse(variable=="N_disease", value, -value), fill = variable))+geom_bar(stat = "identity")+coord_flip()+scale_y_continuous(labels = abs, expand = expansion(mult = c(0.1,0.1)))+theme_classic()+ylab("")+ xlab("")+geom_text(aes(label=value, hjust = ifelse(variable == "N_disease", -1,1)), size = 4)+ theme(axis.text.y  = element_text(size =14))



#disturbace score  of GI 

GI<- read.table("GI.disturbance.score.txt", sep = "\t")
hh<-hist(x= GI$V3, breaks = 40)
plot(hh, col = "#69b3a2", border = "white", xlab = "Disturbance score of GI", ylab = "Counts of disease type", xlim = c(30, 80), ylim = c(0, 12), labels = F, main = "", cex.axis = 1.1, cex.lab = 1.1) + text(40, 3, "Autism", srt = 90, cex = 0.9) + text(50.5, 3.2, "Crohns_Disease", srt = 90, cex = 0.9) + text(52.4, 6, "Eating_Disorder", srt = 90, cex = 0.8)+ text(53.5, 7.5, "Food_Allergy", srt = 90, cex = 0.8) + text(55.5, 6, "General_Hypertension", srt = 90, cex = 0.9)+ text(61, 9.5, "IBS", srt = 90, cex = 0.9) + text(75, 2.5, "T2D", srt = 90, cex = 0.9)+ text(76.5, 5.5, "Ulcerative_Colitis", srt = 90, cex = 0.9)



#plot Tpo5 disturbace score 

score<-read.table("Top5.disturbace.score.change2.txt", sep = "\t", header = T)
#公用x轴
ggplot(score, aes(x=Disease, y=DS, group = POS, color = POS))+ geom_point()+ geom_line() + facet_wrap(~ POS, nrow = 5, scales = "free_y") + theme_gray() + theme(panel.grid.major = element_line(colour = NA), panel.grid.minor = element_blank(),axis.text = element_text(colour = "#000000" ,size = 8), axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5,size = 7.5), legend.position = "none") + xlab("") + ylab("Disturbance Score")


# pos to score of disease

h20<-read.table("All.29.pos.disturbace.score.disease_to_pos.head20.txt",sep = "\t")
ggplot(h20, aes(x = reorder(V1, V2), y=V2))+ geom_bar(position = "dodge", stat = "identity", fill= "#69b3a2")+coord_flip()+ylab("Num_of_body.sites")+xlab("")+geom_text(aes(x=V1, y=V2, label = V2), position = position_dodge(width = 0.9))+theme(panel.background = element_blank(), axis.text.y  = element_text(size = 15), axis.title.x = element_text(size = 15))+scale_y_discrete(position = "right")



#### three node loops
library(ggplot2)
library(ggbreak) 

setwd("/data/Output_disease.network/Loop_dir/")
ggsave("/results/Disease-network/Three.nodes.pdf")

f<-read.table("/data/Output_disease.network/Loops_dir/disease.ratio.txt", sep = "\t")
P14<-ggplot(f, aes(x = V1))+geom_density(color = "#69b3a2",lwd = 1,linetype = 2,fill="#69b3a2",alpha=0.5,adjust=1.75)+annotate("text", x = 1.26, y = 50, label = "Observed=1.26", size=5) + xlab("Ratio of coherent loops to incoherent loops in fiber network")+ ylab("Probability density")+ annotate("text", x = 1.01, y = 150, label = "Mean=1.01", size=5)+theme(axis.title.x= element_text(size = 13), axis.title.y = element_text(size = 13), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.text = element_text(size = 12)) + theme_classic()  +  geom_vline(xintercept = 1.01, linetype = "dashed", size = 0.8)+ scale_x_break(c(1.02, 1.2), space = 0.3, scales  = 0.5)+annotate("segment",x = 1.26, xend = 1.26, y = 50, yend = 0, colour = "#66CC66", linetype="solid",size=1)
ggsave(P14, filename="/results/Disease-network/Three.nodes.pdf")



###########################
#Correlation
#set environment

setwd("/data/Output_disease.network/Correlation")

d<-read.table("161.disease.combine.txt", sep = "\t")
Hepatic<-read.table("Hepatic.info.txt", sep = "\t")
Reproductive<-read.table("Reproductive.info.txt", sep = "\t")
Musculoskeletal<-read.table("Musculoskeletal.info.txt", sep = "\t")
Endocrine<-read.table("Endocrine.info.txt", sep = "\t")
Neuropsychiatric<-read.table("Neuropsychiatric.info.txt", sep = "\t")
Digestive<-read.table("Digestive.info.txt", sep = "\t")
CNS<-read.table("CNS.info.txt", sep = "\t")
Respiratory<-read.table("Respiratory.info.txt", sep = "\t")
Non.Specific<-read.table("Non-Specific.info.txt", sep = "\t")
Neoplastic_Process<-read.table("Neoplastic_Process.info.txt", sep = "\t")
Cardiovascular<-read.table("Cardiovascular.info.txt", sep = "\t")
Immune<-read.table("Immune.info.txt", sep = "\t")
Infectious_Disease<-read.table("Infectious_Disease.info.txt", sep = "\t")
Metabolic<-read.table("Metabolic.info.txt", sep = "\t")
Ophthalmological<- read.table("Ophthalmological.info.txt", sep = "\t")
Hematologic<-read.table("Hematologic.info.txt", sep = "\t")
Integumentary<-read.table("Integumentary.info.txt", sep = "\t")
Urinary<-read.table("Urinary.info.txt", sep = "\t")
Development<-read.table("Development.info.txt", sep = "\t")

cor.test(d$V3,d$V4)
#19 systems
par(mfrow=c(4,5))
smoothScatter(d$V3, d$V4,xlab="Microbe-based disease",ylab="20Dim-based disease", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(d$V3, d$V4), 3), " Padj=5.5e-16", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Hepatic$V3, Hepatic$V4,xlab="Microbe-based Hepatic",ylab="20Dim-based Hepatic", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Hepatic$V3, Hepatic$V4), 3), " Padj=5.5e-16", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Musculoskeletal$V3, Musculoskeletal$V4,xlab="Microbe-based Musculoskeletal",ylab="20Dim-based Musculoskeletal", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Musculoskeletal$V3, Musculoskeletal$V4), 3), " Padj=3.43e-09", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Reproductive$V3, Reproductive$V4,xlab="Microbe-based Reproductive",ylab="20Dim-based Reproductive", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Reproductive$V3, Reproductive$V4), 3), " Padj=3.12e-06", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Respiratory$V3, Respiratory$V4,xlab="Microbe-based Respiratory",ylab="20Dim-based Respiratory", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Respiratory$V3, Respiratory$V4), 3), " Padj=8.36e-13", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Digestive$V3, Digestive$V4,xlab="Microbe-based Digestive",ylab="20Dim-based Digestive", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Digestive$V3, Digestive$V4), 3), " Padj=5.50e-16", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Neuropsychiatric$V3, Neuropsychiatric$V4,xlab="Microbe-based Neuropsychiatric",ylab="20Dim-based Neuropsychiatric", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Neuropsychiatric$V3, Neuropsychiatric$V4), 3), " Padj=5.50e-16", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Cardiovascular$V3, Cardiovascular$V4,xlab="Microbe-based Cardiovascular",ylab="20Dim-based Cardiovascular", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Cardiovascular$V3, Cardiovascular$V4), 3), " Padj=5.50e-16", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Endocrine$V3, Endocrine$V4,xlab="Microbe-based Endocrine",ylab="20Dim-based Endocrine", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Endocrine$V3, Endocrine$V4), 3), " Padj=1.22e-08", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Neoplastic_Process$V3, Neoplastic_Process$V4,xlab="Microbe-based Neoplastic_Process",ylab="20Dim-based Neoplastic_Process", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Neoplastic_Process$V3, Neoplastic_Process$V4), 3), " Padj=5.50e-16", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(CNS$V3, CNS$V4,xlab="Microbe-based CNS",ylab="20Dim-based CNS", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(CNS$V3, CNS$V4), 3), " Padj=1.68e-09", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Hematologic$V3, Hematologic$V4,xlab="Microbe-based Hematologic",ylab="20Dim-based Hematologic", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Hematologic$V3, Hematologic$V4), 3), " Padj=5.43e-08", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Immune$V3, Immune$V4,xlab="Microbe-based Immune",ylab="20Dim-based Immune", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Immune$V3, Immune$V4), 3), " Padj=5.50e-16", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Infectious_Disease$V3, Infectious_Disease$V4,xlab="Microbe-based Infectious_Disease",ylab="20Dim-based Infectious_Disease", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Infectious_Disease$V3, Infectious_Disease$V4), 3), " Padj=5.50e-16", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Ophthalmological$V3, Ophthalmological$V4,xlab="Microbe-based Ophthalmological",ylab="20Dim-based Ophthalmological", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Ophthalmological$V3, Ophthalmological$V4), 3), " Padj=1.11e-04", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Metabolic$V3, Metabolic$V4,xlab="Microbe-based Metabolic",ylab="20Dim-based Metabolic", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Metabolic$V3, Metabolic$V4), 3), " Padj=1.24e-06", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Integumentary$V3, Integumentary$V4,xlab="Microbe-based Integumentary",ylab="20Dim-based Integumentary", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Integumentary$V3, Integumentary$V4), 3), " Padj=3.88e-11", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Non.Specific$V3, Non.Specific$V4,xlab="Microbe-based Non.Specific",ylab="20Dim-based Non.Specific", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Non.Specific$V3, Non.Specific$V4), 3), " Padj=0.069", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Urinary$V3, Urinary$V4,xlab="Microbe-based Urinary",ylab="20Dim-based Urinary", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Urinary$V3, Urinary$V4), 3), " Padj=1.20e-05", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Development$V3, Development$V4,xlab="Microbe-based Development",ylab="20Dim-based Development", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Development$V3, Development$V4), 3), " Padj=1.71e-05", sep=" "), cex = 1, adj = 1, font = 0.1)

#2个systems + total 
par(mfrow = c(3,1))
smoothScatter(d$V3, d$V4,xlab="Microbe-based disease",ylab="20Dim-based disease", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(d$V3, d$V4), 3), " Padj=5.5e-16", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Hepatic$V3, Hepatic$V4,xlab="Microbe-based Hepatic",ylab="20Dim-based Hepatic", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Hepatic$V3, Hepatic$V4), 3), " Padj=5.5e-16", sep=" "), cex = 1, adj = 1, font = 0.1)
smoothScatter(Development$V3, Development$V4,xlab="Microbe-based Development",ylab="20Dim-based Development", nbin = 1000) + text(0.8,0.9, paste("R=", round(cor(Development$V3, Development$V4), 3), " Padj=1.71e-05", sep=" "), cex = 1, adj = 1, font = 0.1)






