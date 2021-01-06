***
In this tutorial, we will learn how to analyze data from this Nature paper:https://www.nature.com/articles/s41586-020-2864-x

<p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Nature-paper.png" alt="foo bar" title="train &amp; tracks" /></p>

***
They used a commercial platform from **Mission Bio** called **Tapestri**. The methodology uses single cell droplet encapsulation and barcoded beads to perform amplicon next generation sequencing. 
<p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Pipeline.png" alt="foo bar" title="train &amp; tracks" /></p>

Much of the upfront analysis is performed on the Tapestri Pipeline produced by Mission Bio available on the Bluebee platform. 

Here we will primarily with how the data was processed downstream in R and to the right of the red dashed line. Our primary output from Bluebee as the .loom file which contained a useful formating of the multi sample VCF file produced by GATK. For the publication, this .loom file was loaded into Tapestri Insights, a GUI from Mission Bio that allowed for sample filtering based on parameters described in the manuscript. From there a filtered set of cells were exported from Tapestri Insights, and matrices for each column of the VCF file were produced. I will include some of this code and decription of why we did it this way in an Appendix A, but since then, MissionBio has releassed a convenient R package and I find all future analyses will go from there. So, instead, this guide will use their package, I anticipate some of the data might change from our publication, but I guess we’ll see.
***
Login HPC:(need to connect to Yale's **VPN** if off campus)

```
ssh -Y beng469_my393@farnam.hpc.yale.edu
srun --pty --x11 -p interactive --mem=50g bash
cd /gpfs/ysm/project/beng469/beng469_my393
```
```
mkdir Assignment3-SNV && cd Assignment3-SNV
```

***
Download Data:

Critical files used for analysis can be found on google drive: https://drive.google.com/drive/folders/17Zw6Ixu93UM7M5Vyl_aOJ7aX2iYIb8If

```
wget https://raw.githubusercontent.com/circulosmeos/gdown.pl/master/gdown.pl
```
```
chmod +x gdown.pl
```

change the first line to : **#!/usr/bin/perl**
```
vi gdown.pl
```
```
cp /gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV/download.sh ./
```
```
sh download.sh
```
```
for i in MSK15 MSK18 MSK71 MSK91 MSK103 MSK130;do mkdir $i; mv $i* $i;done
```
```
mkdir data
```
```
mv MSK* data
```
***
open R
```
module load R/3.6.1-foss-2018b
```
```
R
```

Install related R packages:
```
if (!requireNamespace("BiocManager", quietly = TRUE)) 
     install.packages("BiocManager")
```
```
BiocManager::install("VariantAnnotation") # will take ~10 minutes
BiocManager::install("plyranges")
BiocManager::install("BSgenome.Hsapiens.UCSC.hg19")
BiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene")

install.packages(c("devtools", "hdf5r", "digest"))
devtools::install_github("mojaveazure/loomR")
devtools::install_github("jokergoo/ComplexHeatmap")
BiocManager::install("karyoploteR")
BiocManager::install("annotatr")
BiocManager::install("org.Hs.eg.db")
```
Download tapestri R package:

```
#Open a new Terminal window

cd /gpfs/ysm/project/beng469/beng469_my393

https://portal.missionbio.com/

(https://support.missionbio.com/hc/en-us/articles/360045899834-Installation-instructions-for-tapestri-R)

#cp /gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV/tapestri_1.1.0.tar.gz ./
```
Install tapestri R package (~10mins)
```
devtools::install_local(path = "tapestri_1.1.0.tar.gz", repos='http://cran.us.r-project.org', upgrade="never")
```

```
setwd("/gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV")
options(stringsAsFactors = FALSE)

library(plyranges)
library(VariantAnnotation)
library(BSgenome.Hsapiens.UCSC.hg19)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(dplyr)
library(tidyr)
library(purrr)
library(tapestri)

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
}
```
