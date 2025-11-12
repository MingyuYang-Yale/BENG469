# BENG469 - LAB9

Open OOD site : <a href="https://beng469f.ycrc.yale.edu/"> **beng469f.ycrc.yale.edu** </a>

## SpatialGlue environment setup

```
salloc --mem=16g
```
```
cd project_beng469f/beng469_NETID
```
```
mkdir Lab9 && cd Lab9
```
```
module load miniconda
```
```
conda env create -f ./project_beng469f/shared/SpatialGlue/SpatialGlue.yml
```
```
ycrc_conda_env.sh update
```
```
cp /nfs/roberts/project/beng469f/shared/SpatialGlue/SpatialGlue.ipynb ./
```
```
cp /nfs/roberts/project/beng469f/shared/SpatialGlue/mclust.r ./
```

```
exit
```

Start Jupyter notebook with SpatialGlue pipeline

| **Parameters**      | **Values** |
| ----------- | ----------- |
|version | conda:SpatialGlue-env|
| Number of hours   | 6        |
| Number of CPU cores per node   | 4        |
| Memory per CPU core in GiB   | 16       |
| Partitions   |  education/devel/day     |

