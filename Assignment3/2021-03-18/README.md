***
#### Setup X11 (On macOS)
* Download and install XQuartz(https://www.xquartz.org)
* open a termianl window, and run:
```
launchctl load -w /Library/LaunchAgents/org.macosforge.xquartz.startx.plist
```
* Log out(```quit```) and log back in to your Mac to reset some variables.
**(quit and reopen terminal window)**
```
echo $DISPLAY
```
the terminal should respond : " /private/tmp/com.apple.launchd.y8vzcm7AMF/org.macosforge.xquartz:0 "

#### Test X11
When using ssh to log in to the clusters, use the ```-Y``` option to enable X11 forwarding. Example: ssh -Y
```
ssh -Y beng469_my393@farnam.hpc.yale.edu
```
```
srun --pty --x11 -p interactive --mem=20g bash
```
```
xclock
```

***
#### Login HPC:
(need to connect to Yale's **VPN** if off campus)

```
ssh beng469_my393@farnam.hpc.yale.edu
srun --pty -p interactive --mem=20g bash
cd project
mkdir Assignment3-CNV && cd Assignment3-CNV
```
***

###  Running SCICoNE on 10x Genomics data
Jack Kuipers, Mustafa Anıl Tuncel, Pedro Ferreira, Katharina Jahn, Niko Beerenwinkel. Single-cell copy number calling and event history reconstruction. bioRxiv 2020.04.28.065755; doi: https://doi.org/10.1101/2020.04.28.065755

#### Load Modules:
```
module load CMake/3.9.1
module load Python/3.6.2-foss-2017b
module load Perl/5.26.0-GCCcore-6.4.0
```

#### Install graphviz:
```
wget https://www2.graphviz.org/Packages/stable/portable_source/graphviz-2.44.1.tar.gz
tar -zxvf graphviz-2.44.1.tar.gz 
cd graphviz-2.44.1/
mkdir build
./configure --prefix=/gpfs/ysm/project/beng469/beng469_my393/Assignment3-CNV/graphviz-2.44.1/build
make 
make install
cd ../
```

#### Install nlopt:
```
git clone git://github.com/stevengj/nlopt
cd nlopt
mkdir build 
mkdir out.build
cd build
cmake .. -DCMAKE_C_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/gcc -DCMAKE_CXX_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/g++ -DCMAKE_INSTALL_PREFIX=../out.build
make 
make install
cd ../../
```

#### Install SCICoNE:
```
git clone https://github.com/cbg-ethz/SCICoNE.git
cd SCICoNE
mkdir build && cd build
cmake .. -DCMAKE_C_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/gcc -DCMAKE_CXX_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/g++ -DCMAKE_PREFIX_PATH=/gpfs/ysm/project/beng469/beng469_my393/Assignment3-CNV/nlopt/out.build
make 
```
```
cd ../pyscicone
pip install scipy --upgrade --user
pip install . --user 
pip install jupyter --user
pip install PyQt5==5.9.2
```

#### Download the 10x Genomics data 

We apply SCICoNE to the 10x Genomics data set from section E of a frozen breast tumor tissue from a triple negative ductal carcinoma with an estimated tumor purity of 75%, which is available here (https://support.10xgenomics.com/single-cell-dna/datasets/1.1.0/breast_tissue_E_2k). The raw data contain 2053 cells and 154794 genomic bins. 

```
wget http://cf.10xgenomics.com/samples/cell-dna/1.1.0/breast_tissue_E_2k/breast_tissue_E_2k_cnv_data.h5
```

```
ipython3
```
```{py}
import scicone
import numpy as np

install_path = '../build/'
temporary_outpath = './'
seed = 42 # for reproducibility

np.random.seed(seed)

# Create SCICoNE object
sci = scicone.SCICoNE(install_path, temporary_outpath, verbose=False)
```
