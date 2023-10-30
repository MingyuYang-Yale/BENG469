Open McCleary OnDemand at beng469.ycrc.yale.edu in a browser window
```
beng469.ycrc.yale.edu
```
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood.png" alt="foo bar" title="train &amp; tracks" /></p>

- click **Clusters** -> **shell access**
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-ssh-login.png" alt="foo bar" title="train &amp; tracks" /></p>

Proceed ([y]/n)? y

```
cd project
```
```
mkdir Lab7-Spatial_transcriptomics
```
```
cd Lab7-Spatial_transcriptomics
```
```
salloc
```
```
module load miniconda
```
```
conda create -n st-pipeline python=3.7
```
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
