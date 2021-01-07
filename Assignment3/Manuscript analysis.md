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
install.packages('pals')
```

```
# load R packages

library(farver)
library(dplyr)
library(tidyr)
library(ggplot2)
library(cooccur)
library(pals)
library(ComplexHeatmap)
library(magrittr)
library(vegan)
library(reshape2)
library(RColorBrewer)

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
***
#### Extended Figure 1a.
```
library(pals) # great package with color palettes in R
library(ComplexHeatmap) #used for making the oncoprint

fill_values <-setNames(as.list(rep(0,length(levels(final_mut_melt$Gene)))),levels(final_mut_melt$Gene))

mut_mat_wide<-final_mut_melt%>%
                        mutate(Variant_Class=ifelse(grepl("fs\\*|INS_|ins|ext|del",.$Mutation),"Indel",
                                                  ifelse(grepl("\\*$",.$Mutation),"Nonsense","Missense")))%>%
                      #  mutate_at(c("Gene","Variant_Class","Sample"),as.character())%>%
                        group_by(Sample,Gene)%>%
                        summarize("Variants"=list(Variant_Class))%>%
                        pivot_wider(id_cols=Sample, 
                                     names_from  = Gene, 
                                     values_from = Variants,
                                   #  values_fn   = list(Variant_Class=list),
                                     values_fill = list(Variant_Class="")) %>%
                        #ungroup(Sample,Gene)%>%
                        data.frame()

mut_mat_wide_storage <- list()
for(i in 2:ncol(mut_mat_wide)){ # start at 2 to ignore the first column of sample names
  mut_mat_wide_storage[[i]]<- do.call(rbind,lapply(mut_mat_wide[,i],function(x){
    #if(x==""){
    #  return(x)
  #  }  else  
      if(is.null(x)){
      return("")
    } else {
    paste(x,sep=";",collapse=";")
      }
   }
   ))
}

mut_mat_wide_storage[[1]] <- as.character(mut_mat_wide[,"Sample"])
final_mat <- do.call(cbind,mut_mat_wide_storage)
colnames(final_mat) <- colnames(mut_mat_wide)
rownames(final_mat) <- final_mat[,1]
final_mat <- t(final_mat[,-1])

#Now we set up the color schemes for the variants on each row
variant_type_colors = c("Indel" = "darkorchid2", "Nonsense" = "black", "Missense" = "darkgreen")
alter_functions = list(
  background = function(x, y, w, h) {
    grid.rect(x, y, w, h-unit(0.25, "mm"), 
              gp = gpar(fill = "#CCCCCC", col = NA))
  },
  Indel = function(x, y, w, h) {
    grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"), 
              gp = gpar(fill = variant_type_colors["Indel"], col = NA))
  },
  Nonsense = function(x, y, w, h) {
    grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"), 
              gp = gpar(fill = variant_type_colors["Nonsense"], col = NA))
  },
  Missense = function(x, y, w, h) {
    grid.rect(x, y, w-unit(0.5, "mm"), h*0.33, 
              gp = gpar(fill = variant_type_colors["Missense"], col = NA))
  }
)

# Establish colors for each disease state and diagnosis
color_set <- list("Dx" = setNames(okabe(n=length(unique(as.character(pheno[,"Dx"])))),
                                    c( "CH","MDS","MPN", "AML", "sAML" ,"tAML","Other") ),
                  "Disease.Status" = setNames(tol(n=(length(unique(as.character(pheno[,"Disease.Status"]))))),
                                    c("Newly Diagnosed","Relapse/Refractory","Newly Transformed",
                                      "Persistent","Chronic Stage", "Other")))    

top_annotation <- HeatmapAnnotation(cbar = anno_oncoprint_barplot(),
                                    df   = pheno[,c("Dx","Disease.Status")],
                                    col  = color_set,
                                    annotation_name_side = "left")

# Indicate what should be included in the legend                  
heatmap_legend_param <- list(title  = "Alternations", 
                             at     = c("Indel", "Nonsense", "Missense"), 
                             labels = c("Indel", "Nonsense", "Missense"))

# Make the oncoprint

pdf("SFig1a.pdf")

oncoPrint(final_mat,
          alter_fun            = alter_functions, 
          col                  = variant_type_colors, 
          top_annotation       = top_annotation,
          heatmap_legend_param = heatmap_legend_param)
dev.off()
```
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/SFig1a.png" alt="foo bar" title="train &amp; tracks" /></p>

***

#### Extended Figure 1c.

