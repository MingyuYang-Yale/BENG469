# BENG469 - LAB9

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
cp /nfs/roberts/project/beng469f/shared/SpatialGlue/mclust.r
```

```
exit
```
