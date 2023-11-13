##  BENG 469 Assignemnt 2 - instructions

###  Part 1 : Run stpipeline on another sample (GSM4096261_10t)
- Access the Mccleary cluster
  <p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-ssh-login.png" alt="foo bar" title="train &amp; tracks" /></p>
- Go to the Lab7-Spatial_transcriptomics directory
```
cd ~/project/Lab7-Spatial_transcriptomics
```
- Copy the stpipeline.sh to your directory
```
cp /vast/palmer/scratch/fan/my393/BENG469/L7/00.sh/stpipeline.sh ./
```
- **Open the stpipeline.sh file, change the SampleID to 'GSM4096261_10t'**
<p><img width="200" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/a2-1.png" alt="foo bar" title="train &amp; tracks" /></p>

- Start an interactive job
```
```
- Load Miniconda
```
```
- Activate the conda envionment 'st-pipeline'
```
```
- **Submit the job to the compute node**. Here please change to you netid (don’t need to add beng469, just your netid) and your email address.
```
sbatch stpipeline-10t.sh NETID --mail-user=xx.xx@yale.edu
```

- Copy ipynb file to you folder
```
cp /vast/palmer/scratch/fan/my393/BENG469/L7/00.bin/Lab7-SpatialDE-Assignment2.ipynb ./
```
You can pause here to wait for the job finish (will take around 2 hours)

###  Part 2: 
- After you receive an email said your job has COMPLETED 

- Open OOD and Launch an Jupyter session:

Specify the parameters/resources as follows:

| Parameters      | Values |
| ----------- | ----------- |
| Environment Setup (select the miniconda environment) | spatialde  |
| Number of hours   | 6        |
| Number of CPU cores per node   | 1        |
| Memory per CPU core in GiB   | 8       |
| Partitions   | day        |
| Reservation | beng469 |

- Open the Jupyter notebook (Lab7-SpatialDE-Assignment2.ipynb)

**Please finish the 5 code writing/completion tasks as indicated in the Jupyter notebook.**

**You don’t need to submit any additional file or report for this assignment.**

