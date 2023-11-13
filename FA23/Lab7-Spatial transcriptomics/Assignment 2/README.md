## BENG 469 Assignemnt 2 - instructions

#### Run stpipeline anb SpatialDE on another sample :

1. Access the Mccleary cluster

2. Go to the Lab7-Spatial_transcriptomics directory
```
cd ~/project/Lab7-Spatial_transcriptomics
```
3. Copy the stpipeline.sh to your directory
```
cp /vast/palmer/scratch/fan/my393/BENG469/L7/00.sh/stpipeline.sh ./
```
4. **Open the stpipeline.sh file, change the SampleID to 'GSM4096261_10t'**

5. Start an interactive job
```
```
6. Load Miniconda
```
```
7. Activate the conda envionment 'st-pipeline'
```
```
8. Submit the job to the compute node. Here please change to you netid (don’t need to add beng469, just your netid) and your email address.
```
sbatch stpipeline-10t.sh NETID --mail-user=xx.xx@yale.edu
```

9. Copy ipynb file to you folder
```
cp /vast/palmer/scratch/fan/my393/BENG469/L7/00.bin/Lab7-SpatialDE-Assignment2.ipynb ./
```

10. Go back to OOD and Launch an Jupyter session:

Specify the parameters/resources as follows:

| Parameters      | Values |
| ----------- | ----------- |
| Environment Setup (select the miniconda environment) | spatialde  |
| Number of hours   | 6        |
| Number of CPU cores per node   | 1        |
| Memory per CPU core in GiB   | 8       |
| Partitions   | day        |
| Reservation | beng469 |

Connect to Jupyter then Click the three dots in the bottom right panel, then put the fold path in the box.

<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/rsession1.png" alt="foo bar" title="train &amp; tracks" /></p>



