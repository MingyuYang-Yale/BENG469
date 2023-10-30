```
cd project
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
conda install -c bioconda samtools openssl=1.0
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
