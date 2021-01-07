## Co-mutation and clonality
```
options(stringsAsFactors = FALSE)

# install.packages('UpSetR')
library(UpSetR)
library(tidyr)
library(dplyr)
library(RColorBrewer)
library(ggplot2)
library(pals)
library(cowplot)
library(tibble)

setwd("/gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV")
final_NGTs<-readRDS(file="./data/final_NGTs.rds")
pheno<-readRDS(file="./data/pheno.rds")

sample_mutations<-do.call(rbind,lapply(names(final_sample_summary),function(sample){
  data.frame("Sample"=sample,
            "DNMT3A"=ifelse(any(grepl("DNMT3A",colnames(final_sample_summary[[sample]]$NGT))),1,0),
             "TET2"=ifelse(any(grepl("TET2",colnames(final_sample_summary[[sample]]$NGT))),1,0),
             "IDH2"=ifelse(any(grepl("IDH2",colnames(final_sample_summary[[sample]]$NGT))),1,0),
             "IDH1"=ifelse(any(grepl("IDH1",colnames(final_sample_summary[[sample]]$NGT))),1,0),
             "ASXL1"=ifelse(any(grepl("ASXL1",colnames(final_sample_summary[[sample]]$NGT))),1,0),
             "FLT3"=ifelse(any(grepl("FLT3",colnames(final_sample_summary[[sample]]$NGT))),1,0),
             "JAK2"=ifelse(any(grepl("JAK2",colnames(final_sample_summary[[sample]]$NGT))),1,0),
             "NRAS"=ifelse(any(grepl("NRAS",colnames(final_sample_summary[[sample]]$NGT))),1,0),
             "KRAS"=ifelse(any(grepl("KRAS",colnames(final_sample_summary[[sample]]$NGT))),1,0),
             "PTPN11"=ifelse(any(grepl("PTPN11",colnames(final_sample_summary[[sample]]$NGT))),1,0)
            )
}))
```
```
clone_mutations<-do.call(rbind,lapply(names(final_sample_summary),function(sample){
  
  # select the clones
  clones<-final_sample_summary[[sample]]$Clones%>%select(Clone)
  # Extract the mutations
  mutations <- colnames(final_sample_summary[[sample]]$NGT%>%select(!Clone))
  
  # Separate clones into mutations, identify the mutations in the dominant clone.
  # I'm sure there is a more efficient way to do this, but this is what I have. 
  # This might seem a little redundant with the group ungroup and regroup, but the idea 
  # is we want to calculate the relative size of each clone in the context of the whole sample
  # then identify and remove the WT clone in the rare event it is the dominant clone, or the largest subclone.
  # In order to then mark the clones as dominant or subclone, we have to ungroup in order to use the context of the whole sample.
  # Lastly, we group again on the Clones and check whether each clone is mutant for the genes of interest.
  # We next remove excess columns representing genes and variants and finally remove duplicate rows. 
  # Previosuly each line of this data frame was a variant, and now it is a clone.
  out<-final_sample_summary[[sample]]$Clones%>%
                              mutate(Clone_size=Count/sum(Count))%>%
                              select(Clone,Clone_size)%>%
                              separate(col=Clone,
                                       into=mutations,sep="_",
                                       remove=FALSE)%>%
                              pivot_longer(cols=mutations,
                                          names_to="Variant",
                                          values_to="Genotype")%>%
                              add_column(Sample=`sample`)%>%
                              group_by(Clone)%>%
                              mutate(WT=ifelse(all(Genotype==0),1,0))%>%
                              filter(WT==0)%>%
                              filter(Genotype!=0)%>%
                              ungroup()%>%
                              mutate(Clonality=ifelse(Clone_size==max(Clone_size),
                                                      "Dominant","Subclone"))%>%
                              group_by(Clone)%>%
                              mutate(Gene=do.call(rbind,strsplit(Variant,"[\\._]"))[,1])%>%
                              mutate(DNMT3A=ifelse(any(Gene%in%"DNMT3A"),1,0),
                                     TET2=ifelse(any(Gene%in%"TET2"),1,0),
                                     ASXL1=ifelse(any(Gene%in%"ASXL1"),1,0),
                                     IDH1=ifelse(any(Gene%in%"IDH1"),1,0),
                                     IDH2=ifelse(any(Gene%in%"IDH2"),1,0),
                                     FLT3=ifelse(any(Gene%in%"FLT3"),1,0),
                                     NRAS=ifelse(any(Gene%in%"NRAS"),1,0),
                                     KRAS=ifelse(any(Gene%in%"KRAS"),1,0),
                                     PTPN11=ifelse(any(Gene%in%"PTPN11"),1,0),
                                     JAK2=ifelse(any(Gene%in%"JAK2"),1,0))%>%
                              ungroup()%>%
                              select(!c(Variant,Genotype,Gene))%>%
                              distinct()
  }))
```
```
# Identify genes of interest
DTAI_genes<- c("DNMT3A","TET2","IDH2","IDH1","ASXL1")

# Subset data.frame above to only the dominant clones
dominant_clone_mutations <- clone_mutations%>%filter(Clonality=="Dominant")

# For each sample, determine if the dominant clone
sample_mutations$Match<-ifelse(sapply(sample_mutations$Sample,function(sample) {
                                                all(sample_mutations%>%
                                                        filter(Sample==sample)%>%
                                                        select(all_of(DTAI_genes))==
                                                    dominant_clone_mutations%>%
                                                        filter(Sample==sample)%>%
                                                        select(all_of(DTAI_genes)))
                          }) ,"Match","Absent")

# Join this match with the phenotype data to pick a disease state of interest
test_set<-left_join(sample_mutations,pheno,by="Sample")

# Necessary little function to 
Myfunc <- function(row,feature) {
  data <- (row[feature]=="Match")
}

# Slight difference from BioRxiv paper due to a misclassification of one TET2 mutant CMML sample as AML.
AML<-upset(test_set%>%filter(grepl("AML",Dx)), 
           sets=DTAI_genes,
           order.by = c("degree"),
           main.bar.color = "grey60",decreasing=FALSE,
           mainbar.y.label = "Number of samples",
           sets.x.label = "Number of \n mutant samples",
           text.scale=1.25,
           shade.alpha = 0.75,
           show.numbers=FALSE,
           mb.ratio = c(0.6, 0.4),
           queries=list(list(query = Myfunc, 
                             params = list("Match"), 
                             color = brewer.pal(5,"Reds")[5], 
                             active = TRUE )))

ggsave("AML.pdf",width=6,height=5)
```
