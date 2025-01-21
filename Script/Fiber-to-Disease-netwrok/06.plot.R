#set environment
setwd("/data/Output_FD.network/")
dir.create("/results/FD-network")
library(ggplot2)
library(pheatmap)
#热图
# only gut data : 123 diseases , 32 fiber
FD<-read.table("zx.level.cosine.all.txt.add.weight.20dim2.order.change.txt", header = T, row.names = 1, sep = "\t")
annotation_col <- read.table("123.disease.ID.order.txt", sep = "\t", row.names = 1, header = F)
annotation_row <-read.table("fiber.ID.class.txt", header = F, row.names = 1,sep="\t")
colnames(FD) <- rownames(annotation_col)
row.names(FD) <-rownames(annotation_row)
colnames(annotation_row) <- c("Class")
colnames(annotation_col) <- c("System")

#P
P<-read.table("zx.level.FDR.20dim2.change.order.txt", sep ="\t", header = T, row.names = 1)
colnames(P) <- rownames(annotation_col)
row.names(P) <-rownames(annotation_row)
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
ggsave("/results/FD-network/FD.heatmap.pdf")
P1<-pheatmap(FD, cluster_rows = T, cluster_cols = T, color = colorRampPalette(c("navy", "white", "firebrick3"))(100), fontsize = 7, annotation_row = annotation_row, annotation_col = annotation_col, fontsize_col = 8, fontsize_row = 8, legend_labels = 10,  show_rownames = T, display_numbers = pmt, border_color = "grey60")
ggsave(P1, filename="/results/FD-network/FD.heatmap.pdf")

###density
ggsave("/results/FD-network/FD.density.pdf")
FDc<-read.table("zx.level.cosine.all.txt.add.weight.20dim2.txt", sep = "\t", header = F)
colnames(FDc)<-c("ID1", "ID2", "Similarity")
P2<-ggplot(FDc, aes(x=Similarity)) + geom_density(color = "plum3",fill = "thistle3", alpha=0.5, lwd = 1.2)+ geom_vline(xintercept = mean(FDc[,3]), linetype = "dashed") + xlab("Similarity")+ ylab("Density") + theme_classic() + annotate("text", x= 0.2, y = 6, label = "Mean= 0.004", size = 8) +  theme(axis.text = element_text(size = 20), legend.text = element_text(size = 20), text = element_text(size = 20))
ggsave(P2, filename="/results/FD-network/FD.density.pdf")


#AXOS and Inulin
ggsave("/results/FD-network/IA.density.pdf")
IA<-read.table("zx.level.cosine.all.txt.add.weight.20dim2.Inulin.AXOS.txt", sep = "\t", header = F)
IA[,4] <- c(rep("Inulin", 123), rep("AXOS", 123))
colnames(IA)<-c("ID1", "ID2", "Similarity", "Group") 
P3<-ggplot(IA, aes(x=Similarity, fill = Group)) + geom_density(alpha=0.5) + xlab("Similarity")+ ylab("Density") + theme_classic() + theme(legend.position = "top", axis.text = element_text(size = 25), legend.text = element_text(size = 25), text = element_text(size = 25)) +  geom_vline(xintercept = median(tail(IA[,3],123)), linetype = "dashed", col = "lightcoral")  + geom_vline(xintercept = median(head(IA[,3],123)), linetype = "dashed", col = "cyan4")  + annotate("text", x= -0.18, y = 4.6, label = "Median= -0.005", size = 7, col = "lightcoral") +  annotate("text", x= 0.15, y = 4.6, label = "Median= -0.0002", size = 7, col = "#20B2AA")
ggsave(P3, filename="/results/FD-network/IA.density.pdf")


#UC and CD
ggsave("/results/FD-network/T3.density.pdf")
 
T3<-read.table("zx.level.cosine.all.txt.add.weight.20dim2.CD.UC.IBS.txt ", sep = "\t", header = F)
T3[,4] <- c(rep("Crohns Disease", 32), rep("Ulcerative Colitis", 32), rep("IBS", 32))
colnames(T3)<-c("ID1", "ID2", "Similarity", "Group") 
mean(subset(T3, T3$Group == "Crohns Disease")[,3])
mean(subset(T3, T3$Group == "Ulcerative Colitis")[,3])
mean(subset(T3, T3$Group == "IBS")[,3])
P4<-ggplot(T3, aes(x=Similarity, fill = Group)) + geom_density(alpha=0.5) + xlab("Similarity")+ ylab("Density") + theme_classic() + theme(legend.position = "top", axis.text = element_text(size = 20), legend.text = element_text(size = 20), text = element_text(size = 20))+ geom_vline(xintercept = median(subset(T3, T3$Group == "Crohns Disease")[,3]), linetype = "dashed", col = "lightcoral")  + geom_vline(xintercept = median(subset(T3, T3$Group == "IBS")[,3]), linetype = "dashed", col = "cyan4") +  geom_vline(xintercept = median(subset(T3, T3$Group == "Ulcerative Colitis")[,3]), linetype = "dashed", col = "#6495ED") + annotate("text", x= 0.03, y = 3.8, label = "Median= -0.01", size = 6, col = "lightcoral") +  annotate("text", x= -0.1, y = 3.5, label = "Median= -0.02", size = 6, col = "#20B2AA") +  annotate("text", x= 0.06, y = 3, label = "Median= 0.007", size = 6, col = "#6495ED")
ggsave(P4, filename="/results/FD-network/T3.density.pdf")


