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

### Mutation Co-occurence
```
### create matrix for oncoprint
mut_mat <- table(melted_mut_mat$Sample,melted_mut_mat$Gene)
```
```
### Prepare matrix for co occurence map
cooccur_mat <- cooccur(mat=t(mut_mat), type="spp_site",
                       only_effects = FALSE,eff_matrix=TRUE,
                       thresh=FALSE, eff_standard=FALSE,spp_names=TRUE)$results
```
```
## Denote which interactions are significantly inclusive or exclusive 
# The 'add_row' function generates a new line, but it gets removed later.
# This is helpful for setting the order of the gene labels below. 
cooccur_data_mat <- cooccur_mat%>%
                        mutate(score=ifelse(p_lt<=0.05,-1,
                                            ifelse(p_gt<=0.05,1,0))) %>%
                        select(sp1_name,sp2_name,score)%>%
                        add_row(sp2_name=setdiff(.$sp1_name,.$sp2_name),
                                sp1_name=setdiff(.$sp2_name,.$sp1_name),
                                score=0)
```
```
# Order the genes in a coherent pattern for triangle strucutre of graph.
cooccur_data_mat$sp1_name<-factor(cooccur_data_mat$sp1_name,
                                  levels=unique(cooccur_data_mat$sp1_name))
cooccur_data_mat$sp2_name<-factor(cooccur_data_mat$sp2_name,
                                  levels=rev(levels(cooccur_data_mat$sp1_name)))
```
```
# Triangle heatmap to compare cohorts
grob_corrplot<-ggplot(cooccur_data_mat%>%filter(sp1_name!="BRAF"),aes(x=sp1_name,y=sp2_name))+
                      geom_tile(aes(fill = factor(score)), color='grey90') +
                      scale_fill_manual(name="Correlation",
                                        values=c("-1"="firebrick3",
                                                 "0"="white",
                                                 "1"="steelblue2"),
                                        labels=c("Mutually Exclusive",
                                                 "Not Significant",
                                                 "Mutually Inclusive"))+
                      theme_classic(base_size=10)+
                      xlab("")+ylab("")+
                      theme(axis.text.x=element_text(angle=45,hjust=1,vjust=1),
                            axis.line = element_blank(),
                            legend.position = c(0.8,1), 
                            legend.justification = c(1, 1),
                            legend.direction = "vertical")+
                      theme(legend.key.size = unit(0.5,"line"))
                      
ggsave("corrplot.pdf",width=5,height=5)
```
