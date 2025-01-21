#set environment
setwd("/data/Output_fiber.network/")

#1. plot head10 microbe info.
t<- read.table("/data/Output_fiber.network/fiber_raw.database.microbe.info.txt.head10")
library(ggplot2)
ggplot(t,aes(x=V1, y=V2))+geom_bar(position="dodge",stat="identity",fill="lightskyblue")+ ylab("Publication evidence") + coord_flip()+theme(axis.text.x = element_blank(),panel.background = element_blank(), axis.text.y = element_text(size =9), axis.title.y = element_blank(),axis.title.x  =element_text(size = 8),axis.ticks=element_blank())+geom_text(aes(x=V1, y=V2, label=V2), position=position_dodge(width=0.9),size=3)

#2. plot head11 fiber info.
t<- read.table("/data/Output_fiber.network/fiber_raw.database.fiber.info.txt.head11")
library(RColorBrewer)    
cc<-brewer.pal(name = "Set3",11) # 11：bar num
ggplot(t,aes(x=V1,y=V2,fill=V1))+geom_bar(position="dodge",stat="identity")+ xlab("") + ylab("Publication evidence") +theme(axis.text.y = element_blank(),axis.ticks=element_blank(), panel.background = element_blank())+geom_text(aes(x=V1, y= V2, label=V2), position=position_dodge(width=0.9)) +scale_fill_manual(values = cc)+guides(fill= "none")

#3. filter gt.3's data distribution
t<-read.table("fiber_raw.uniq.ano.num.txt.heatmap.up.down.bar.txt", header = T, sep = "\t")
library(reshape2)
df<-melt(t)
ggplot(df, aes(x=factor(Item,levels = unique(Item)), y=ifelse(variable=="Increase", value, -value), fill = variable))+geom_bar(stat = "identity")+coord_flip()+scale_y_continuous(labels = abs, expand = expansion(mult = c(0.1,0.1)))+ylab("Frequency of evidence")+ xlab("Microbe_type") + theme_classic() + theme(axis.text.y = element_text(size =6),axis.title.y  = element_blank())



##4.plot hotmap
library(pheatmap)
p<-read.table("J.join.level.final.Pvalue.txt.final.FDR.change.txt", sep = "\t", header = T, row.names = 1)
pmt<-p
if (!is.null(pmt)){
    ssmt <- pmt< 0.01
    pmt[ssmt] <-'*'
    smt <- pmt >0.01& pmt <0.05
    pmt[smt] <- '*'
    pmt[!ssmt&!smt]<- ''
} else {
    pmt <- F
}

f<-read.table("J.join.level.cosine.all.txt.add.weight.change.txt", sep = "\t", header = T, row.names = 1)
f<-as.matrix(f)


col1 = colorRampPalette(c( "#006400","white", "#8B008B"))(200)
library(corrplot)
corrplot( f,type= "lower", tl.col= "black", is.corr= FALSE, diag = FALSE,method= "color", col= col1, tl.cex = 1.1, cl.cex= 0.9, cl.ratio = 0.1, p.mat = as.matrix(p), insig = c("label_sig"), sig.level = c(0.05) , pch.cex = 0.8)



#5. plot cluster
library("ggtree")
library("lsa")
library("ape")
library("ggplot2")
d_tree<-hclust(dist(f))
#d_tree<-hclust(dist(f), method = "ward.D2")
#聚类结果转化为系统发育格式， newick格式文件
tree<-as.phylo(d_tree)
#geom_text(aes(label=node)) 显示结点
ggtree(tree, layout="circular", ladderize = FALSE, branch.length = "none") + geom_tiplab2(size=2, offset=0.1)+geom_text(aes(label=node))
#给结点加颜色
ggtree(tree, layout="circular", ladderize = FALSE, branch.length = "none")+ geom_tiplab2(size=6, offset=0.3) +geom_highlight(node = 38, fill="yellow")+geom_highlight(node = 42, fill="#E377c2FF")+geom_highlight(node = 43, fill="#98DF8AFF")+geom_highlight(node = 36, fill="red")+geom_highlight(node = 40, fill="#1F77B4FF")+geom_highlight(node = 41, fill="#F08080")+xlim(NA,10)


#6. three-node-loops distrubution
library(ggplot2)
library(ggpubr)

f<-read.table("/data/Output_fiber.network/Loops_dir/fiber.ratio.txt", sep = "\t")
ggplot(f, aes(x = V1))+geom_density(color = "#69b3a2",lwd = 1,linetype = 2,fill="#69b3a2",alpha=0.5,adjust=1.75)+annotate("segment",x = 1.51, xend = 1.51, y = 2, yend = 0, colour = "#66CC66", linetype="solid",size=1)+annotate("text", x = 1.51, y = 2, label = "Observed:1.51", size=5) + xlab("Ratio of coherent loops to Incoherent loops in fiber network")+ ylab("Probability density")+ annotate("text", x = 1.11, y = 13, label = "Mean:1.11", size=5)+theme(axis.title.x= element_text(size = 13), axis.title.y = element_text(size = 13), panel.grid.major = element_blank(),panel.grid.minor = element_blank(), axis.text = element_text(size = 12))


