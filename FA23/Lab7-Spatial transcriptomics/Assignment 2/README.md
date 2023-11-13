### Run stpipeline (5mins):

Open OOD in a browser
```
beng469.ycrc.yale.edu
```
Click Clusters -> shell access
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-ssh-login.png" alt="foo bar" title="train &amp; tracks" /></p>

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

Copy Rmd files to you folder
```
cp /vast/palmer/scratch/fan/my393/BENG469/L7/00.bin/Lab7-DBiT-seq.Rmd ./
```

### Run Rmd file.

Go back to OOD and Launch an Rstudio-server session:
Specify the parameters/resources as follows:

| Parameters      | Values |
| ----------- | ----------- |
| R version      | R/4.2.0-foss-2020b       |
| Number of hours   | 6        |
| Number of CPU cores per node   | 1       |
| Memory per CPU core in GiB   | 8       |
| Partitions   | day        |
| Reservation | beng469 |

<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/rsession1.png" alt="foo bar" title="train &amp; tracks" /></p>





