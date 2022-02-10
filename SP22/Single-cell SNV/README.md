<p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment2/Nature-paper.png" alt="foo bar" title="train &amp; tracks" /></p>

***
They used a commercial platform from **Mission Bio** called **Tapestri**. The methodology uses single cell droplet encapsulation and barcoded beads to perform amplicon next generation sequencing. 
<p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment2/Pipeline.png" alt="foo bar" title="train &amp; tracks" /></p>

***
### Login HPC:
(need to connect to Yale's **VPN** if off campus)

```
ssh beng469_my393@farnam.hpc.yale.edu
```
```
srun --pty -p interactive --mem=10g bash
```
```
cd project
```
```
mkdir scDNA-SNV && cd scDNA-SNV
```

***
### Download Data:

Critical files used for analysis can be found on google drive: https://drive.google.com/drive/folders/17Zw6Ixu93UM7M5Vyl_aOJ7aX2iYIb8If

```
wget https://raw.githubusercontent.com/circulosmeos/gdown.pl/master/gdown.pl
```
```
chmod +x gdown.pl
```
```
cp /gpfs/ysm/project/beng469/beng469_my393/00.sh/download.sh ./
```
```
sh download.sh
```
*.loom file which contained a useful formating VCF file produced by GATK.

```
for i in MSK15 MSK18 MSK71 MSK91 MSK103 MSK130;do mkdir $i; mv $i\_* $i;done
```
```
mkdir data
```
```
mv MSK* data
```
***

***
open R
```
module avail R/3.6
```
```
module load R/3.6.1-foss-2018b
```
```
R
```
### Install related R packages

***

### Tapestri package:

We will use the tapestri R package to extract the data.

Before we install the Tapestri package, we need to install the related R packages first.

The following steps will take ~30 minutes.
```r
if (!requireNamespace("BiocManager", quietly = TRUE)) 
     install.packages("BiocManager")    

BiocManager::install("VariantAnnotation")
BiocManager::install("plyranges")
BiocManager::install("BSgenome.Hsapiens.UCSC.hg19")
BiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene")
BiocManager::install("rhdf5")

install.packages(c("devtools", "digest"))

devtools::install_github("mojaveazure/loomR")
devtools::install_github("jokergoo/circlize")
devtools::install_github("jokergoo/ComplexHeatmap")

BiocManager::install("karyoploteR")
BiocManager::install("annotatr")
BiocManager::install("org.Hs.eg.db")
```

```r
devtools::install_local(path = "/gpfs/ysm/project/beng469/beng469_my393/00.software/tapestri_1.1.0.tar.gz", repos='http://cran.us.r-project.org', upgrade="never")
```
***

#### Or 

Just use the following R library path: 
```r
.libPaths("/gpfs/ysm/project/beng469/beng469_my393/R/x86_64-pc-linux-gnu-library/3.6")
```
***
