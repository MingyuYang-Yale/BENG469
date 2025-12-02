## install conda env

```
salloc
```
```
module load miniconda
```
```
conda env create -f /nfs/roberts/project/beng469f/shared/Lab11/istar_environment.yml
```
```
conda activate iStar_origin
```
```
pip install jupyter
```
```
ycrc_conda_env.sh update
```

## goes to home directory
```
cd
```
## goes to your folder and create folder for Lab11
```
cd project_beng469f/beng469f_NETID
```
```
mkdir Lab11
```

## copy the files related to iStar to Lab11

```
cp /nfs/roberts/project/beng469f/shared/Lab11/iStar/* ./
```
```
cp -r /nfs/roberts/project/beng469f/shared/Lab11/demo ./
```
```
cp -r /nfs/roberts/project/beng469f/shared/Lab11/checkpoints ./
```

```
exit
```

### Start Jupyter notebook with iStar pipeline

| **Parameters**      | **Values** |
| ----------- | ----------- |
|version | conda:iStar_origin|
| Number of hours   | 6        |
| Number of CPU cores per node   | 8        |
| Memory per CPU core in GiB   | 8       |
| Partitions   |  education/devel/day     |

