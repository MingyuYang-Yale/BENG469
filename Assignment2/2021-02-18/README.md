
***
<p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment2/Nature-paper.png" alt="foo bar" title="train &amp; tracks" /></p>

***
They used a commercial platform from **Mission Bio** called **Tapestri**. The methodology uses single cell droplet encapsulation and barcoded beads to perform amplicon next generation sequencing. 
<p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment2/Pipeline.png" alt="foo bar" title="train &amp; tracks" /></p>

***
### Login HPC:
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
mkdir Assignment2-SNV && cd Assignment2-SNV
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



### Download tapestri R package:

**Tapestri Portal**(https://portal.missionbio.com/)

#### Open a new Terminal window

```
scp ~/Downloads/tapestri_1.1.0.tar.gz beng469_my393@farnam.hpc.yale.edu:/gpfs/ysm/project/beng469/beng469_my393/Assignment2-SNV
```
#### or 
```
cp /gpfs/ysm/project/beng469/beng469_my393/00.software/tapestri_1.1.0.tar.gz ./
```

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


### Install related R packages（～20mins）

Install each package independently because the install script may prompt you to update previously downloaded packages.

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) 
     install.packages("BiocManager")    
```
```r
BiocManager::install("VariantAnnotation")
```
```r
BiocManager::install("plyranges")
```
```r
BiocManager::install("BSgenome.Hsapiens.UCSC.hg19")
```
```r
BiocManager::install("TxDb.Hsapiens.UCSC.hg19.knownGene")
```
```r
install.packages(c("devtools", "hdf5r", "digest"))
```

```r
devtools::install_github("mojaveazure/loomR")
```
```r
devtools::install_github("jokergoo/ComplexHeatmap")
```
```r
BiocManager::install("karyoploteR")
```
```r
BiocManager::install("annotatr")
```
```r
BiocManager::install("org.Hs.eg.db")
```
```r
devtools::install_local(path = "tapestri_1.1.0.tar.gz", repos='http://cran.us.r-project.org', upgrade="never")
```
***

***
#### Open OnDemand and Command-line

Have both normal account (lab account) and class account on the cluster
Only one is allowed for OOD
Normal account is preferred

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment2/ood.png" alt="foo bar" title="train &amp; tracks" /></p>

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment2/rstudio.png" alt="foo bar" title="train &amp; tracks" /></p>

---
## Graphical Environments for Clusters
To use a graphical interface on the clusters, your connection needs to be set up for X11 forwarding, which will transmit the graphical window from the cluster back to your local machine. .

#### Setup X11 (On macOS)
* Download and install XQuartz(https://www.xquartz.org)
* open a termianl window, and run:
```
launchctl load -w /Library/LaunchAgents/org.macosforge.xquartz.startx.plist
```
* Log out(```quit```) and log back in to your Mac to reset some variables.
**(quit and reopen terminal window)**
```
echo $DISPLAY
```
the terminal should respond : " /private/tmp/com.apple.launchd.y8vzcm7AMF/org.macosforge.xquartz:0 "

#### Test X11
When using ssh to log in to the clusters, use the ```-Y``` option to enable X11 forwarding. Example: ssh -Y
```
ssh -Y beng469_my393@farnam.hpc.yale.edu
```
```
srun --pty --x11 -p interactive --mem=20g bash
```
```
xclock
```
