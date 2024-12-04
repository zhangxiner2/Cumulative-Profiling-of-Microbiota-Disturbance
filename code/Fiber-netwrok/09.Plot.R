#set environment
setwd("/data/Output_fiber.network/")
dir.create("/results/Fiber-network")
library(ggplot2)

#1. plot head10 microbe info.
t<- read.table("/data/Output_fiber.network/fiber_raw.database.microbe.info.txt.head10")
ggsave("/results/Fiber-network/Top10.microbe.pdf")
P1<-ggplot(t,aes(x=V1, y=V2))+geom_bar(position="dodge",stat="identity",fill="lightskyblue")+ ylab("Publication evidence") + coord_flip()+theme(axis.text.x = element_blank(),panel.background = element_blank(), axis.text.y = element_text(size =9), axis.title.y = element_blank(),axis.title.x  =element_text(size = 8),axis.ticks=element_blank())+geom_text(aes(x=V1, y=V2, label=V2), position=position_dodge(width=0.9),size=3)
ggsave(P1, filename="/results/Fiber-network/Top10.microbe.pdf")

#2. plot head11 fiber info.
ggsave("/results/Fiber-network/Top11.fiber.pdf")
t<- read.table("/data/Output_fiber.network/fiber_raw.database.fiber.info.txt.head11")
library(RColorBrewer)    
cc<-brewer.pal(name = "Set3",11) # 11：bar num
P2<-ggplot(t,aes(x=V1,y=V2,fill=V1))+geom_bar(position="dodge",stat="identity")+ xlab("") + ylab("Publication evidence") +theme(axis.text.y = element_blank(),axis.ticks=element_blank(), panel.background = element_blank())+geom_text(aes(x=V1, y= V2, label=V2), position=position_dodge(width=0.9)) +scale_fill_manual(values = cc)+guides(fill= "none")
ggsave(P2, filename = "/results/Fiber-network/Top11.fiber.pdf")

##per.fiber.microbe.num.txt
ggsave("/results/Fiber-network/fiber.to.microbe.num.pdf")
t<-read.table("per.fiber.microbe.num.txt", sep = "\t")
P22<-ggplot(t,aes(reorder(V1,V2), V2))+geom_bar(position="dodge",stat="identity",fill="lightskyblue")+ ylab("Publication evidence") + coord_flip()+theme(axis.text.x = element_blank(),panel.background = element_blank(), axis.text.y = element_text(size =9), axis.title.y = element_blank(),axis.title.x  =element_text(size = 8),axis.ticks=element_blank())+geom_text(aes(x=V1, y=V2, label=V2), position=position_dodge(width=0.9),size=3) + ylab("Microbe Frequency") + scale_y_discrete(position = "top")
ggsave(P22, filename = "/results/Fiber-network/fiber.to.microbe.num.pdf")


#3. filter gt.3's data distribution
ggsave("/results/Fiber-network/Fiber-dataset.distribution.pdf")
t<-read.table("fiber_raw.uniq.ano.num.txt.heatmap.up.down.bar.txt", header = F, sep = "\t")
library(reshape2)
colnames(t) = c("Item", "Increase", "Decrease")
df<-melt(t)
P3<-ggplot(df, aes(x=reorder(Item, -value), y=ifelse(variable=="Increase", value, -value), fill = variable))+geom_bar(stat = "identity")+coord_flip()+scale_y_continuous(labels = abs, expand = expansion(mult = c(0.1,0.1)))+ylab("Evidence count")+ xlab("Microbe_type") + theme_classic() + theme(axis.text.y = element_text(size =6),axis.title.y  = element_blank()) + ylim(-11, 50)
ggsave(P3, filename="/results/Fiber-network/Fiber-dataset.distribution.pdf")

ggplot(df, aes(x=reorder(Item, value), y=ifelse(variable=="Increase", value, -value), fill = variable))+geom_bar(stat = "identity")+coord_flip()+scale_y_continuous(labels = abs, expand = expansion(mult = c(0.1,0.1)))+ylab("Frequency of evidence")+ xlab("Microbe_type") + theme_classic() + theme(axis.text.y = element_text(size =6),axis.title.y  = element_blank()) + ylim(-5,60)

##4.plot hotmap
library(ggplot2)
library(pheatmap)
library(RColorBrewer)
ggsave("/results/Fiber-network/Fiber.heatmap.pdf")
#plot heatmap
annotation_row <-read.table("fiber.ID.class2.txt", header = F, row.names = 1,sep="\t")

Fiber<-read.table("J.join.level.cosine.all.txt.add.weight.order.change.txt", header = T, row.names = 1, sep ="\t")
colnames(Fiber) = rownames(Fiber)
row.names(annotation_row) <-rownames(Fiber)
colnames(annotation_row) <- c("Class")

P<-read.table("J.join.level.final.Pvalue.txt.final.FDR.order.change.txt", sep ="\t", header = T, row.names = 1)
pmt<-P
if (!is.null(pmt)){
    ssmt <- pmt< 0.01
    pmt[ssmt] <-'*'
    smt <- pmt >0.01& pmt <0.05
    pmt[smt] <- '*'
    pmt[!ssmt&!smt]<- ''
} else {
    pmt <- F
}

