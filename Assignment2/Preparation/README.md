In this tutorial, you will learn how to:

1. Install and test the **`10x Cell Ranger DNA pipeline`** on HPC.
2. Run cellranger-dna cnv using raw FASTQ files to perform CNV calling.
3. Install and test the **`SCICoNE`** pipeline on HPC
4. Running SCICoNE on simulate_data to reconstructs the history of copy number events 

(10x Genomics data : a frozen breast tumor tissue from a triple negative ductal carcinoma. )

***
Login HPC:(need to first connect to Yale's **VPN** if off campus)

```
ssh -Y beng469_my393@farnam.hpc.yale.edu
srun --pty --x11 -p interactive --mem=20g bash
cd /gpfs/ysm/project/beng469/beng469_my393
```
The purpose of a .bashrc file is to provide a place where you can set up variables, functions and aliases, define your settings that you want to use every time you open a new terminal window.
```
vi ~/.bashrc
```

Add the following codes to ~/.bashrc : 

```
if [ "$TERM" = "xterm" ]
        then
        export PS1="\[\033]2;\h:\u \w\007\033[33;1m\]\u \033[36;1m\t\033[0m \[\033[35;1m\]\w\[\033[0m\]\n\[\e[32;1m\]$ \[\e[0m\]"
else
        export PS1="\[\033[32;1m\]\h:\u \[\033[32;1m\]\$\[\033[0m\]"
fi

export LS_OPTIONS='--color=auto'
eval "$(dircolors -b)"
alias ls='ls $LS_OPTIONS'

LS_COLORS='di=00;31;44:*.gz=01;31:*.txt=04;32:*.sh=01;34:*.pl=05;33:'
export LS_COLORS
```
h – Host name           
u – User name           
w – Path of the current working directory               
About color : https://gist.github.com/vratiu/9780109

```
source ~/.bashrc
```

***
## Single-cell copy number calling and event history reconstruction

Mallory, X.F., Edrisi, M., Navin, N. et al. Methods for copy number aberration detection from single-cell DNA-sequencing data. Genome Biol 21, 208 (2020). https://doi.org/10.1186/s13059-020-02119-8


Intra-tumor heterogeneity (ITH) has been a major confounding factor in cancer prognosis, treatment, and prevention. ITH describes the phenomenon in cancer when one tumor contains multiple subclones, each characterized by a certain group of genetic variations. When ITH is not fully characterized, cancer treatment tends to target only major clones whereas the small subclones may grow mid- or post-treatment, leading to cancer relapse. Fully characterizing ITH helps understanding cancer growth and thus can improve cancer treatment and prevention. To achieve that, one needs to correctly detect genetic variations in each cell and infer the phylogenetic tree of the subclones.

(Inferring a phylogenetic tree based on CNAs detected from scDNAseq data to capture the cell-lineage tree which is crucial for unraveling ITH yet has not been extensively studied or pursued. Much work has been done on inferring such trees from SNV scDNAseq data.)
***
### Install 10x Cell Ranger DNA pipeline
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
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mingyu.yang@yale.edu
#SBATCH --mem-per-cpu=8g
#SBATCH --partition=scavenge

/gpfs/ysm/project/beng469/beng469_my393/Assignment2-CNV/cellranger-dna-1.1.0/cellranger-dna cnv --id=breast_tissue_A_2k \
--fastqs=/gpfs/ysm/project/beng469/beng469_my393/Assignment2-CNV/breast_tissue_A_2k_fastqs \
--reference=/gpfs/ysm/project/beng469/beng469_my393/Assignment2-CNV/refdata-GRCh37-1.0.0 \
--localmem=128 \
--localcores=16
```

```
sbatch run-CNV.sh
```
***
###  Install SCICoNE
Jack Kuipers, Mustafa Anıl Tuncel, Pedro Ferreira, Katharina Jahn, Niko Beerenwinkel. Single-cell copy number calling and event history reconstruction. bioRxiv 2020.04.28.065755; doi: https://doi.org/10.1101/2020.04.28.065755


```
module load CMake/3.9.1
module load Python/3.6.2-foss-2017b
```
```
git clone https://github.com/cbg-ethz/SCICoNE.git
git clone git://github.com/stevengj/nlopt
```
Install nlopt:
```
cd nlopt
mkdir build 
mkdir out.build
cd build
cmake .. -DCMAKE_C_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/gcc -DCMAKE_CXX_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/g++ -DCMAKE_INSTALL_PREFIX=../out.build
make 
make install
```

```
cd ../../SCICoNE/
mkdir build && cd build
cmake .. -DCMAKE_C_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/gcc -DCMAKE_CXX_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/g++ -DCMAKE_PREFIX_PATH=/gpfs/ysm/project/beng469/beng469_my393/Assignment2-CNV/nlopt/out.build
make 
```
```
cd ../pyscicone
pip install scipy --upgrade --user
pip install . --user 
pip install jupyter --user
(pip install PyQt5==5.9.2 if you can use X11)

```
```
ipython3
```
###  Running SCICoNE
https://github.com/cbg-ethz/SCICoNE/blob/master/notebooks/tutorial.ipynb

```
wget https://www2.graphviz.org/Packages/stable/portable_source/graphviz-2.44.1.tar.gz
tar -zxvf graphviz-2.44.1.tar.gz 
cd graphviz-2.44.1/
mkdir mybuild
module load Perl/5.26.0-GCCcore-6.4.0
./configure --prefix=/gpfs/ysm/project/beng469/beng469_my393/Assignment2-CNV/graphviz-2.44.1/mybuild
make 
make install
```
```
cd ../../SCICoNE/pyscicone
/gpfs/ysm/project/beng469/beng469_my393/Assignment2-CNV/graphviz-2.44.1/mybuild/bin/dot -Tpdf -O  Source.gv
```
