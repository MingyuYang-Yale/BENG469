(https://github.com/bowmanr/scDNA_myeloid/tree/master/data)
```
cp /gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV/data/*.rds ./data
```

#### Open R:
```
R
```
```
install.packages('farver')
install.packages('cooccur')
install.packages('pals')
install.packages('UpSetR')
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
library(UpSetR)

```
```
setwd("/gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV")
final_sample_summary<-readRDS(file="./data/final_sample_summary.rds")
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
### Extended Figure 1a 
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

pdf("SFig1a.pdf",width=15,height=5)

oncoPrint(final_mat,
          alter_fun            = alter_functions, 
          col                  = variant_type_colors, 
          top_annotation       = top_annotation,
          heatmap_legend_param = heatmap_legend_param)
dev.off()
```
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Manuscript%20analysis/SFig1a.png" alt="foo bar" title="train &amp; tracks" /></p>

***

### Extended Figure 1 c-f 
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
ggsave("SFig1c.pdf",width=6,height=5)
```
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
ggsave("SFig1d.pdf",width=6,height=5)
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
ggsave("SFig1e.pdf",width=6,height=5)
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
ggsave("SFig1f.pdf",width=6,height=5)
```
```
library(cowplot)
pdf("SFig1c-f.pdf",width=8,height=5)
plot_grid(gg_mut_count,gg_mut_patient,
           gg_mutated_genes_per_patient,gg_mutations_per_patient,
           ncol=2,align="hv",axis="ltrb",
           labels = c('c', 'd','e','f'))
dev.off()
```
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Manuscript%20analysis/SFig1c-f.png" alt="foo bar" title="train &amp; tracks" /></p>


### Figure 1a

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
library(vegan)
library(reshape2)
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

pdf("Fig1a.pdf",width=3,height=3)

ggplot(test%>%group_by(Final_group)%>%
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

dev.off()

pvalues_Number_of_mutations<-test%>%{melt(pairwise.t.test(.$Number_of_mutations,g=.$Final_group,
                                                     data=.,p.adjust.method="fdr")$p.value)}%>%
                                     filter(!is.na(value))%>%filter(value<0.1)
pvalues_Number_of_mutations
```
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Manuscript%20analysis/Fig1a.png" alt="foo bar" title="train &amp; tracks" /></p>


### Figure 1b
```
library(RColorBrewer)

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
pdf("Fig1b.pdf",width=4,height=3)
plot_grid(gg_clonal_barplot,gg_heatmap,ncol=1,align="v",axis="lr",rel_heights = c(1,0.75))
dev.off()
```
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Manuscript%20analysis/Fig1b.png" alt="foo bar" title="train &amp; tracks" /></p>

### Figure 1c
```
# Number of clones
pdf("Fig1c.pdf",width=3,height=3)
ggplot(test,aes(y=Number_of_clones,x=Final_group,fill=Final_group))+
                                  geom_boxplot(outlier.shape = NA)+  
                                  geom_jitter(width = 0.1,size=0.5)+
                                  theme_classic(base_size = 8)+
                                  ylab("Number of clones")+
                                  xlab("")+
                                  theme(axis.text.x = element_text(angle=30,hjust=1)) +
                                  scale_fill_brewer(type="seq",palette = "Reds",aesthetics = "fill",guide=FALSE)
dev.off()

pvalues_Number_of_clones<-test%>%{melt(pairwise.t.test(.$Number_of_clones,g=.$Final_group,
                                                     data=.,p.adjust.method="fdr")$p.value)}%>%
                                     filter(!is.na(value))%>%filter(value<0.1)
pvalues_Number_of_clones                                     

```
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Manuscript%20analysis/Fig1c.png" alt="foo bar" title="train &amp; tracks" /></p>

### Figure 1d
```
pdf("Fig1d.pdf",width=3,height=3)
ggplot(test,aes(y=Shannon,x=Final_group,fill=Final_group))+
                        geom_boxplot(outlier.shape = NA)+  
                        geom_jitter(width = 0.1,size=0.5)+
                        theme_classic(base_size = 8)+
                        ylab("Shannon diveristy index")+
                        xlab("")+
                        theme(axis.text.x = element_text(angle=30,hjust=1)) +
                        scale_fill_brewer(type="seq",palette = "Reds",aesthetics = "fill",guide=FALSE)
dev.off()

pvalues_Shannon<-test%>%{melt(pairwise.t.test(.$Shannon,g=.$Final_group,
                                                        data=.,p.adjust.method="fdr")$p.value)}%>%
                                              filter(!is.na(value))%>%filter(value<0.1)
pvalues_Shannon
```
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Manuscript%20analysis/Fig1d.png" alt="foo bar" title="train &amp; tracks" /></p>

### Figure 1e
```
pdf("Fig1e.pdf",width=3,height=3)
ggplot(test,
                            aes(y=Dominant_clone_size,x=Final_group,fill=Final_group))+
                            geom_boxplot(outlier.shape = NA)+  
                            geom_jitter(width = 0.1,size=0.5)+
                            theme_classic(base_size = 8)+
                            ylab("Fraction of sample \n in dominant clone")+
                            xlab("")+
                            theme(axis.text.x = element_text(angle=30,hjust=1)) +
                            scale_fill_brewer(type="seq",palette = "Reds",aesthetics = "fill",guide=FALSE)
dev.off()

pvalues_Dominant_clone_size<-test%>%{melt(pairwise.t.test(.$Dominant_clone_size,g=.$Final_group,
                                                     data=.,p.adjust.method="fdr")$p.value)}%>%
                                     filter(!is.na(value))%>%filter(value<0.1)
pvalues_Dominant_clone_size
```
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Manuscript%20analysis/Fig1e.png" alt="foo bar" title="train &amp; tracks" /></p>

***

### Extended Figure 2b
```
pdf("SFig2b.pdf",width=3,height=3)
ggplot(test%>%group_by(Final_group)%>%
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
dev.off()                                                            

#ggsave("Number_of_mutations_in_Dclone.pdf",width=5,height=5)

pvalues_Number_of_mutations_in_dominant_clone<-test%>%{melt(pairwise.t.test(
                                                        .$Number_of_mutations_in_dominant_clone,
                                                        g=.$Final_group,
                                                        data=.,p.adjust.method="fdr")$p.value)}%>%
                                              filter(!is.na(value))%>%filter(value<0.1)
pvalues_Number_of_mutations_in_dominant_clone                                             
```
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Manuscript%20analysis/SFig2b.png" alt="foo bar" title="train &amp; tracks" /></p>


### Extended Figure 2c
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

pdf("SFig2c.pdf",width=3,height=2)
ggplot(clone_size_by_genetic_density,
                                              aes(y=Clone_size,x=factor(Genetic_density),
                                                  fill=factor(Genetic_density)))+
                                              geom_jitter(width = 0.1,size=0.5)+
                                              geom_boxplot(outlier.shape = NA)+  
                                              theme_bw(base_size = 8)+
                                              ylab("Fraction of sample in clone")+
                                              xlab("Number of mutant alleles")+
                                              scale_fill_brewer(type="seq",palette = "Greens",
                                                                aesthetics = "fill",guide=FALSE)
dev.off()                                                                
##ggsave("clone_size_by_genetic_density.pdf",width=7,height=5)

```
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Manuscript%20analysis/SFig2c.png" alt="foo bar" title="train &amp; tracks" /></p>



### Figure 2a : Mutation Co-occurence
```
library(tidyr)
library(dplyr)
library(RColorBrewer)
library(ggplot2)
library(pals)
library(cowplot)

clone_size_by_gene<- do.call(rbind,lapply(names(final_sample_summary),function(x){
  # select the clones
  clones<-final_sample_summary[[x]]$Clones%>%select(Clone)
  
  # Compute the relative clone size
  Clone_size<-final_sample_summary[[x]]$Clones%>%transmute(Clone_size=Count/sum(Count))%>%pull(Clone_size)
  names(Clone_size) <- clones[,"Clone"]
  
  # Extract the mutations
  mutations <- colnames(final_sample_summary[[x]]$NGT%>%select(!Clone))
  
  # Identify the dominant clone, which is the last one in this data frame
  dominant_clone <- clones[nrow(clones),]
  
  # Compute the bulk VAF for each mutation
  VAFs <- final_sample_summary[[x]]$NGT%>%select(`mutations`)%>%
                              summarise_all(funs(mean(.)/2))

  # Separate the clone into a deduplicated NGT matrix
  mut_mat<-final_sample_summary[[x]]$Clones%>%
                              select(Clone)%>%
                              separate(col=Clone,into=mutations,sep="_")
  
  # Create a composite data frame and turn it into long form
  data.frame(clones,Clone_size,mut_mat,"Sample"=x)%>%
            pivot_longer(cols=all_of(mutations),names_to="Variant", values_to="Genotype")%>%
            
            filter(Genotype!=0)%>% # remove WT entries
            separate(col=Variant, into="Gene",extra="drop",sep="\\.|_",remove=FALSE)%>% # For later useage in plotting
            group_by(Variant)%>% 
            filter(Clone_size==max(Clone_size))%>% #identify largest clone
            mutate(Clonality=case_when(
                          Clone==`dominant_clone`~"Dominant",
                          Clone!=`dominant_clone`~"Subclone"))%>% #label clones
            inner_join(data.frame("VAF"=t(VAFs),
                                  "Variant"=names(VAFs))) # merge with bulk VAF info
}))

# Tally the number of times a gene is in the dominant and subclone
tally_set<-data.frame(table(clone_size_by_gene$Gene,
                           clone_size_by_gene$Clonality))%>%
                      pivot_wider(names_from=Var2,values_from=Freq)%>%
                      mutate(Ratio=Dominant/(Subclone+Dominant))%>% #calculate the dominant ratio
                      arrange(Ratio) 
  
# For plotting purposes establish order of the y axis
clone_size_by_gene$Gene <- factor(clone_size_by_gene$Gene, levels=tally_set$Var1)

# Linde and I spent too much time picking the exact shade of red we wanted for this paper....
color_red<-brewer.pal(5,"Reds")[5]

# For plotting purposes establish order of stacked bars
clone_size_by_gene$Clonality<-factor(clone_size_by_gene$Clonality,levels=c("Subclone","Dominant"))

gA <- tally(clone_size_by_gene%>%group_by(Gene,Clonality)) %>%
  mutate(Gene = factor(Gene , levels = levels(Gene) %>% rev))
  
ggA<-  ggplot(gA, aes(x=Gene, fill=Clonality,y=n,label=n))+
  guides(fill=FALSE,color=FALSE)+
  scale_y_continuous( expand = c(0, 0.0))+ #removes white space near the axis of the bars
  geom_bar(stat="identity",position="fill")+
  xlab("")+#coord_flip()+
  scale_fill_manual(values=c("Dominant"=color_red,
                             "Subclone"="grey80")) +
  ylab("Fraction of mutant clones \n with mutation in dominant clone")+
  theme_bw(base_size=8)+
    theme(legend.position = "bottom",
          axis.text.x = element_text(angle = 45, hjust = 1,vjust=1))  

ggB <-   ggplot(clone_size_by_gene, 
            aes(y=Clone_size, x=factor(Gene, levels = levels(gA$Gene) )  , fill=Gene)) +
  geom_boxplot(alpha = 0.5,outlier.shape = NA)+
  geom_point(aes(color=Clonality,group=Clonality), 
             position = position_jitterdodge(), size=0.3)+
  scale_fill_manual(values=tol.rainbow(n=length(levels(clone_size_by_gene$Gene))))+
  scale_color_manual(values=c("Dominant"=color_red,
                              "Subclone"="grey20"))+
 # coord_flip()+
  theme_bw(base_size=8)+guides(fill=FALSE,color=FALSE)+
#  theme(axis.text.y = element_blank(),
#        axis.ticks.y  = element_blank(),
#        axis.title.y = element_blank())+
  scale_y_continuous(limits = c(0,1), expand = c(0, 0.05)) + 
  labs( y= "Fraction of cells \n in largest mutant clone" , x='')+
  theme(legend.position = "bottom", 
        axis.text.x = element_blank(),
        axis.ticks.x  = element_blank())  

  
spacer <- plot_grid(NULL) # plot looks better with a little spacer

pdf("Fig2a.pdf",width=5,heigth=3)
plot_grid(ggB,ggA,align="v",axis="tb",
          nrow=2,rel_heights =c(1,1)) #+ coord_flip()
dev.off()
```
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Manuscript%20analysis/Fig2a.png" alt="foo bar" title="train &amp; tracks" /></p>

### Extended Figure 2d 
```
library(magrittr)
# Incorporate Diagnosis and disease state
clone_size_by_gene_Dx<-inner_join(clone_size_by_gene,pheno)

# We focused on a subset of genes
genes_of_interest <- c("DNMT3A","TET2","ASXL1","IDH1","IDH2",
                       "JAK2","NRAS","KRAS","FLT3","NPM1","RUNX1")

# We had an interest in DNMT3A R882 point mutants, so we can extract those out
clone_size_by_gene_Dx%<>%mutate(Gene=case_when(
                          grepl("DNMT3A.p.R882",Variant)~"DNMT3A.p.R882",
                          TRUE~as.character(Gene)))
                                   
clone_size_by_gene_DTAI<-left_join(clone_size_by_gene_Dx,mutants_in_each_sample,by="Sample")

pdf("SFig2d.pdf",width=10,height=4)

ggplot(tally(clone_size_by_gene_DTAI%>%
                                    filter(Gene%in%c("DNMT3A","TET2","ASXL1","DNMT3A.p.R882","IDH1","IDH2",
                                    "FLT3","NRAS","KRAS","JAK2","NPM1","RUNX1"))%>%
                                    group_by(Gene,Final_group,Clonality)) ,
                        aes(x=Final_group,fill=Clonality,y=n)) +
                        facet_wrap(~factor(Gene,
                                            levels=c("DNMT3A","TET2","ASXL1","DNMT3A.p.R882","IDH1","IDH2",
                                            "FLT3","NRAS","KRAS","JAK2","NPM1","RUNX1")),ncol=6)+
                        geom_col()+
                        xlab("")+
                        scale_fill_manual(values=c("Dominant"=color_red,
                                                 "Subclone"="grey80"))+
                        ylab("Number of samples")+
                        theme_bw(base_size=10)+
                        theme(legend.position = "right",
                            axis.text.x =element_text(angle=30,hjust=1))

dev.off()
```
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Manuscript%20analysis/SFig2d.png" alt="foo bar" title="train &amp; tracks" /></p>

### Extended Figure 2e
```
library(ggbeeswarm)

# We focused on a subset of genes
genes_of_interest <- c("DNMT3A","TET2","ASXL1","IDH1","IDH2",
                       "JAK2","NRAS","KRAS","FLT3","NPM1")

data_to_plot<-inner_join(clone_size_by_gene,pheno)%>%
                          filter(as.character(Gene)%in%genes_of_interest &
                                !Dx%in%c("CH"))%>%
                          group_by(Gene,Clonality)

summarized_data <-data_to_plot%>%summarise(mean=mean(VAF),            
                                           sd = sd(VAF),
                                           sem = sd(VAF)/sqrt(length(VAF)))

pdf("SFig2e.pdf",width=5,height=3)
ggplot(data_to_plot,aes(x=Clonality,y=VAF,color=Clonality))+
                    facet_wrap(~factor(Gene,levels=genes_of_interest),
                                scale="free_x",ncol=5)+
                    ggbeeswarm::geom_beeswarm()+
                    geom_errorbar(data=summarized_data,aes(x=Clonality,
                                                           y=mean,
                                                           ymin=mean-sem,
                                                           ymax=mean+sem),
                                                           color="black")+
                    scale_color_manual(values=c("Dominant"=color_red,
                                                "Subclone"="grey50"))+
                    xlab("")+        ylab("Computed VAF")+
                    theme_classic()+guides(fill=FALSE)+
                    theme(axis.ticks.x = element_blank(),
                          axis.text.x = element_blank())+
                    scale_y_continuous(limits=c(0,1.1),
                                       breaks=c(0,.25,.5,.75,1),
                                   labels=c("0","0.25","0.50","0.75","1.0"))
dev.off()
## ggsave("clonality_VAF.pdf",width=5,height=4)


library(broom)
clonality_VAF_pvalues<-data.frame(data_to_plot)%>% 
                                filter(as.character(Clonality)%in%c("Dominant","Subclone")&
                                         Gene!="IDH2")%>%
                                group_by(Gene)%>%
                                select(VAF,Clonality)%>%
                                do(tidy(t.test(VAF ~ Clonality, data = .)))%>%
                                select(Gene,Dominant_VAF=estimate2,Subclone_VAF=estimate1,
                                       p.value)%>%
                                mutate_if(is.numeric, funs(as.character(signif(., 3))))
clonality_VAF_pvalues
```
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Manuscript%20analysis/SFig2e.png" alt="foo bar" title="train &amp; tracks" /></p>

### Extended Figure 2f : Mutation Co-occurence
```
library(cooccur)
### create matrix for oncoprint
mut_mat <- table(melted_mut_mat$Sample,melted_mut_mat$Gene)

### Prepare matrix for co occurence map
cooccur_mat <- cooccur(mat=t(mut_mat), type="spp_site",
                       only_effects = FALSE,eff_matrix=TRUE,
                       thresh=FALSE, eff_standard=FALSE,spp_names=TRUE)$results


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

# Order the genes in a coherent pattern for triangle strucutre of graph.
cooccur_data_mat$sp1_name<-factor(cooccur_data_mat$sp1_name,
                                  levels=unique(cooccur_data_mat$sp1_name))
cooccur_data_mat$sp2_name<-factor(cooccur_data_mat$sp2_name,
                                  levels=rev(levels(cooccur_data_mat$sp1_name)))

# Triangle heatmap to compare cohorts
pdf("SFig2f.pdf",width=5,height=5)
ggplot(cooccur_data_mat%>%filter(sp1_name!="BRAF"),aes(x=sp1_name,y=sp2_name))+
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
dev.off()                      
##ggsave("corrplot.pdf",width=5,height=5)
```
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Manuscript%20analysis/SFig2f.png" alt="foo bar" title="train &amp; tracks" /></p>

### Figure 2b 

```
library(UpSetR)
library(tidyr)
library(dplyr)
library(RColorBrewer)
library(ggplot2)
library(pals)
library(cowplot)
library(tibble)

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
                             color = brewer.pal(5,"Reds")[5])))

ggsave("Fig2b.pdf",width=6,height=5)
```
### Extended Figure 3a
```
CH<-upset(test_set%>%filter(Dx=="CH"), sets=DTAI_genes,order.by = c("degree"),
           main.bar.color = "grey60",decreasing=FALSE,
           mainbar.y.label = "Number of samples",
           sets.x.label = "Number of \n mutant samples",
           text.scale=1.25,
           shade.alpha = 0.75,
           show.numbers=FALSE,
           queries=list(list(query = Myfunc, params = list("Match"), color = brewer.pal(5,"Reds")[5], active = TRUE )))

ggsave("SFig3a.pdf",width=6,height=5)
```

### Figure 2c
```
library(igraph)

# identify sample with at least 2 DTAI mutationss
multi_DTAI<-test_set%>%filter(grepl("AML",Dx))%>%
                filter((ASXL1+DNMT3A+TET2+IDH1+IDH2)>=2)%>%
                distinct(Sample)%>%pull(Sample)

# Identify dominant clones 
DTAI_dominant_clones<-clone_mutations%>%filter(Sample%in%multi_DTAI)%>%
                              filter(Clonality=="Dominant")%>%
                              select(Clone,Clone_size,Sample,DNMT3A,TET2,ASXL1,IDH1,IDH2)%>%
                              pivot_longer(cols=c(DNMT3A,TET2,ASXL1,IDH1,IDH2),
                                           names_to="Gene",values_to="Mutated")%>%
                              filter(Mutated==1)

# Now we want to know which variants are in the dominant clone, and the size of that clone. 
# I'm sure there is a nice way to do this in dplyr, grouping on sample, but I couldn't figure it out
# so we will use lapply.
genes_in_each_dominant_clone<- do.call(rbind,setNames(lapply(multi_DTAI,function(x){
    
    # Extract the genes
    dominant_variants<- DTAI_dominant_clones%>%filter(Sample==x)%>%pull(Gene)
    
    # Extract the clone size
    dominant_clone_size<- DTAI_dominant_clones%>%filter(Sample==x)%>%pull(Clone_size)
  
    # if there are more than two DTAI variants in the dominant clone make a combinatorial edgelist
    if(length(dominant_variants)>=2){
      return(setNames(data.frame(t(combn(dominant_variants,2)),dominant_clone_size,"Dominant"),c("to","from","size","Clonality")))} 
    # if there is only 1 mutant in the dominant clone, list it for now so we can count the mutation, 
    # but we will eventually filter it out
  else if(length(dominant_variants)==1){
      return(setNames(data.frame(t(c(dominant_variants,dominant_variants)),dominant_clone_size,"Subclone"),c("to","from","size","Clonality")))} 
    # if no DTAI mutants in the dominant clone, ignore.
  else if(length(dominant_variants)==0){
      NULL
  }
}),multi_DTAI))%>%distinct()

# Now we will go for a similar process with subclones.
DTAI_sub_clones<-clone_mutations%>%filter(Sample%in%multi_DTAI)%>%
                              filter(Clonality!="Dominant")%>%
                              select(Clone,Clone_size,Sample,DNMT3A,TET2,ASXL1,IDH1,IDH2)%>%
                              pivot_longer(cols=c(DNMT3A,TET2,ASXL1,IDH1,IDH2),
                                           names_to="Gene",values_to="Mutated")%>%
                              filter(Mutated==1)%>%
# This is how we specifically select multi mutant subclone
                              group_by(Clone,Sample)%>%
                              add_tally()%>%filter(n>1)%>%
                              ungroup()

# Same process as above, but note that we decided to only plot the largest multi mutant clone.
# Try getting rid of this and seeing how it looks.
genes_in_each_subclone <- do.call(rbind,setNames(lapply(multi_DTAI,function(x){
    subclone_variants <- DTAI_sub_clones%>%filter(Sample==x)%>%
                                  filter(Clone_size==max(Clone_size))%>%
                                  pull(Gene)
    subclone_size <- DTAI_sub_clones%>%filter(Sample==x)%>%
                                  filter(Clone_size==max(Clone_size))%>%
                                  pull(Clone_size)
  
    if(length(subclone_variants)>=2){
      return(setNames(data.frame(t(combn(rev(subclone_variants),2)),subclone_size,"Subclone"),c("to","from","size","Clonality")))} 
  else if(length(subclone_variants)==1){
      return(setNames(data.frame(t(c(subclone_variants,subclone_variants)),subclone_size,"Subclone"),c("to","from","size","Clonality")))} 
  else if(length(subclone_variants)==0){
      NULL
  }
}),multi_DTAI))%>%distinct()

# Now bind these two dataframe together
final_set<- rbind(genes_in_each_dominant_clone,genes_in_each_subclone)

# And remove the edges that are self referencing. We preserve the input variable so we can represent
# the vertex size in relation to total mutation burden in this subset of patients.
final_set_filtered <-final_set%>%filter(to!=from)

graph<-graph_from_data_frame(final_set_filtered,directed=F)%>%
                    set_edge_attr("weight", value = as.numeric(final_set_filtered%>%pull(size))*3) %>%
                    set_edge_attr("color", value = ifelse(final_set_filtered%>% 
                                                          pull(Clonality)=="Dominant",
                                                          brewer.pal(5,"Reds")[5],"grey20"))

mutant_counts<-table(c(as.character(final_set$to),as.character(final_set$from)))[names(V(graph))]
scaled_mutant_counts <-mutant_counts/sum(mutant_counts)*50

radian.rescale <- function(x, start=0, direction=1) {
  c.rotate <- function(x) (x + start) %% (2 * pi) * direction
  c.rotate(scales::rescale(x, c(0, 2 * pi), range(x)))
}

lab.locs <- radian.rescale(x=1:5, direction=-1, start=5)
lab.locs[3]<- -2.5

reordered_graph<-igraph::permute(graph,c(4,3,2,1,5))

pdf("Fig2c.pdf",width=5,height=5)
plot.igraph(reordered_graph,
            edge.width = E(reordered_graph)$weight,
            vertex.color=brewer.pal(5,"Reds")[5],
            vertex.frame.color=brewer.pal(5,"Reds")[5],
            vertex.size=scaled_mutant_counts[names(V(reordered_graph))], 
            vertex.label.family="Helvetica",
            vertex.label.color="black",
            vertex.label.degree=lab.locs,
            vertex.label.dist=c(3,4,3,7,3),
            layout=layout_in_circle)
dev.off()
```
### Figure 2d

```
multi_signaling<-test_set%>%filter(grepl("AML",Dx))%>%
                filter((FLT3+JAK2+NRAS+KRAS+PTPN11)>=2)%>%
                distinct(Sample)%>%pull(Sample)

signaling_dominant_clones<-clone_mutations%>%filter(Sample%in%multi_signaling)%>%
                              filter(Clonality=="Dominant")%>%
                              select(Clone_size,Sample,FLT3,JAK2,NRAS,KRAS,PTPN11)%>%
                              pivot_longer(cols=c(FLT3,JAK2,NRAS,KRAS,PTPN11),
                                           names_to="Gene",values_to="Mutated")%>%
                              filter(Mutated==1)

genes_in_each_dominant_clone<- do.call(rbind,setNames(lapply(multi_signaling,function(x){
    dominant_variants<- signaling_dominant_clones%>%filter(Sample==x)%>%pull(Gene)
    dominant_clone_size<- signaling_dominant_clones%>%filter(Sample==x)%>%pull(Clone_size)
  
    if(length(dominant_variants)>=2){
      return(setNames(data.frame(t(combn((dominant_variants),2)),dominant_clone_size,"Dominant"),c("to","from","size","Clonality")))} 
  else if(length(dominant_variants)==1){
      return(setNames(data.frame(t(c(dominant_variants,dominant_variants)),dominant_clone_size,"Subclone"),c("to","from","size","Clonality")))} 
  else if(length(dominant_variants)==0){
      NULL
  }
}),multi_signaling))%>%distinct()

signaling_sub_clones<-clone_mutations%>%filter(Sample%in%multi_signaling)%>%
                              filter(Clonality!="Dominant")%>%
                              select(Clone,Clone_size,Sample,FLT3,JAK2,NRAS,KRAS,PTPN11)%>%
                              pivot_longer(cols=c(FLT3,JAK2,NRAS,KRAS,PTPN11),
                                           names_to="Gene",values_to="Mutated")%>%
                              filter(Mutated==1)%>%
                              group_by(Clone,Sample)%>%
                              add_tally()%>%filter(n>1)%>%
                              ungroup()

genes_in_each_subclone<- do.call(rbind,setNames(lapply(multi_signaling,function(x){
    subclone_variants<- signaling_sub_clones%>%filter(Sample==x)%>%
                                  filter(Clone_size==max(Clone_size))%>%pull(Gene)
    subclone_size<- signaling_sub_clones%>%filter(Sample==x)%>%
                                  filter(Clone_size==max(Clone_size))%>%pull(Clone_size)
  
    if(length(subclone_variants)>=2){
      return(setNames(data.frame(t(combn((subclone_variants),2)),subclone_size,"Subclone"),c("to","from","size","Clonality")))} 
  else if(length(subclone_variants)==1){
      return(setNames(data.frame(t(c(subclone_variants,subclone_variants)),subclone_size,"Subclone"),c("to","from","size","Clonality")))} 
  else if(length(subclone_variants)==0){
      NULL
  }
}),multi_signaling))%>%distinct()


final_set<- rbind(genes_in_each_dominant_clone,genes_in_each_subclone)

final_set_filtered <-final_set%>%filter(to!=from)

graph<-graph_from_data_frame(final_set_filtered,directed=F)%>%
                    set_edge_attr("weight", value = as.numeric(final_set_filtered%>%pull(size))*3) %>%
                    set_edge_attr("color", value = ifelse(final_set_filtered%>% 
                                                          pull(Clonality)=="Dominant",
                                                          brewer.pal(5,"Reds")[5],"grey20"))

mutant_counts<-table(c(as.character(final_set$to),as.character(final_set$from)))[names(V(graph))]
scaled_mutant_counts <-mutant_counts/sum(mutant_counts)*50
radian.rescale <- function(x, start=0, direction=1) {
  c.rotate <- function(x) (x + start) %% (2 * pi) * direction
  c.rotate(scales::rescale(x, c(0, 2 * pi), range(x)))
}

lab.locs <- radian.rescale(x=1:5, direction=-1, start=5)
lab.locs[3]<- -2.5

reordered_graph<-igraph::permute(graph,c(5,2,4,1,3))

pdf("Fig2d.pdf",width=5,height=5)
plot.igraph(reordered_graph,
            edge.width = E(reordered_graph)$weight,
            vertex.color=brewer.pal(5,"Reds")[5],
            vertex.frame.color=brewer.pal(5,"Reds")[5],
            vertex.size=scaled_mutant_counts[names(V(reordered_graph))], 
            vertex.label.family="Helvetica",
            vertex.label.color="black",
            vertex.label.degree=lab.locs,
            vertex.label.dist=c(3,4,3,7,3),
            layout=layout_in_circle)
dev.off()
```
