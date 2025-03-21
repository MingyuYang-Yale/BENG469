# BENG 469 Lab session 7-2 - instructions

#### Open OOD in a browser window

```
beng469.ycrc.yale.edu
```

Click **Clusters** -> **shell access**
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-ssh-login.png" alt="foo bar" title="train &amp; tracks" /></p>

Go to your results under **project** fileset to Check the log file for STPipeline

```
cd project/Lab7-Spatial_transcriptomics/GSM4189611_50t
```

Use ls command to list files and directories.
```
ls -lrt 
```
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/log4.png" alt="foo bar" title="train &amp; tracks" /></p>

```
cat GSM4189611_50t_log.txt
```
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/log1.png" alt="foo bar" title="train &amp; tracks" /></p>

<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/log2.png" alt="foo bar" title="train &amp; tracks" /></p>

<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/log3.png" alt="foo bar" title="train &amp; tracks" /></p>


Go to **palmer_scratch** directory
```
cd ~/palmer_scratch 
```

Then go to the Lab7-Spatial_transcriptomics directory
```
cd Lab7-Spatial_transcriptomics
```

#### Copy Rmd files to you folder
```
cp /vast/palmer/scratch/fan/my393/BENG469/L7/00.bin/Lab7-DBiT-seq.Rmd ./
```

```
cp /vast/palmer/scratch/fan/my393/BENG469/L7/00.bin/Lab7-SpatialDE.ipynb ./
```

---

#### Go back to OOD and Launch an Rstudio-server session:

<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/ood-8.png" alt="foo bar" title="train &amp; tracks" /></p>

   
Go to the Rstudio-server initialization page, and specify the parameters/resources as follows:

| Parameters      | Values |
| ----------- | ----------- |
| R version      | R/4.2.0-foss-2020b       |
| Number of hours   | 6        |
| Number of CPU cores per node   | 1       |
| Memory per CPU core in GiB   | 8       |
| Partitions   | day        |
| Reservation | beng469 |


<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/rsession1.png" alt="foo bar" title="train &amp; tracks" /></p>

```
~/palmer_scratch/Lab7-Spatial_transcriptomics
```

### [SpatialDE](https://www.nature.com/articles/nmeth.4636)

<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-ssh-login.png" alt="foo bar" title="train &amp; tracks" /></p>

```
salloc
```
```
module load miniconda
```
```
conda create -y -n spatialde python=3.7
```
```
conda activate spatialde
```
```
pip install numpy pandas matplotlib jupyter patsy
```
```
pip install spatialde
```
```
module purge
```
```
ycrc_conda_env.sh update
```

```
cd ~/ondemand
```
```
cat conda-jupyter-env-list.txt
```

#### Launch an Jupyter session:
   
Go to the **Jupyter** initialization page, and specify the parameters/resources as follows:

| Parameters      | Values |
| ----------- | ----------- |
| Environment Setup (select the miniconda environment) | spatialde  |
| Number of hours   | 6        |
| Number of CPU cores per node   | 1        |
| Memory per CPU core in GiB   | 8       |
| Partitions   | day        |
| Reservation | beng469 |

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/ood-9.png" alt="foo bar" title="train &amp; tracks" /></p>

