Open McCleary OnDemand at ```beng469.ycrc.yale.edu``` in a browser window

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood.png" alt="foo bar" title="train &amp; tracks" /></p>

- click **Clusters** -> **shell access**
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-ssh-login.png" alt="foo bar" title="train &amp; tracks" /></p>

First go to our **project** directory, ```cd``` stands for “change directory”
```
cd project 
```
Then create a new directory called **Lab7-Spatial_transcriptomics**, ```mkdir``` stands for "make directory"
```
mkdir Lab7-Spatial_transcriptomics
```
Then go to the Lab7-Spatial_transcriptomics directory
```
cd Lab7-Spatial_transcriptomics
```

### Install [Stpipeline](https://github.com/SpatialTranscriptomicsResearch/st_pipeline):

#### Basically what the [ST pipeline](https://academic.oup.com/bioinformatics/article/33/16/2591/3111847) does is :

1. Quality trimming (read 1 and read 2) :
2. Remove low quality bases
3. Contamimant filter e.x. rRNA genome (Optional)
4. Mapping with STAR (only read 2)
5. Demultiplexing with Taggd (only read 1)
6. Annotate the reads with htseq-count

```
salloc
```
```
module load miniconda
```
```
conda create -n st-pipeline python=3.7
```
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/stpipeline-1.png" alt="foo bar" title="train &amp; tracks" /></p>

Proceed ([y]/n)? **y**

```
conda activate st-pipeline
```
```
conda install Numpy Cython
```
```
conda install -c bioconda star samtools
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

### Launch an Rstudio-server session:
   
Go to the Rstudio-server initialization page, and specify the parameters/resources as follows:

| Parameters      | Values |
| ----------- | ----------- |
| R version      | R/4.2.0-foss-2020b       |
| Number of hours   | 6        |
| Number of CPU cores per node   | 4        |
| Memory per CPU core in GiB   | 4       |
| Partitions   | day        |
| Reservation (optional)   |       |
| Additional modules (optional)  | Python/3.8.6-GCCcore-10.2.0   |
|User defined environment variables for .Renviron (optional)|PYTHONPATH=/gpfs/gibbs/project/beng469/beng469_my393/Python3.8/site-packages|


<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/rsession1.png" alt="foo bar" title="train &amp; tracks" /></p>

```
/vast/palmer/scratch/fan/my393/BENG469/L7/00.bin
```
