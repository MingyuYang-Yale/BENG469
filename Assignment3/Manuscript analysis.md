## Manuscript analysis

(https://github.com/bowmanr/scDNA_myeloid/tree/master/data)
```
cp /gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV/data/*.rds ./data
```
### Figure 1: Cohort characterization

#### Open R:
```
R
```
```
install.packages('farver')
install.packages('cooccur')
```

```
# load R packages

library('farver')
library(dplyr)
library(tidyr)
library(ggplot2)
library(cooccur)
```
```
setwd("/gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV")
final_NGTs<-readRDS(file="./data/final_NGTs.rds")
pheno<-readRDS(file="./data/pheno.rds")
```
```
#exclude samples <100 cells.

high_quality_samples<-names(final_NGTs)[sapply(names(final_NGTs),function(x){
  nrow(final_NGTs[[x]])>100
})]
```
```
#catalogue of all mutations so you can determine how many patients were mutated for each gene and how many different mutations were seen in total for each gene.

final_mut_melt<-do.call(rbind,lapply(names(final_NGTs),function(x){
  data.frame("Sample"=x,
             "Mutation"=colnames(final_NGTs[[x]]),
             "Gene"=do.call(rbind,strsplit(colnames(final_NGTs[[x]]),split="[:_]"))[,1])
      }))
```
```
# Extended Figure 1.
# Set the levels of the Gene column from most to least prevalent for plotting purposes

final_mut_melt$Gene<- factor(final_mut_melt$Gene,levels=names(sort(table(final_mut_melt$Gene), decreasing=TRUE)))

gg_mut_count<-ggplot(final_mut_melt,aes(x=Gene))+
                        geom_bar(stat="count")+
                        theme_classic(base_size = 10)+
                        ylab("Count")+
                        ggtitle("Number of mutations")+
                        theme(axis.text.x = element_text(angle=45, hjust=1,vjust=1),
                              plot.title=element_text(hjust=0.5))+
                        scale_y_continuous(expand=c(0,0))
                        
ggsave("mut_count.pdf",width=6,height=5)
```
```
# Total number of patients mutated for each gene
## tally of how many mutations per patient
melted_mut_mat<- final_mut_melt%>%count(Gene, Sample)

## Set the levels of the Gene column from most to least prevalent for plotting purposes
melted_mut_mat$Gene<- factor(melted_mut_mat$Gene,levels=names(sort(table(melted_mut_mat$Gene),decreasing=TRUE)))

gg_mut_patient<-ggplot(melted_mut_mat,aes(x=Gene))+
                      geom_bar(stat="count")+
                      theme_classic(base_size =10)+
                      ylab("Count")+ggtitle("Number of patients with mutation")+
                      theme(axis.text.x = element_text(angle=45,hjust=1,vjust=1),
                            plot.title=element_text(hjust=0.5))+
                          scale_y_continuous(expand=c(0,0))
ggsave("mut_patient.pdf",width=6,height=5)
```
```
# Number of mutated genes per patient
gg_mutated_genes_per_patient<-final_mut_melt%>%
                                          distinct(Sample,Gene)%>%
                                          group_by(Sample)%>%
                                          tally%>%
                                          ggplot(aes(x=n))+geom_bar()+
                                          ylab("Count")+
                                          xlab("Number of genes")+
                                          ggtitle("Mutant genes per patient")+
                                          theme_classic(base_size = 10)+
                                          theme(plot.title=element_text(hjust=0.5))+
                                          scale_y_continuous(expand=c(0,0))+
                                          scale_x_continuous(expand=c(0,0))
ggsave("mutated_genes_per_patient.pdf",width=6,height=5)
```
```
# Total number of mutations per patient
gg_mutations_per_patient<- final_mut_melt%>%
                                        group_by(Sample)%>%
                                        tally%>%
                                        ggplot(aes(x=n))+geom_bar()+
                                        theme_classic(base_size = 10)+
                                        theme(plot.title=element_text(hjust=0.5))+
                                        ylab("Count")+ggtitle("Variants per patient")+xlab("Number of variants")+                              
                                        scale_y_continuous(expand=c(0,0))+
                                        scale_x_continuous(expand=c(0,0))
ggsave("mutations_per_patient.pdf",width=6,height=5)
```
```
# library(cowplot)
# merge=plot_grid(gg_mut_count,gg_mut_patient,
#           gg_mutated_genes_per_patient,gg_mutations_per_patient,
#           ncol=2,align="hv",axis="ltrb",
#           labels = "AUTO")
# ggsave("mutations_stats.pdf",width=8,height=5)
```
