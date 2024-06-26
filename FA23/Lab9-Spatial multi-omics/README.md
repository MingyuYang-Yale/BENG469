# BENG 469 Lab session 9 - instructions

[Background slide](https://docs.google.com/presentation/d/1Z1bNNrZqh2BR2VdTa6zQu9rdqzkZKRgmSRV5K6DBhgo/edit?usp=sharing) 

### Python environment

We will build a Python environment using conda for the lab.

```
salloc
```
```
module load miniconda
```
```
conda create -y -n Lab9-squidpy python=3.7
```
```
conda activate Lab9-squidpy
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
| Environment Setup (select the miniconda environment) | Lab9-squidpy  |
| Number of hours   | 6        |
| Number of CPU cores per node   | 1        |
| Memory per CPU core in GiB   | 8       |
| Partitions   | day        |
| Reservation | beng469 |


