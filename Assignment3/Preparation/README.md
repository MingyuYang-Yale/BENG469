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
