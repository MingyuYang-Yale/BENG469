ssh -Y beng469_my393@farnam.hpc.yale.edu
srun --pty --x11 -p interactive --mem=20g bash
cd /gpfs/ysm/project/beng469/beng469_my393

mkdir Assignment3-SNV && cd Assignment3-SNV

Download Data:

Critical files used for analysis can be found on google drive: https://drive.google.com/drive/folders/17Zw6Ixu93UM7M5Vyl_aOJ7aX2iYIb8If

mkdir datasets && cd datasets

wget https://raw.githubusercontent.com/circulosmeos/gdown.pl/master/gdown.pl
chmod +x gdown.pl

change the first line:
#!/usr/bin/perl

cp /gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV/download.sh ./
sh download.sh

mkdir data
mkdir analysis

mv MSK* data

cd data

for i in MSK15 MSK18 MSK71 MSK91 MSK103 MSK130;do mkdir $i; mv $i* $i;done

cd ../

module load R/3.6.1-foss-2018b

R

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("VariantAnnotation")
BiocManager::install("plyranges")
BiocManager::install("BSgenome.Hsapiens.UCSC.hg19")
BiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene")
BiocManager::install("karyoploteR")
BiocManager::install("annotatr")
BiocManager::install("org.Hs.eg.db")

#devtools::install_github("r-lib/usethis")
#install.packages(c("devtools", "hdf5r", "digest"))

install.packages("devtools")
devtools::install_github("mojaveazure/loomR")
devtools::install_github("jokergoo/ComplexHeatmap")
devtools::install_local(path = "tapestri_1.1.0.tar.gz", repos='http://cran.us.r-project.org', upgrade="never")

https://portal.missionbio.com/. 
https://support.missionbio.com/hc/en-us/articles/360045899834-Installation-instructions-for-tapestri-R

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


