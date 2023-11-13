### Run stpipeline (5mins):

Open OOD in a browser
```
beng469.ycrc.yale.edu
```
Click Clusters -> shell access

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
Load Miniconda
```
module load miniconda
```
Activate the conda envionment st-pipeline
```
conda activate st-pipeline
```
Submit the job to the compute node. Here please change to you netid (don’t need to add beng469, just your netid) and your email address.
```
sbatch stpipeline-10t.sh NETID --mail-user=xx.xx@yale.edu
```

### Run Rmd file.
