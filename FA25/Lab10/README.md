# BENG469 - LAB10

Open OOD site : <a href="https://beng469f.ycrc.yale.edu/"> **beng469f.ycrc.yale.edu** </a>

Click **Clusters** -> **shell access**

## Deepcell environment setup
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