```
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

Total number of patients mutated for each gene
```
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
***

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
### Sample clonality: Figure 1C,E Figure 2A,B
```
final_sample_summary<-readRDS(file="./data/final_sample_summary.rds")
pheno<-readRDS(file="./data/pheno.rds")
```
```
mutants_in_each_sample<-do.call(rbind,lapply(names(final_sample_summary),function(x){
  y<-colnames(final_sample_summary[[x]]$NGT)
  z <- list()
  z$Sample <- x
  z$DNMT3A <- ifelse(any(grepl("DNMT3A",y)),1,0)
  z$TET2 <- ifelse(any(grepl("TET2",y)),1,0)
  z$ASXL1 <- ifelse(any(grepl("ASXL1",y)),1,0)
  z$IDH <- ifelse(any(grepl("IDH",y)),1,0)
  z$FLT3 <- ifelse(any(grepl("FLT3",y)),1,0)
  z$KIT <- ifelse(any(grepl("KIT",y)),1,0) # n=1 sample, we put it in the "signalling category"
  z$RAS <- ifelse(any(grepl("RAS",y)),1,0)
  z$JAK2 <- ifelse(any(grepl("JAK2",y)),1,0)
  z$PTPN11 <- ifelse(any(grepl("PTPN11",y)),1,0)
  data.frame(t(do.call(rbind,z)))
}))
```
```
# Bin into groups based on mutations and disease type
mutants_in_each_sample%<>%mutate(Group=case_when(
                          (TET2==1|DNMT3A==1|IDH==1|ASXL1==1)&(RAS==0&FLT3==0)~'DTAI',
                          (TET2==1|DNMT3A==1|IDH==1|ASXL1==1)&((RAS==1&FLT3==0)|
                                                                   (PTPN11==1&FLT3==0))~'DTAI-RAS',
                          (TET2==1|DNMT3A==1|IDH==1|ASXL1==1)&(RAS==0&FLT3==1)~'DTAI-FLT3',
                          (TET2==1|DNMT3A==1|IDH==1|ASXL1==1)&((RAS==1&FLT3==1)|
                                                               (PTPN11==1&FLT3==1))~'DTAI-FLT3-RAS',
                          (TET2==0&DNMT3A==0&IDH==0&ASXL1==0)&(RAS==1|FLT3==1|JAK2==1|KIT==1)~'Signaling'))%>%
                          left_join(pheno,by="Sample")%>%
                          mutate(Final_group=case_when(
                                          grepl("AML|Other",Dx)~Group,
                                          !grepl("AML|Other",Dx)~Dx
                                        ))

# Order the groups to match how we have them in the paper
mutants_in_each_sample$Final_group <- factor(mutants_in_each_sample$Final_group,
                                              levels=c("CH","MPN","Signaling","DTAI",
                                                       "DTAI-RAS","DTAI-FLT3","DTAI-FLT3-RAS"))
```
```
clonal_level_info<-data.frame(do.call(rbind,lapply(names(final_sample_summary),function(y){
  x <- final_sample_summary[[y]]$Clones
  data.frame("Sample"=y,
             "Shannon"=vegan::diversity(x[,1],index="shannon"),
             "Number_of_clones"=length(x[,1]),
             "Number_of_mutations"=ncol(final_sample_summary[[y]]$NGT),
             "Number_of_mutations_in_dominant_clone"=sum(as.numeric(do.call(rbind,
                                           strsplit(as.character(x[nrow(x),2]),split="_")))),
             "Dominant_clone_size"=max(x[,1]/sum(x[,1]))) #,
           })))
```
```
# Combine the data frame
test<-mutants_in_each_sample%>%inner_join(clonal_level_info)

# Number of mutations
gg_number_of_mutations<-ggplot(test%>%group_by(Final_group)%>%
                                  summarise(mean=mean(Number_of_mutations),
                                            sd = sd(Number_of_mutations),
                                            sem = sd(Number_of_mutations)/
                                                      sqrt(length(Number_of_mutations))),
                                    aes(x=Final_group,y=mean,fill=Final_group))+
                                    geom_bar(stat="identity",color="black")+
                                    geom_errorbar(aes(ymin = mean-sem, ymax = mean+sem),width=0.5,lwd=0.5)+
                                    theme_classic(base_size = 8)+
                                    ylab("Number of mutations")+xlab("")+ggtitle("")+
                                    scale_y_continuous(limits = c(0,9), expand = c(0, 0)) +
                                    theme(axis.text.x = element_text(angle=30,hjust=1)) +
                                    scale_fill_brewer(type="seq",palette = "Reds",aesthetics = "fill",guide=FALSE)

ggsave("number_of_mutations.pdf",width=5,height=5)
```
```
# Number of clones
gg_number_of_clones<-ggplot(test,aes(y=Number_of_clones,x=Final_group,fill=Final_group))+
                                  geom_boxplot(outlier.shape = NA)+  
                                  geom_jitter(width = 0.1,size=0.5)+
                                  theme_classic(base_size = 8)+
                                  ylab("Number of clones")+
                                  xlab("")+
                                  theme(axis.text.x = element_text(angle=30,hjust=1)) +
                                  scale_fill_brewer(type="seq",palette = "Reds",aesthetics = "fill",guide=FALSE)
ggsave("number_of_clones.pdf",width=5,height=5)

## merge=plot_grid(gg_number_of_mutations,gg_number_of_clones,ncol=2,align="hv",axis="ltrb",labels=c("C","E"))
## ggsave("Figure1.pdf",width=8,height=5)
```
```
library(reshape2) #for melt, I need to come up with a better way to do this, if anyone has ideas let me know!
pvalues_Number_of_clones<-test%>%{melt(pairwise.t.test(.$Number_of_clones,g=.$Final_group,
                                                     data=.,p.adjust.method="fdr")$p.value)}%>%
                                     filter(!is.na(value))%>%filter(value<0.1)
pvalues_Number_of_clones
pvalues_Number_of_mutations<-test%>%{melt(pairwise.t.test(.$Number_of_mutations,g=.$Final_group,
                                                     data=.,p.adjust.method="fdr")$p.value)}%>%
                                     filter(!is.na(value))%>%filter(value<0.1)
pvalues_Number_of_mutations
```
```
gg_shannon<-ggplot(test,aes(y=Shannon,x=Final_group,fill=Final_group))+
                        geom_boxplot(outlier.shape = NA)+  
                        geom_jitter(width = 0.1,size=0.5)+
                        theme_classic(base_size = 8)+
                        ylab("Shannon diveristy index")+
                        xlab("")+
                        theme(axis.text.x = element_text(angle=30,hjust=1)) +
                        scale_fill_brewer(type="seq",palette = "Reds",aesthetics = "fill",guide=FALSE)
ggsave("shannon.pdf",width=5,height=5)
```
```
gg_Number_of_mutations_in_Dclone<-ggplot(test%>%group_by(Final_group)%>%
                                       summarise(mean=mean(Number_of_mutations_in_dominant_clone),
                                                 sd = sd(Number_of_mutations_in_dominant_clone),
                                                 sem = sd(Number_of_mutations_in_dominant_clone)/
                                                       sqrt(length(Number_of_mutations_in_dominant_clone))),
                                       aes(x=Final_group,y=mean,fill=Final_group))+
                                          geom_bar(stat="identity",color="black")+
                                          geom_errorbar(aes(ymin = mean-sem, ymax = mean+sem),width=0.5,lwd=0.5)+
                                          theme_classic(base_size = 8)+
                                          ylab("Number of mutations \n in dominant clone")+xlab("")+ggtitle("")+
                                          scale_y_continuous(limits = c(0,4.5), expand = c(0, 0)) +
                                          theme(axis.text.x = element_text(angle=30,hjust=1)) +
                                          scale_fill_brewer(type="seq",palette = "Reds",
                                                            aesthetics = "fill",guide=FALSE)
ggsave("Number_of_mutations_in_Dclone.pdf",width=5,height=5)
```
```
pvalues_Shannon<-test%>%{melt(pairwise.t.test(.$Shannon,g=.$Final_group,
                                                        data=.,p.adjust.method="fdr")$p.value)}%>%
                                              filter(!is.na(value))%>%filter(value<0.1)
```
```
pvalues_Number_of_mutations_in_dominant_clone<-test%>%{melt(pairwise.t.test(
                                                        .$Number_of_mutations_in_dominant_clone,
                                                        g=.$Final_group,
                                                        data=.,p.adjust.method="fdr")$p.value)}%>%
                                              filter(!is.na(value))%>%filter(value<0.1)
```
```
gg_dominant_clone_size<-ggplot(test,
                            aes(y=Dominant_clone_size,x=Final_group,fill=Final_group))+
                            geom_boxplot(outlier.shape = NA)+  
                            geom_jitter(width = 0.1,size=0.5)+
                            theme_classic(base_size = 8)+
                            ylab("Fraction of sample \n in dominant clone")+
                            xlab("")+
                            theme(axis.text.x = element_text(angle=30,hjust=1)) +
                            scale_fill_brewer(type="seq",palette = "Reds",aesthetics = "fill",guide=FALSE)

ggsave("dominant_clone_size.pdf",width=7,height=5)
```
```
# determine the number of mutants alleles in each clone
clone_size_by_genetic_density<- do.call(rbind,lapply(final_sample_summary,function(x){
                                    possible_clones_subset <-x$Clones%>%filter(Clone%in% x$Clones[,"Clone"] )
                                    clones<-possible_clones_subset[,"Clone"]
                                    dedup<-x$NGT[!duplicated(x$NGT)&x$NGT[,"Clone"]%in%clones,]
                                    set_mat<-full_join(possible_clones_subset[,1:2],dedup)
                                    counts <-set_mat[,"Count"]
                                    weights<-set_mat[,"Count"]/sum(set_mat[,"Count"])
                                    genetic_complexity <- rowSums(set_mat[,-c(1:2)])
                                    return(data.frame("Clone_size"=weights,
                                                      "Genetic_density"=genetic_complexity))
}))
```
```
gg_clone_size_by_genetic_density<-ggplot(clone_size_by_genetic_density,
                                              aes(y=Clone_size,x=factor(Genetic_density),
                                                  fill=factor(Genetic_density)))+
                                              geom_jitter(width = 0.1,size=0.5)+
                                              geom_boxplot(outlier.shape = NA)+  
                                              theme_bw(base_size = 8)+
                                              ylab("Fraction of sample in clone")+
                                              xlab("Number of mutant alleles")+
                                              scale_fill_brewer(type="seq",palette = "Greens",
                                                                aesthetics = "fill",guide=FALSE)
ggsave("clone_size_by_genetic_density.pdf",width=7,height=5)
```
```
pvalues_Dominant_clone_size<-test%>%{melt(pairwise.t.test(.$Dominant_clone_size,g=.$Final_group,
                                                     data=.,p.adjust.method="fdr")$p.value)}%>%
                                     filter(!is.na(value))%>%filter(value<0.1)
pvalues_Dominant_clone_size
```
```
library(RColorBrewer)
final_sample_summary<-readRDS(file="./data/final_sample_summary.rds")

sample <-"MSK45"
sample_list <-final_sample_summary

# Extract out the sample of interest    
clonal_abundance <-sample_list[[sample]]$Clones 
clonal_architecture <-sample_list[[sample]]$Architecture 

# Ensure the order of the clone abundance and clone architecture are the same.
clonal_architecture$Clone <- factor(clonal_architecture$Clone, levels=rev(clonal_abundance$Clone))
clonal_abundance$Clone <- factor(clonal_abundance$Clone, levels=levels(clonal_architecture$Clone))

# Generate clonal abundance barplot
gg_clonal_barplot <- ggplot(data=clonal_abundance, aes(x=Clone, y=Count,fill=Count)) + 
                              geom_col()+ 
                              theme_classic(base_size=7)+
                              scale_y_continuous(expand=c(0.01,0))+
                              #ylim() + 
                              ylab("Cell Count")+
                              geom_errorbar(aes(ymin = LCI, ymax = UCI), width = 0.2)+
                              scale_fill_distiller(name = "Value", palette = "Reds", direction = 1) +
                              theme(axis.title.x = element_blank(), 
                                    axis.text.x = element_blank(), 
                                    axis.ticks.x = element_blank(),
                                    axis.line.x =element_blank(),
                                    legend.position = "none",
                                    plot.margin=unit(c(0,0,0,0),"cm"))

# Generate mutation heatmap
gg_heatmap <- ggplot(data=clonal_architecture,
                     aes(x=Clone, y=Mutant, fill=Genotype))+
                     geom_tile() +
                     scale_fill_manual(values=c("WT"=brewer.pal(7,"Reds")[1],
                                                "Heterozygous"=brewer.pal(7,"Reds")[3],
                                                "Homozygous"=brewer.pal(7,"Reds")[6],
                                                "Unknown"="grey50"),name="Genotype")+
                    theme_classic(base_size=7) +
                    ylab("Mutation")+
                    scale_y_discrete(limits = rev(levels(clonal_architecture$Mutant)))+
                          theme(legend.position = "right", legend.direction = "vertical",
                          axis.text.x = element_blank(), 
                          axis.line=element_blank(),
                          axis.title.x=element_blank(),
                          axis.ticks.x = element_blank(),
                          plot.margin=unit(c(0,0,0,0),"cm"))

# Put it all together
gg=plot_grid(gg_clonal_barplot,gg_heatmap,ncol=1,align="v",axis="lr",rel_heights = c(1,0.75))
ggsave("Fig1b.pdf",width=5,height=5)
```
