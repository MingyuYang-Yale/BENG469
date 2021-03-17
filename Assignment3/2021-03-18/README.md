***
## Single-cell copy number calling and event history reconstruction

Intra-tumor heterogeneity (ITH) has been a major confounding factor in cancer prognosis, treatment, and prevention. ITH describes the phenomenon in cancer when one tumor contains multiple subclones, each characterized by a certain group of genetic variations. When ITH is not fully characterized, cancer treatment tends to target only major clones whereas the small subclones may grow mid- or post-treatment, leading to cancer relapse. Fully characterizing ITH helps understanding cancer growth and thus can improve cancer treatment and prevention. To achieve that, one needs to correctly detect genetic variations in each cell and infer the phylogenetic tree of the subclones.

(Inferring a phylogenetic tree based on CNAs detected from scDNAseq data to capture the cell-lineage tree which is crucial for unraveling ITH yet has not been extensively studied or pursued. Much work has been done on inferring such trees from SNV scDNAseq data.)

Mallory, X.F., Edrisi, M., Navin, N. et al. Methods for copy number aberration detection from single-cell DNA-sequencing data. Genome Biol 21, 208 (2020). https://doi.org/10.1186/s13059-020-02119-8

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
cd ../../

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
ipython3
```
