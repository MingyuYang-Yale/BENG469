![image](https://user-images.githubusercontent.com/50332096/111586085-b10a0480-8796-11eb-9714-5841eaa65454.png) 

https://www.biorxiv.org/content/10.1101/2020.04.28.065755v1 

***
In this tutorial, you will learn how to:

1. Install and test the **`SCICoNE`** pipeline on HPC
2. Running SCICoNE on simulate_data to reconstructs the history of copy number events 
3. Running SCICoNE on 10x Genomics data (a frozen breast tumor tissue from a triple negative ductal carcinoma) to reconstructs the history of copy number events 

***
#### Login HPC: (need to connect to Yale's **VPN** if off campus)

```
ssh beng469_my393@farnam.hpc.yale.edu
srun --pty -p interactive --mem=5g bash
cd project
mkdir Assignment3-CNV && cd Assignment3-CNV
```
#### Load Modules:
```bash
# miniconda is used to create a new environment to reduce dependency version conflicts between your projects.
module load miniconda

# These two are used for Compile the source codes and Build the executables
module load CMake/3.12.1
module load GCCcore/6.4.0
```
#### Create environment:
```bash
# create a new Conda environment called “scicone” 
conda create -n scicone python=3.9

# activate the "scicone" environment
conda activate scicone
```
#### Install nlopt (about 2 minutes):
library for nonlinear local and global optimization, which is required by SCICoNE
```bash
# Clone the repository
git clone git://github.com/stevengj/nlopt 
cd nlopt

# Create and enter the build directory
mkdir build && mkdir out.build && cd build  

# configure && build && install
cmake .. -DCMAKE_C_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/gcc -DCMAKE_CXX_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/g++ -DCMAKE_INSTALL_PREFIX=../out.build  
make                         
make install

cd ../../
```

#### Install SCICoNE (about 5 minutes): 
```bash
# Copy source files to your own directory
cp /gpfs/ysm/project/beng469/beng469_my393/00.software/SCICoNE.tar.gz ./

# Extract source files
tar -zxvf SCICoNE.tar.gz
cd SCICoNE

# Create build directory and change to it
mkdir build && cd build

# configure && build , remember change to your own NETID
cmake .. -DCMAKE_C_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/gcc -DCMAKE_CXX_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/g++ -DCMAKE_PREFIX_PATH=/gpfs/ysm/project/beng469/beng469_NETID/Assignment3-CNV/nlopt/out.build

make 
```
```bash
## export NLopt_DIR=/gpfs/ysm/project/fan/my393/Assignment3-CNV/nlopt/out.build:$NLopt_DIR
```

#### Python wrapper
```bash

cd ../pyscicone

# pip is the standard package manager for Python
# It allows you to install and manage additional packages that are not part of the Python standard library
pip install . 
pip install jupyter 
pip install PyQt5

#conda installs any package within conda environments
conda install graphviz
```

### Running SCICoNE on simulate_data:
***
#### Use Jupyter notebook
```bash
# run "ycrc_conda_env.list build" to update your conda env for OOD
ycrc_conda_env.list build
```
* Open OnDemand (OOD) in a new window: http://ood-farnam.hpc.yale.edu/

* Interactive Apps -> Jupyter nootbook

<p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/OOD-Jupyter-notebook.png" alt="foo bar" title="train &amp; tracks" /></p>

* Additional modules for Jupyter Notebook (```CMake/3.12.1 GCCcore/6.4.0```)
* Path: /gpfs/ysm/project/beng469/beng469_my393/Assignment3-CNV/SCICoNE/pyscicone/tutorial.ipynb
***
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


```bash
# Install graphviz when use IPython
# cd ../../

# wget https://www2.graphviz.org/Packages/stable/portable_source/graphviz-2.44.1.tar.gz
# tar -zxvf graphviz-2.44.1.tar.gz 
# cd graphviz-2.44.1/
# mkdir mybuild
# module load Perl/5.26.0-GCCcore-6.4.0
# ./configure --prefix=/gpfs/ysm/project/beng469/beng469_my393/Assignment3-CNV/graphviz-2.44.1/mybuild
# make 
# make install
```


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
### Running SCICoNE on 10x Genomics data
https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/2021-03-18/10x_example.ipynb
