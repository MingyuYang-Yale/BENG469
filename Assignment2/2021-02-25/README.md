***
#### Login HPC:
(need to connect to Yale's **VPN** if off campus)

```
ssh beng469_my393@farnam.hpc.yale.edu
```
```
srun --pty -p interactive --mem=50g bash
```
```
cd project
```
```
cd Assignment2-SNV
```

***
#### open R

```
module load R/3.6.1-foss-2018b
```
```
R
```
***

### Extract SNV data 
```r
# Load in the relevant packages will use later.

options(stringsAsFactors = FALSE)
library(plyranges)
library(VariantAnnotation)
library(BSgenome.Hsapiens.UCSC.hg19)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(dplyr)
library(tidyr)
library(purrr)
library(tapestri)


```
```r
# extract_genotypes

# Calls are made by GATK/Haplotypecaller
# genotype call converted to categorical (0-reference, 1-heterozygous mutation, 2-homozygous mutation, 3-unknown). 

sample_set <- list.files("./data/",full.names = TRUE)
names(sample_set) <-list.files("./data/")
system("mkdir ./analysis")

for(i in names(sample_set)){
  barcode_files<-grep("barcode",list.files(sample_set[i],full.names=TRUE),value=TRUE)
  loom_files<-grep("loom$",list.files(sample_set[i],full.names=TRUE),value=TRUE)
  header_files<-grep("vcf_header.txt$",list.files(sample_set[i],full.names=TRUE),value=TRUE)
  barcodes <- read_barcodes(barcode_files,header_files)
  loom <- connect_to_loom(loom_files)
  ngt_file <- extract_genotypes(loom, barcodes, 
                              gt.filter=TRUE, gt.gqc = 30,
                              gt.dpc = 10, gt.afc = 20,  gt.mv = 50, 
                              gt.mc = 50, gt.mm = 1, gt.mask = TRUE)
  snv <- convert_to_analyte(data=as.data.frame(ngt_file),
                             type='snv',
                             name=i)
  saveRDS(snv,paste0("./analysis/",i,".rds"))
  #write.table(snv,file=sprintf("./analysis/%s.xls",i),sep="\t")
  #readRDS(file="./analysis/MSK71.rds")
}

```


```r
# Read the files back and put them into a list.


processed_SNV_files <-grep("MSK",list.files("./analysis/",full.names = TRUE),value=TRUE)
names(processed_SNV_files)<-do.call(rbind,strsplit(grep("MSK",list.files("./analysis/"),value=TRUE),split="\\."))[,1]

SNV<-setNames(lapply(names(processed_SNV_files),function(x){
  y<-readRDS(processed_SNV_files[x])
  data.frame("Cell"=rownames(y), # moving the cell name into data.frame prevents some errors later
             y$data) # extracts the genotype matrix from the analyte object
}), names(processed_SNV_files))
```


```r
# Filter variants through a blacklist removing recurrent variants that they think are likely sequencing errors 
# Annotating SNVS for protein coding functions, and removing synonymous and splice variants 

txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
blacklist <-read.csv("/gpfs/ysm/project/beng469/beng469_my393/00.database/banned_list.csv")

# names(SNV)
# x <- SNV[[‘MSK103’]]
# colnames(x)

variants <- lapply(SNV,function(x){
  experimental_variants <- colnames(x)[ !grepl("Cell",colnames(x))& #remove the Cell column
                                        !grepl("^chr",colnames(x))& #remove control loci
                                        !colnames(x)%in%blacklist[,1]] #remove blacklsited SNVs
  variants_matrix<-data.frame(experimental_variants,
                                do.call(rbind,strsplit(experimental_variants,split="\\.")))
  colnames(variants_matrix) <- c("SNV","gene","chr","start","ref","alt")
  variants_matrix$ref<-as(variants_matrix$ref, "DNAStringSet")
  variants_matrix$alt<-as(variants_matrix$alt, "DNAStringSet")
  variant_gRange<-makeGRangesFromDataFrame(variants_matrix,
                                           seqnames.field = "chr",
                                           start.field="start",
                                           end.field="start",
                                           keep.extra.columns=TRUE)
  out<-  predictCoding(variant_gRange, txdb, seqSource=Hsapiens,varAllele=variant_gRange$alt)
  out2<-out%>%filter(CONSEQUENCE=="nonsynonymous")%>%
              mutate(AA=paste0(gene,".",REFAA,PROTEINLOC,VARAA))%>%
              select(SNV,AA)
  return(data.frame(out2)%>%distinct(SNV,AA))
  })
  
```


```r
# Remove variants that are mutated in <2 cells 
# Remove remaining cells with any unknown genotypes
# genotype call converted to categorical (0-reference, 1-heterozygous mutation, 2-homozygous mutation, 3-unknown). 



filtered_NGT<-setNames(lapply(names(SNV),function(sample){
  setNames(data.frame(SNV[[sample]][,c("Cell",as.character(variants[[sample]]$SNV))]),
           c("Cell",variants[[sample]]$AA))
}),names(SNV))

final_NGTs<-setNames(lapply(names(filtered_NGT),function(x){
    filtered_NGT[[x]] %>% 
                    select_if(~ !is.numeric(.) || sum(.%in%c(1,2))>=2) %>%
                    filter_all(all_vars(.!=3)) %>%
                    select_if(~ !is.numeric(.) || sum(.%in%c(1,2))>=2) 
}),names(filtered_NGT))
```

### Assessing clonal abundance

```r
# Select samples with at least 2 mutations 

clonal_sample_set <- names(final_NGTs)[do.call(rbind,lapply(final_NGTs,dim))[,2]>2]

# Order columns based on computed_VAF, and assign a clone to each cell

NGT_to_clone<-lapply(final_NGTs[clonal_sample_set],function(y){
  bulk_VAF_order <-names(sort(colSums(y[,-1]),decreasing=TRUE))
  y[,c("Cell",bulk_VAF_order)] %>%unite("Clone",all_of(`bulk_VAF_order`),sep="_", remove = FALSE)
 })

# Tally clones
clonal_abundance<- lapply(NGT_to_clone,function(x){
  x%>%count(Clone,name="Count")%>%arrange(Count)
 })
```

```r
# Setup a resampling function to generate multiple clonal abundance tallies
resample_fun<-function(data){
  x <- data[sample(x=1:nrow(data),replace=TRUE),]
  return(as.matrix(x%>%count(Clone,name="Count")%>%arrange(Count)))
}

replicates <- 100 # we did 10,000. Keeping it low here for run time.
clone_cutoff <- 10 # minimum number of cells in order to retain a clone
clonal_abundance_boot_CI <- lapply(names(NGT_to_clone),function(sample_to_test){
    test<-replicate(n=replicates,resample_fun(NGT_to_clone[[sample_to_test]]),simplify = "array")
    if(class(test)=="list"){
      y <- setNames(lapply(test,data.frame),1:replicates) %>%
           imap(.x = ., ~ set_names(.x, c("Clone", .y))) %>% 
           purrr::reduce(full_join, by = "Clone")%>%
           mutate_if(names(.)!="Clone",as.numeric)%>%
           mutate_each(funs(replace(., is.na(.), 0)))
      }
    if(class(test)=="array"){
      y <- setNames(apply(test,3,data.frame),1:replicates) %>%
           imap(.x = ., ~ set_names(.x, c("Clone", .y))) %>% 
           purrr::reduce(full_join, by = "Clone")%>%
           mutate_if(names(.)!="Clone",as.numeric)%>%
           mutate_each(funs(replace(., is.na(.), 0)))
      }
    z <- data.frame(t(apply(y%>%select(-Clone),1,function(p){
            quantile(p,probs=c(0.025,0.975))
         })),"Clone"=y$Clone)
    set <- setNames(data.frame(inner_join(data.frame(clonal_abundance[[sample_to_test]]),z,by="Clone")),
                  c("Clone","Count","LCI","UCI"))%>%filter(LCI>=clone_cutoff)
})
names(clonal_abundance_boot_CI) <-names(clonal_abundance)
```

```r
# Now that we have a set of clones that we believe reproducibily have at least 10 cells. 
# We remove cells and variants that are no longer represented at sufficient coverage.

clone_filtered_NGTs <- setNames(lapply(names(clonal_abundance_boot_CI),function(sample_to_test){

  # Determine if there are any clones left to process
  if(nrow(clonal_abundance_boot_CI[[sample_to_test]])==0) {
    return("No clones after boostrapping")
  }
  
  # Determine if there are any mutations that are no longer found in a stable clone
  clone_matrix<-as.matrix(do.call(rbind,
                                strsplit(clonal_abundance_boot_CI[[sample_to_test]][,"Clone"],split="_")))
  mode(clone_matrix) <- "numeric"
  colnames(clone_matrix) <-colnames(NGT_to_clone[[sample_to_test]])[-c(1,2)]
  variants_to_remove<-names(which(colSums(clone_matrix)==0))

  # Check other conditions of interest that might remove sample from further processing
  if(nrow(clone_matrix)==1) {
    return("Only 1 clone left")
  }else  if(length(setdiff(colnames(clone_matrix),c(variants_to_remove)))<=1){
    return("Removed all but 1 variant")
  }else {
      # Select only clones that survive the bootstrapping, and remove variants that fall out
      NGT_to_clone_subset <- NGT_to_clone[[sample_to_test]]%>%
                                filter(Clone%in%clonal_abundance_boot_CI[[sample_to_test]]$Clone)%>%
                                select(!all_of(variants_to_remove))
        
      # Create a key for the new and old clone names after removing variants that are no longer present
      clone_key <- data.frame("New"=apply(data.frame(clone_matrix)%>%select(!all_of(variants_to_remove)),MARGIN=1,
                                            function(x){ paste(x,sep="_",collapse="_")}),
                                "Old"=apply(data.frame(clone_matrix),MARGIN=1,
                                            function(x){ paste(x,sep="_",collapse="_")}))
        
      # If there are any variants to remove and clones that need to be renamed
      if(any(clone_key$New!=clone_key$Old)){
            NGT_to_clone_subset$Clone <- sapply(NGT_to_clone_subset$Clone,function(x){
                                              clone_key$New[match(x,clone_key$Old)]})
      }
      return(NGT_to_clone_subset)
    }
}),names(clonal_abundance_boot_CI))
```

```r
# explicitly state the genotype of each mutation in each clone

clonal_architecture <- setNames(lapply(names(clonal_abundance_boot_CI),function(test_sample){

  clonal_architecture<-clone_filtered_NGTs[[test_sample]]%>%
                                            select(!Cell)%>% 
                                            distinct()%>%
                                            pivot_longer(cols=!Clone,
                                                         names_to="Mutant",
                                                         values_to="Genotype") %>%
                                            mutate(Genotype=ifelse(Genotype==3,NA,
                                                             ifelse(Genotype==0,"WT",
                                                              ifelse(Genotype==1,"Heterozygous",                                                                          ifelse(Genotype==2,"Homozygous",NA)))))
}), names(clonal_abundance_boot_CI))
```

```r
#package everything together into a list format for easy access later

final_sample_summary<-setNames(lapply(names(clonal_architecture),function(sample){
   return(list("Clones"=clonal_abundance_boot_CI[[sample]],
               "NGT"=clone_filtered_NGTs[[sample]],
               "Architecture"=clonal_architecture[[sample]]))
}),names(clonal_abundance_boot_CI))

saveRDS(final_sample_summary,file="./analysis/final_sample_summary.rds")
#final_sample_summary<-readRDS(file="final_sample_summary.rds")
```
```r
quit()
```


***
Rstudio ( https://rstudio.cloud/ )

```
scp -r beng469_my393@farnam2.hpc.yale.edu:/gpfs/ysm/project/beng469/beng469_my393/Assignment2-SNV/scDNA_myeloid_data ~/Downloads/
```

