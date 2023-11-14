##  BENG 469 Assignemnt 2 - instructions

###  Part 1 : Run stpipeline on another sample (GSM4096261_10t)
Access the Mccleary cluster
  <p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-ssh-login.png" alt="foo bar" title="train &amp; tracks" /></p>

Go to the Lab7-Spatial_transcriptomics directory
```
cd ~/project/Lab7-Spatial_transcriptomics
```
Create a new diretory named 'Assingment2'
```
mkdir Assingment2
```
Go to the Assingment2 directory
```
cd Assingment2
```
Copy the stpipeline.sh to your folder
```
cp /vast/palmer/scratch/fan/my393/BENG469/L7/00.sh/stpipeline-Assignment2.sh ./
```
Copy ipynb file to you folder
```
cp /vast/palmer/scratch/fan/my393/BENG469/L7/00.bin/Lab7-SpatialDE-Assignment2.ipynb ./
```
**Open the stpipeline-Assignment2.sh file, change the SampleID to 'GSM4096261_10t'**
<p><img width="200" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/a2-1.png" alt="foo bar" title="train &amp; tracks" /></p>

Start an interactive job
```
(leave as blank on purpose)
```

Load Miniconda
```

```

Activate the conda envionment 'st-pipeline'
```

```

**Submit the job to the compute node**. 

Here please change to you netid (don’t need to add beng469, just your netid) and your email address.
```
sbatch stpipeline-Assignment2.sh NETID --mail-user=xx.xx@yale.edu
```

*You can pause here to wait for the job finish (will take ~3 hours)*

*After you receive an email said your job has COMPLETED, you can continue the second part*

$\color{red}{\textsf{If you successfully finish part1, when you run the following command}}$

```
ls -lrt ~/project/Lab7-Spatial_transcriptomics/Assingment2/GSM4096261_10t/
```

$\color{red}{\textsf{You will get 4 files:}}$

<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/a2-3.png" alt="foo bar" title="train &amp; tracks" /></p>


###  Part 2: finish the 5 code writing/completion tasks in the Jupyter notebook


Open OOD and Launch an Jupyter session:

Specify the parameters/resources as follows:

| Parameters      | Values |
| ----------- | ----------- |
| Environment Setup (select the miniconda environment) | spatialde  |
| Number of hours   | 6        |
| Number of CPU cores per node   | 1        |
| Memory per CPU core in GiB   | 8       |
| Partitions   | day        |
| Reservation | beng469 |

Open the Jupyter notebook (Lab7-SpatialDE-Assignment2.ipynb), and finish the tasks.

$\color{red}{\textsf{You don’t need to submit any additional file or report for this assignment.}}$ You just need to save
the ipynb file after you finish to run it. 

$\color{red}{\textsf{If you successfully finish part2, go back to the clusters, and run the following command:}}$
```
ls -lrt ~/project/Lab7-Spatial_transcriptomics/Assingment2
```


$\color{red}{\textsf{You will get these files:}}$

<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/a2-4.png" alt="foo bar" title="train &amp; tracks" /></p>

We will evaluate the results from those files.

