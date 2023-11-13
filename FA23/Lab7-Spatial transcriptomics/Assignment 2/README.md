#### Run stpipeline (5mins):

Go to the Lab7-Spatial_transcriptomics directory
```
cd ~/project/Lab7-Spatial_transcriptomics
```
Copy the stpipeline-10t.sh to your directory
```
cp /vast/palmer/scratch/fan/my393/BENG469/L7/00.sh/stpipeline-10t.sh ./
```
Start an interactive job
```
salloc
```
```
module load miniconda
```
Activate the conda envionment st-pipeline
```
conda activate st-pipeline
```
Submit a batch job to compute node
```
sbatch stpipeline-10t.sh NETID --mail-user=xx.xx@yale.edu
```

