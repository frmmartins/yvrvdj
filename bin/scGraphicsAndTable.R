library(ggplot2)
library(dplyr)
 
#setwd("/media/fabio/E0AA993DAA9910E0/backup-E-22112021/analise-gnomad-aut/vcfs/resultgroupvcfs/")

setwd('C:/backup-E-22112021/analise-gnomad-aut/vcfs/resultgroupvcfs/')



tbVcfD = as.data.frame(read.csv("resultTotalVcfGroupDetailGENCODEDREGION.csv", sep=";", dec=",", header = TRUE))
tbVcfD$countGenomeExome <- tbVcfD$allelecountgenome+tbVcfD$allelecountexome
 
tbVcfD <- mutate(tbVcfD, id = row_number())
tbVcfD <- mutate(tbVcfD, faixa = "G1") 

#Faixas  
#1 - 241
tbVcfD$faixa[tbVcfD$countGenomeExome == 1] <- "G1"

#count(subset(tbVcfD, tbVcfD$faixa == "G1"))

#2-6 - 199
tbVcfD$faixa[tbVcfD$countGenomeExome > 1 & tbVcfD$countGenomeExome <= 6] <- "G2"

#7-18 - 37
tbVcfD$faixa[tbVcfD$countGenomeExome > 6 & tbVcfD$countGenomeExome <= 18] <- "G3"

#>18 - 47
tbVcfD$faixa[tbVcfD$countGenomeExome > 18] <- "G4"

#241+199+37+47

#========================================================================
# Gene J
tbVcfJ = as.data.frame(read.csv("resultTotalVcfGroupDetailGENCODEJREGION.csv", sep=";", dec=",", header = TRUE))

tbVcfJ$countGenomeExome <- tbVcfJ$allelecountgenome+tbVcfJ$allelecountexome

tbVcfJ <- mutate(tbVcfJ, id = row_number())
tbVcfJ <- mutate(tbVcfJ, faixa = "G1") 

#Faixas  
#1 -  187
tbVcfJ$faixa[tbVcfJ$countGenomeExome == 1] <- "G1"

#count(subset(tbVcfD, tbVcfD$faixa == "G1"))

#2-6 -312
tbVcfJ$faixa[tbVcfJ$countGenomeExome > 1 & tbVcfJ$countGenomeExome <= 6] <- "G2"

#7-18 - 123
tbVcfJ$faixa[tbVcfJ$countGenomeExome > 6 & tbVcfJ$countGenomeExome <= 18] <- "G3"

#>18 - 48
tbVcfJ$faixa[tbVcfJ$countGenomeExome > 18] <- "G4"

#187+312+123+48 = 670



#========================================================================
# Ghaphics gene D
#========================================================================
tbDPerGene = as.data.frame(read.csv("groupGeneCountGenomeExomeGENCODEDREGION.csv", sep=";", dec=",", header = TRUE))
tbDPerGene$countTotal <- tbDPerGene$countgenome+tbDPerGene$countexome

#tbDPerGene <- tbDPerGene[order(tbDPerGene$countTotal, decreasing=TRUE),]

#IGHD7-27	106331761
#IGHD1-26	106346892
#IGHD6-25	106347397
#IGHD3-22	106351889
#IGHD2-21	106354409
#IGHD1-20	106357049
#IGHD6-19	106357557
#IGHD5-18	106359400
#IGHD4-17	106360366
#IGHD3-16	106361492
#IGHD2-15	106363815
#IGHD6-13	106367000
#IGHD5-12	106368507
#IGHD3-10	106370355
#IGHD3-9	106370539
#IGHD2-8	106373069
#IGHD1-7	106375766
#IGHD6-6	106376269
#IGHD5-5	106378116
#IGHD4-4	106379081
#IGHD3-3	106380218
#IGHD2-2	106382685
#IGHD1-1	106385361

tbDPerGene$order <- 0

