# BENG 469 Lab session 1116 - instructions

### Python environment

We will build a Python environment using conda for the lab.

```
salloc
```
```
module load miniconda
```
```
conda create -y -n lab1116 python=3.7
```
```
conda activate lab1116
```
```
pip install numpy pandas matplotlib jupyter patsy 'scanpy[leiden]' squidpy
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
| Environment Setup (select the miniconda environment) | lab1116  |
| Number of hours   | 6        |
| Number of CPU cores per node   | 1        |
| Memory per CPU core in GiB   | 8       |
| Partitions   | day        |
| Reservation | beng469 |


