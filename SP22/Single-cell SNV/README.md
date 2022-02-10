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
