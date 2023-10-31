Open McCleary OnDemand at ```beng469.ycrc.yale.edu``` in a browser window

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood.png" alt="foo bar" title="train &amp; tracks" /></p>

- click **Clusters** -> **shell access**
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-ssh-login.png" alt="foo bar" title="train &amp; tracks" /></p>

```
cd project
```
```
mkdir Lab7-Spatial_transcriptomics
```
```
cd Lab7-Spatial_transcriptomics
```

### Install [Stpipeline](https://github.com/SpatialTranscriptomicsResearch/st_pipeline):

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
conda install Numpy
```
```
conda install Cython
```
```
conda install -c bioconda star
```
```
conda install -c bioconda samtools
```
```
pip install 'pysam==0.15.4'
```
```
pip install taggd
```

```
pip install stpipeline
```
```
st_pipeline_run.py -h
```
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/stpipeline-3.png" alt="foo bar" title="train &amp; tracks" /></p>

```
cp stpipeline.sh ./
```
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/change-email.png" alt="foo bar" title="train &amp; tracks" /></p>

```
sbatch stpipeline.sh my393 --mail-user=mingyu.yang@yale.edu
```

<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/notification.png" alt="foo bar" title="train &amp; tracks" /></p>



### Launch an Rstudio-server session:
   
Go to the Rstudio-server initialization page, and specify the parameters/resources as follows:

| Parameters      | Values |
| ----------- | ----------- |
| R version      | R/4.2.0-foss-2020b       |
| Number of hours   | 6        |
| Number of CPU cores per node   | 4        |
| Memory per CPU core in GiB   | 10       |
| Partitions   | day        |
| Reservation (optional)   |       |
| Additional modules (optional)  |   |
