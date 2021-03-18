
***
#### Login HPC: (need to connect to Yale's **VPN** if off campus)

```
ssh beng469_my393@farnam.hpc.yale.edu
srun --pty -p interactive --mem=5g bash
cd project
mkdir Assignment3-CNV && cd Assignment3-CNV
```
#### Load Modules:
```
module load miniconda
module load CMake/3.12.1
module load GCCcore/6.4.0
```
#### Create a virtual environment:
```
conda create -n scicone python=3.9
conda activate scicone
```
#### Install nlopt (about 2 minutes):
```
git clone git://github.com/stevengj/nlopt
cd nlopt
mkdir build && mkdir out.build
cd build
cmake .. -DCMAKE_C_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/gcc -DCMAKE_CXX_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/g++ -DCMAKE_INSTALL_PREFIX=../out.build
make 
make install
cd ../../
```

#### Install SCICoNE (about 5 minutes): 
```
cp /gpfs/ysm/project/beng469/beng469_my393/00.software/SCICoNE.tar.gz ./
tar -zxvf SCICoNE.tar.gz
cd SCICoNE
mkdir build && cd build
```
```shell
# remember change to your own NETID
export NLopt_DIR=/gpfs/ysm/project/beng469/beng469_NETID/Assignment3-CNV/nlopt/out.build:$NLopt_DIR
```
```
cmake .. -DCMAKE_C_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/gcc -DCMAKE_CXX_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/g++
make 
```
```shell
## export NLopt_DIR=/gpfs/ysm/project/fan/my393/Assignment3-CNV/nlopt/out.build:$NLopt_DIR
## cmake .. -DCMAKE_C_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/gcc -DCMAKE_CXX_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/g++ -DCMAKE_PREFIX_PATH=/gpfs/ysm/project/beng469/beng469_my393/Assignment3-CNV/nlopt/out.build
```

#### Python wrapper
```
cd ../pyscicone
pip install . 
pip install jupyter 
pip install PyQt5
conda install graphviz
```
***
### Go through the SCICoNE tutorial:

#### Use Jupyter notebook
```
ycrc_conda_env.list build
```
Open OnDemand (OOD) http://ood-farnam.hpc.yale.edu/

* Additional modules for Jupyter Notebook (```CMake/3.12.1 GCCcore/6.4.0)```)
* Run /gpfs/ysm/project/beng469/beng469_my393/Assignment3-CNV/SCICoNE/pyscicone/tutorial.ipynb

#### Use IPython

Setup X11 (On macOS)
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

Test X11
* When using ssh to log in to the clusters, use the ```-Y``` option to enable X11 forwarding. Example: ssh -Y
```
ssh -Y beng469_my393@farnam.hpc.yale.edu
```
```
srun --pty --x11 -p interactive --mem=5g bash
```
```
xclock
```
***

https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/2021-03-18/tutorial.ipynb
```
cd project/Assignment3-CNV/SCICoNE/pyscicone
module load miniconda
module load CMake/3.12.1
module load GCCcore/6.4.0
conda activate scicone
ipython3
```

```
/gpfs/ysm/project/beng469/beng469_my393/00.software/graphviz-2.44.1/mybuild/bin/dot -Tpdf -O  itree
```
***

###  Install packages && Download datasets.
Jack Kuipers, Mustafa Anıl Tuncel, Pedro Ferreira, Katharina Jahn, Niko Beerenwinkel. Single-cell copy number calling and event history reconstruction. bioRxiv 2020.04.28.065755; doi: https://doi.org/10.1101/2020.04.28.065755


#### Download the 10x Genomics data 

We apply SCICoNE to the 10x Genomics data set from section E of a frozen breast tumor tissue from a triple negative ductal carcinoma with an estimated tumor purity of 75%, which is available here (https://support.10xgenomics.com/single-cell-dna/datasets/1.1.0/breast_tissue_E_2k). The raw data contain 2053 cells and 154794 genomic bins. 

```
wget http://cf.10xgenomics.com/samples/cell-dna/1.1.0/breast_tissue_E_2k/breast_tissue_E_2k_cnv_data.h5
```

***
### Running SCICoNE on 10x Genomics data
https://github.com/cbg-ethz/SCICoNE/blob/master/notebooks/10x_example.ipynb
