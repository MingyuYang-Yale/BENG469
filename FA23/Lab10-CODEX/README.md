
# BENG 469 Lab session 10 - instructions

### Install SpaCodex $\color{red}{\textsf{(Please keep this part within the class because the package we are using has not been published yet.)}}$ 

Start an interactive job using the salloc
```bash
salloc
```

```bash
module load miniconda
```
```bash
conda create -y -n spacodex python=3.10 jupyterlab jupyter
```
```bash
conda activate spacodex
```
$\color{red}{\textsf{Please find the GITHUB\_USER and GITHUB\_TOKEN in the Announcement we sent today, and replace the following'xxx'}}$ 

```
export GITHUB_USER=xxx
```
```
export GITHUB_TOKEN=xxx
```

```bash
pip install git+https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/yuqiyuqitan/SAP.git@preppip
```
```bash
module purge
```

```bash
ycrc_conda_env.sh update
```

```bash
cat ~/ondemand/conda-jupyter-env-list.txt
```

### Copy Jupyter Notebook to your directory


```bash
cd ~/project/
```
Create a new diretory named 'Lab10_CODEX':
```bash
mkdir Lab10_CODEX  && cd Lab10_CODEX
```
Copy the folder with notebooks to your folder:
```bash
cp -r /gpfs/gibbs/project/beng469/beng469_my393/Lab10_CODEX/notebooks ./
```

### Launch an Jupyter session:

Go to the **Jupyter** initialization page, and specify the parameters/resources as follows:

 Parameters      | Values |
| ----------- | ----------- |
| Environment Setup (select the miniconda environment) | spacodex  |
| Number of hours   | 6        |
| Number of CPU cores per node   | 1       |
| Memory per CPU core in GiB   | 8       |
| Partitions   | gpu        |
| Number of GPUs per node | 1 |
| Additional modules for Jupyter | CUDAcore/11.3.1 cuDNN/8.2.1.32-CUDA-11.3.1 |


### Open your Notebook folder and follow the instructions
