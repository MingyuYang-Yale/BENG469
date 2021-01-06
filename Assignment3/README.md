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

module load R/3.6.1-foss-2018b

R

setwd("/gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV/datasets")

options(stringsAsFactors = FALSE)

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("VariantAnnotation")
BiocManager::install("plyranges")
BiocManager::install("BSgenome.Hsapiens.UCSC.hg19")
BiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene")

devtools::install_github("r-lib/usethis")
install.packages(c("devtools", "hdf5r", "digest"))


devtools::install_github("mojaveazure/loomR")
devtools::install_github("jokergoo/ComplexHeatmap")
BiocManager::install("karyoploteR")

library(plyranges)
library(VariantAnnotation)
library(BSgenome.Hsapiens.UCSC.hg19)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(dplyr)
library(tidyr)
library(purrr)
