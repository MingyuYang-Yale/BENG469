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
# load R packages
library(dplyr)
library(tidyr)
library(ggplot2)
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
                        
```
