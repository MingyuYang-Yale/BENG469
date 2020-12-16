# Single-cell copy number calling and event history reconstruction



```
ssh -Y beng469_my393@farnam.hpc.yale.edu
srun --pty --x11 -p interactive --mem=20g bash
cd /gpfs/ysm/project/beng469/beng469_my393
```

```
mkdir Lecture2-CNV && cd Lecture2-CNV
module load CMake/3.9.1
module load Python/3.6.2-foss-2017b
```
```
git clone https://github.com/cbg-ethz/SCICoNE.git

git clone git://github.com/stevengj/nlopt
```
```
cd nlopt
mkdir build 
mkdir out.build
cd build
-DCMAKE_C_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/gcc -DCMAKE_CXX_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/g++ -DCMAKE_INSTALL_PREFIX=../out.build
make 
make install
```
```
cd ../../SCICoNE/
mkdir build && cd build
cmake .. -DCMAKE_C_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/gcc -DCMAKE_CXX_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/g++ -DCMAKE_PREFIX_PATH=/gpfs/ysm/project/beng469/beng469_my393/Lecture2-CNV/nlopt/out.build
make 
```
```
cd ../pyscicone
pip install scipy --upgrade --user
pip install . --user 
pip install jupyter --user
(pip install PyQt5==5.9.2 if you can use X11)

ipython3
```

https://github.com/cbg-ethz/SCICoNE/blob/master/notebooks/tutorial.ipynb

```
wget https://www2.graphviz.org/Packages/stable/portable_source/graphviz-2.44.1.tar.gz
tar -zxvf graphviz-2.44.1.tar.gz 
cd graphviz-2.44.1/
mkdir mybuild
module load Perl/5.26.0-GCCcore-6.4.0
./configure --prefix=/gpfs/ysm/project/beng469/beng469_my393/Lecture2-CNV/graphviz-2.44.1/mybuild
make 
make install
```