P4<-pheatmap(Fiber, cluster_rows = T, cluster_cols = T, color = colorRampPalette(c("navy", "white", "firebrick3"))(100), fontsize = 7, annotation_row = annotation_row, annotation_col = annotation_row,  cutree_rows = 6, cutree_cols = 6, fontsize_col = 12, fontsize_row = 12, legend_labels = 10, clustering_method = "complete", show_rownames = T, display_numbers = pmt)
ggsave(P4, filename="/results/Fiber-network/Fiber.heatmap.pdf")


#5. plot cluster
library("ggtree")
library("lsa")
library("ape")
library("ggplot2")
ggsave("/results/Fiber-network/Fiber.cluster.pdf")
d_tree<-hclust(dist(Fiber))  
#d_tree<-hclust(dist(f), method = "ward.D2")

tree<-as.phylo(d_tree)
#geom_text(aes(label=node)) 
ggtree(tree, layout="circular", ladderize = FALSE, branch.length = "none") + geom_tiplab2(size=2, offset=0.1)+geom_text(aes(label=node))

P5<-ggtree(tree, layout="circular", ladderize = FALSE, branch.length = "none")+ geom_tiplab2(size=6, offset=0.3) +geom_highlight(node = 38, fill="yellow")+geom_highlight(node = 42, fill="#E377c2FF")+geom_highlight(node = 43, fill="#98DF8AFF")+geom_highlight(node = 36, fill="red")+geom_highlight(node = 40, fill="#1F77B4FF")+geom_highlight(node = 41, fill="#F08080")+xlim(NA,10)
ggsave(P5, filename="/results/Fiber-network/Fiber.cluster.pdf")

#6. similarity distribution
library(ggplot2)
ggsave("/results/Fiber-network/Fiber.similarity.distribution.pdf")
##All similarity
F32<-read.table("32.fiber.J.join.level.cosine.all.txt.add.weight.single.txt", sep = "\t", header = F)
colnames(F32)<-c("ID1", "ID2", "Similarity")

P6<-ggplot(F32, aes(x=Similarity)) + geom_density(color = "plum3",fill = "thistle3", lwd = 1,linetype = 2, alpha=0.5,adjust=1.75) + xlab("Similarity")+ ylab("Density") + theme_classic() + theme(axis.text = element_text(size = 20), legend.text = element_text(size = 20), text = element_text(size = 20)) + annotate("text", x = 0.05, y = 4, label = "Mean=0.05", size=7) + geom_vline(xintercept = 0.05, linetype = "dashed") 
ggsave(P6, filename="/results/Fiber-network/Fiber.similarity.distribution.pdf")

#AXOS-Inulin 
ggsave("/results/Fiber-network/AXOS-Inulin.similarity.distribution.pdf")
AI<-read.table("32.fiber.J.join.level.cosine.all.txt.add.weight.single.AXOS-Inulin.txt", sep = "\t", header = F)
AI[,4] <- c(rep("AXOS", 31), rep("Inulin", 31))
colnames(AI)<-c("ID1", "ID2", "Similarity", "Group") 
P7<-ggplot(AI, aes(x=Similarity, fill = Group)) + geom_density(alpha=0.5) + xlab("Similarity")+ ylab("Density") + theme_classic() + theme(legend.position = "top", axis.text = element_text(size = 25), legend.text = element_text(size = 25), text = element_text(size = 25)) + geom_vline(xintercept = 0.06, linetype = "dashed", col = "lightcoral")  + geom_vline(xintercept = 0.13, linetype = "dashed", col = "cyan4")  + annotate("text", x= -0.05, y = 3.5, label = "Mean= 0.06", size = 7, col = "lightcoral") +  annotate("text", x= 0.26, y = 3.5, label = "Mean= 0.13", size = 7, col = "#20B2AA") 
ggsave(P7, filename="/results/Fiber-network/AXOS-Inulin.similarity.distribution.pdf")


#7. three-node-loops distrubution
library(ggplot2)
#library(ggpubr)
ggsave("/results/Fiber-network/Three.node.loops.pdf")
f<-read.table("/data/Output_fiber.network/Loops_dir/fiber.ratio.txt", sep = "\t")

P8<-ggplot(f, aes(x = V1))+geom_density(color = "#69b3a2",lwd = 1,linetype = 2,fill="#69b3a2",alpha=0.5,adjust=1.75)+annotate("segment",x = 1.51, xend = 1.51, y = 2, yend = 0, colour = "#66CC66", linetype="solid",size=1)+annotate("text", x = 1.51, y = 2, label = "Observed=1.51", size=5) + xlab("Ratio of coherent to incoherent")+ ylab("Probability density")+ annotate("text", x = 1.11, y = 13.5, label = "Median=1.11", size=5)+theme(axis.title.x= element_text(size = 13), axis.title.y = element_text(size = 13), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.text = element_text(size = 12)) + theme_classic()  +  geom_vline(xintercept = 1.11, linetype = "dashed")
ggsave(P8, filename="/results/Fiber-network/Three.node.loops.pdf")

