# BENG 469 Lab session 7 - instructions

## Schematic DBiT-Seq workflow

<p><img src="https://github.com/MingyuYang-Yale/DBiT-seq/blob/master/workflow.png" alt="foo bar" title="train &amp; tracks" /></p>

#### Open OOD in a browser window

```
beng469.ycrc.yale.edu
```

<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood.png" alt="foo bar" title="train &amp; tracks" /></p>

Click **Clusters** -> **shell access**
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-ssh-login.png" alt="foo bar" title="train &amp; tracks" /></p>

Use ```ls``` command to list files and directories.
```
ls -lrt
```
Use ```getquota``` command to monitor current storage usage
```
getquota
```
Go to **palmer_scratch** directory, ```cd``` stands for “change directory”
```
cd palmer_scratch 
```
Then create a new directory called **Lab7-Spatial_transcriptomics**, ```mkdir``` stands for "make directory"
```
mkdir Lab7-Spatial_transcriptomics
```
Then go to the Lab7-Spatial_transcriptomics directory
```
cd Lab7-Spatial_transcriptomics
```
The raw data we will use today is located in the following folder:
```
ls -lrt /vast/palmer/scratch/fan/my393/BENG469/L7/01.demo_data/GSM4189611_50t
```

- Read 1 containing the spatial information and the UMI
  <p><img width="300" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/read1.png" alt="foo bar" title="train &amp; tracks" /></p>
- Read 2 containing the genomic sequence

```
less -S /vast/palmer/scratch/fan/my393/BENG469/L7/01.demo_data/GSM4189611_50t/GSM4189611_50t.R2.fastq.gz
```

* Use ```space``` to go to the next page, ```b``` move up one page.
* Use ```arrow``` key:arrow_down: :arrow_up: to go down or go up just one line at a time. 
* Use ```q``` key to quit out ```less```.

FASTQ files
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/fastq.png" alt="foo bar" title="train &amp; tracks" /></p>

- A sequence identifier with information about the sequencing run and the cluster.
- The sequence (the bases; A, C, T, G and N).
- A separator, which is simply a plus (+) sign.
- The base quality scores. Using ASCII characters to represent the numerical quality scores.

---

### [ST pipeline](https://academic.oup.com/bioinformatics/article/33/16/2591/3111847)

<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/stpipeline-5.png" alt="foo bar" title="train &amp; tracks" /></p>


##### Basically what the [ST pipeline](https://academic.oup.com/bioinformatics/article/33/16/2591/3111847) does is :

1. Quality trimming (read 1 and read 2) :
2. Contaminant filter e.x. rRNA genome (Optional)
3. Mapping with STAR (only read 2)
4. Demultiplexing with Taggd (only read 1)
6. Annotate the reads with htseq-count


#### Install [Stpipeline](https://github.com/SpatialTranscriptomicsResearch/st_pipeline):
```
salloc
```
```
module load miniconda
```
```
conda create -y -n st-pipeline python=3.7
```
```
conda activate st-pipeline
```
```
conda install -y Numpy Cython
```
```
conda install -y -c bioconda star samtools
```

```
pip install 'pysam==0.15.4' taggd stpipeline
```
```
st_pipeline_run.py -h
```
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/stpipeline-3.png" alt="foo bar" title="train &amp; tracks" /></p>


Copy the stpipeline.sh to your directory, ```cp``` stands for copy.
```
cp /vast/palmer/scratch/fan/my393/BENG469/L7/00.sh/stpipeline.sh ./
```
```
cat stpipeline.sh
```

```
head /vast/palmer/scratch/fan/my393/BENG469/L7/00.database/barcodes-AB.xls
```


Submit a batch job to compute node
```
sbatch stpipeline.sh NETID --mail-user=xx.xx@yale.edu
```
View information about your job
```
squeue --me
```
You will receive an email said your job has **Began**:

<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/notifications1.png" alt="foo bar" title="train &amp; tracks" /></p>

You will also receive an email said your job has **COMPLETED**:

<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/notifications2.png" alt="foo bar" title="train &amp; tracks" /></p>

If you receive email notifications says **Failed**, please contact us immediately.


This job will take ~1.5hr. You will get the spatial gene expression matrix like this:

```
less -S /vast/palmer/scratch/fan/my393/BENG469/L7/01.demo_data/GSM4189611_50t.tsv
```
---
### Downstream analysis:
#### Copy Rmd files to you folder
```
cp /vast/palmer/scratch/fan/my393/BENG469/L7/00.bin/Lab7-DBiT-seq.Rmd ./
```

#### Launch an Rstudio-server session:
   
Go to the Rstudio-server initialization page, and specify the parameters/resources as follows:

| Parameters      | Values |
| ----------- | ----------- |
| R version      | R/4.2.0-foss-2020b       |
| Number of hours   | 6        |
| Number of CPU cores per node   | 1        |
| Memory per CPU core in GiB   | 8       |
| Partitions   | day        |


<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/rsession1.png" alt="foo bar" title="train &amp; tracks" /></p>


```
~/palmer_scratch/Lab7-Spatial_transcriptomics
```

SpatialDE
```
salloc
```
```
module load miniconda
```
```
conda create -n spatialde python=3.7
```
```
conda activate spatialde
```
```
pip install numpy pandas matplotlib jupyter patsy
```
```
pip install spatialde
```
```
module purge
```
```
ycrc_conda_env.sh update
```

conda env remove --name spatialde

```

#### Launch an Rstudio-server session:
   
Go to the Jupyter initialization page, and specify the parameters/resources as follows:

| Parameters      | Values |
| ----------- | ----------- |
| Environment Setup | spatialde  |
| Number of hours   | 6        |
| Number of CPU cores per node   | 1        |
| Memory per CPU core in GiB   | 8       |
| Partitions   | day        |
|Reservation (optional) | beng469 |


Go to the Rstudio-server initialization page, and specify the parameters/resources as follows:

| Parameters      | Values |
| ----------- | ----------- |
| R version      | R/4.2.0-foss-2020b       |
| Number of hours   | 6        |
| Number of CPU cores per node   | 1        |
| Memory per CPU core in GiB   | 8       |
| Partitions   | day        |




Assignment 2:

