# BENG469 - LAB10

Open OOD site : <a href="https://beng469f.ycrc.yale.edu/"> **beng469f.ycrc.yale.edu** </a>

Click **Clusters** -> **shell access**

## DeepCell environment setup
```
salloc --mem=16g
```
```
cd project_beng469f/beng469f_NETID   # remember to replace NETID with your own
```
```
mkdir Lab10
```
```
cd Lab10
```
```
module load miniconda
```
```
conda env create -f /nfs/roberts/project/beng469f/shared/Lab10/deepcell_updated.yml
```
```
ycrc_conda_env.sh update
```
```
cp -r /nfs/roberts/project/beng469f/shared/Lab10/applications/ ./
```

### Start Jupyter notebook with DeepCell pipeline

| **Parameters**      | **Values** |
| ----------- | ----------- |
|version | conda:deepcell|
| Number of hours   | 6        |
| Number of CPU cores per node   | 4        |
| Memory per CPU core in GiB   | 16       |
| Partitions   |  education/devel/day     |

<p><img width="400" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/FA25/Lab10/jupyte.png" alt="foo bar" title="train &amp; tracks" />