#tbDPerGene$order[tbDPerGene$gene == IGHD7-27] <- 0
tbDPerGene$order[tbDPerGene$gene == "IGHD1-26"] <- 1
tbDPerGene$order[tbDPerGene$gene == "IGHD6-25"] <- 2
tbDPerGene$order[tbDPerGene$gene == "IGHD3-22"] <- 3
tbDPerGene$order[tbDPerGene$gene == "IGHD2-21"] <- 4
tbDPerGene$order[tbDPerGene$gene == "IGHD1-20"] <- 5
tbDPerGene$order[tbDPerGene$gene == "IGHD6-19"] <- 6
tbDPerGene$order[tbDPerGene$gene == "IGHD5-18"] <- 7
tbDPerGene$order[tbDPerGene$gene == "IGHD4-17"] <- 8
tbDPerGene$order[tbDPerGene$gene == "IGHD3-16"] <- 9
tbDPerGene$order[tbDPerGene$gene == "IGHD2-15"] <- 10
tbDPerGene$order[tbDPerGene$gene == "IGHD6-13"] <- 11
tbDPerGene$order[tbDPerGene$gene == "IGHD5-12"] <- 12
tbDPerGene$order[tbDPerGene$gene == "IGHD3-10"] <- 13
tbDPerGene$order[tbDPerGene$gene == "IGHD3-9"] <- 14
tbDPerGene$order[tbDPerGene$gene == "IGHD2-8"] <- 15
tbDPerGene$order[tbDPerGene$gene == "IGHD1-7"] <- 16
tbDPerGene$order[tbDPerGene$gene == "IGHD6-6"] <- 17
tbDPerGene$order[tbDPerGene$gene == "IGHD5-5"] <- 18
tbDPerGene$order[tbDPerGene$gene == "IGHD4-4"] <- 19
tbDPerGene$order[tbDPerGene$gene == "IGHD3-3"] <- 20
tbDPerGene$order[tbDPerGene$gene == "IGHD2-2"] <- 21
tbDPerGene$order[tbDPerGene$gene == "IGHD1-1"] <- 22


tiff('graphicsBarGeneD-600dpi-18x22.tiff', units="cm", width=18.0, height=22.0, res=600, compression = 'lzw')

ggplot(tbDPerGene, aes(x=reorder(gene, order), y=countTotal, label = countTotal)) +
  geom_col() +
  theme_classic() +
  labs(title = "", x = "IGHD gene name", y = "Number of variants") +
  scale_y_continuous(breaks = c(0,20,40,55), labels = c("0", "20", "40", "55")) +
  geom_text(aes(y = countTotal, label = countTotal), size = 2.5, position = position_stack(vjust = 0.5), colour = "white") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 9.0)) +
  theme(axis.text.y = element_text(size = 9.0)) +
  theme(axis.title.x = element_text(size = 9),
        axis.title.y = element_text(size = 9)) +
  theme(panel.background = element_blank())

dev.off()  


#========================================================================
# Ghaphics gene J
#========================================================================
tbJPerGene = as.data.frame(read.csv("groupGeneCountGenomeExomeGENCODEJREGION.csv", sep=";", dec=",", header = TRUE))
tbJPerGene$countTotal <- tbJPerGene$countgenome+tbJPerGene$countexome

#tbJPerGene <- tbJPerGene[order(tbJPerGene$countTotal, decreasing=TRUE),]

#IGHJ6	106329406
#IGHJ5	106330022
#IGHJ4	106330423
#IGHJ3	106330795
#IGHJ2	106331407
#IGHJ1	106331615

tbJPerGene$order <- 0

tbJPerGene$order[tbJPerGene$gene == "IGHJ6"] <- 1
tbJPerGene$order[tbJPerGene$gene == "IGHJ5"] <- 2
tbJPerGene$order[tbJPerGene$gene == "IGHJ4"] <- 3
tbJPerGene$order[tbJPerGene$gene == "IGHJ3"] <- 4
tbJPerGene$order[tbJPerGene$gene == "IGHJ2"] <- 5
tbJPerGene$order[tbJPerGene$gene == "IGHJ1"] <- 6


tiff('graphicsBarGeneJ-600dpi-18x22.tiff', units="cm", width=18.0, height=22.0, res=600, compression = 'lzw')

ggplot(tbJPerGene, aes(x=reorder(gene, order), y=countTotal, label = countTotal)) +
  geom_col() +
  theme_classic() +
  labs(title = "", x = "IGHJ gene name", y = "Number of variants") +
  scale_y_continuous(breaks = c(0,50,100,150, 190), labels = c("0", "50", "100", "150", "190")) +
  geom_text(aes(y = countTotal, label = countTotal), size = 2.5, position = position_stack(vjust = 0.5), colour = "white") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 9.0)) +
  theme(axis.text.y = element_text(size = 9.0)) +
  theme(axis.title.x = element_text(size = 9),
        axis.title.y = element_text(size = 9)) +
  theme(panel.background = element_blank())

dev.off()  

  
  
  










