In this tutorial, you will learn how to:

1. Install and test the **`10x Cell Ranger DNA pipeline`** on HPC.
2. Run cellranger-dna cnv using raw FASTQ files to perform CNV calling.

(10x Genomics data : a frozen breast tumor tissue from a triple negative ductal carcinoma. )

***
#### Login HPC:(need to connect to Yale's **VPN** if off campus)

```
ssh -Y beng469_my393@farnam.hpc.yale.edu
srun --pty --x11 -p interactive --mem=20g bash
cd /gpfs/ysm/project/beng469/beng469_my393
```

#### Install 10x Cell Ranger DNA pipeline
```
mkdir Assignment2-CNV && cd Assignment2-CNV
```

(https://support.10xgenomics.com/single-cell-dna/software/downloads/latest?)

tools:

```
# wget -O cellranger-dna-1.1.0.tar.gz "https://cf.10xgenomics.com/releases/cell-dna/cellranger-dna-1.1.0.tar.gz?Expires=1608195268&Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9jZi4xMHhnZW5vbWljcy5jb20vcmVsZWFzZXMvY2VsbC1kbmEvY2VsbHJhbmdlci1kbmEtMS4xLjAudGFyLmd6IiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNjA4MTk1MjY4fX19XX0_&Signature=AMYk4OZ~MkMi-WmDWE87TwKH58VtB70K3pddIBULKC~kUKxG4nPj21Nn1fB5FxCxWU4wvGhCS5M5ao2ReK77QQN-0to6cGNrMqkW-78pk3wL3xTqQ7dyx9ubBaFr2W4efsZyXyM-6mzbz9GbMpvZZ4YfYHGltHzXe9WtHiHokIJ~EQW0TaCukrRON6QCgloBDmjoZJGKaBGa8xatCMEsMpj2AJNMDyNYQkxKK5rkPCRjK5RGJdqJ4pZTUf4f8nWPDAJxrr9azSrjNcla8mZxfmbvI0Er3w0KqS9o4OLN4PWNpCxaEnqqCQ4Fu5VRybWZ0jtY~wIbPGlkGkUfnB-MRQ__&Key-Pair-Id=APKAI7S6A5RYOXBWRPDA"
```
Reference:
```
wget https://cf.10xgenomics.com/supp/cell-dna/refdata-GRCh37-1.0.0.tar.gz
```
10x datasets:
```
# wget https://cg.10xgenomics.com/samples/cell-dna/1.1.0/breast_tissue_A_2k/breast_tissue_A_2k_fastqs.tar 
(https://support.10xgenomics.com/single-cell-dna/datasets/1.1.0/breast_tissue_A_2k/)
```
```
(https://support.10xgenomics.com/single-cell-dna/software/pipelines/latest/installation/)

tar -xzvf cellranger-dna-1.1.0.tar.gz
tar -zxvf refdata-GRCh37-1.0.0.tar.gz
```
### Running cellranger-dna cnv
```
vi run-CNV.sh
```
Add the following codes to run-CNV.sh : 
```
(https://support.10xgenomics.com/single-cell-dna/software/pipelines/latest/using/tutorial/)

#!/bin/bash

#SBATCH --job-name=CNV-calling
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=4320
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mingyu.yang@yale.edu
#SBATCH --mem-per-cpu=8g
#SBATCH --partition=general

/gpfs/ysm/project/beng469/beng469_my393/Assignment2-CNV/cellranger-dna-1.1.0/cellranger-dna cnv --id=breast_tissue_A_2k \
--fastqs=/gpfs/ysm/project/beng469/beng469_my393/Assignment2-CNV/breast_tissue_A_2k_fastqs \
--reference=/gpfs/ysm/project/beng469/beng469_my393/Assignment2-CNV/refdata-GRCh37-1.0.0 \
--localmem=128 \
--localcores=16
```

```
sbatch run-CNV.sh
```

Once the run is completed, navigate to the outs directory.
```
cd /gpfs/ysm/scratch60/beng469/beng469_my393/breast_tissue_E_2k/outs/
```

Transfer Data to your laptop: ( scp -r netid@farnam.hpc.yale.edu:sourcedir ~/destdir )

```
scp beng469_my393@farnam.hpc.yale.edu:/gpfs/ysm/scratch60/beng469/beng469_my393/breast_tissue_E_2k/outs/web_summary.html ./

```
Open the web_summary.html file in a web browser

***

**Sequencing** :In this dataset there are **3.02 billion** NovaSeq paired end reads. (Note that the sequencing was 100 x 100 following standard sequencing requirements, but the first 16 bases, the 10x barcode that identifies the droplet, are trimmed from Read 1.)
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Sequencing.png" alt="foo bar" title="train &amp; tracks" /></p>

https://support.10xgenomics.com/single-cell-dna/datasets/1.1.0/breast_tissue_E_2k

**Cell Plots** : A histogram of barcodes ranked by mapped reads. A clean dataset should have a single steep cliff or drop off demonstrating the separation of signal (droplets containing cells) from noise (empty droplets), as seen below.
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Cell%20Plots-E.png" alt="foo bar" title="train &amp; tracks" /></p>

The green portion on the left is mapped reads in cells, that are retained for subsequent analyses.

Note that both axes are on a logarithmic scale. Most barcodes called as cells have >1M mapped reads, in contrast to barcodes called as empty droplets which have <10K mapped reads. 

**DIMAPD** : Depth-Independent Median Absolute deviation of Pairwise Differences (DIMAPD) **measures the bin-to-bin deviation of read depth in a cell**, perturbed by biological or technical variability. It is one of two methods to detect noisy cells. Most of the cells should have a DIMAPD below the threshold for noisy cells marked by the dashed red line as seen here.
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/DIMAPD-E.png" alt="foo bar" title="train &amp; tracks" /></p>

Look at other output files in the outs directory:
```
scp beng469_my393@farnam.hpc.yale.edu:/gpfs/ysm/scratch60/beng469/beng469_my393/breast_tissue_E_2k/outs/per_cell_summary_metrics.csv ./
```
The per_cell_summary_metrics.csv contains various metrics that provide per-cell information, and is easily visualized in Excel.
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Per%20cell%20summary-E.png" alt="foo bar" title="train &amp; tracks" /></p>

The **cnv_data.h5** file is in the HDF5 file format is designed to manage and store large datasets. It is structured similar to a dictionary, with a series of keys storing values, which contains all of the key outputs of the pipeline. HDF5 files can be read by tools like **h5py**. 



## Running SCICoNE on 10x Genomics data

/gpfs/ysm/scratch60/beng469/beng469_my393/breast_tissue_E_2k/outs/cnv_data.h5

```
cd /gpfs/ysm/project/beng469/beng469_my393/Assignment2-CNV/SCICoNE/pyscicone
module load Mesa/17.0.2-foss-2017a
module load Python/3.6.2-foss-2017b
ipython3
```
https://github.com/cbg-ethz/SCICoNE/blob/master/notebooks/10x_example.ipynb

