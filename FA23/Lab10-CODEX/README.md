
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
conda create -n spacodex python=3.10 jupyterlab jupyter
```

Please find the GITHUB_USER and GITHUB_TOKEN in the Announcements email we sent today, and replace the following'xxx' 

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

So please go to your terminal and copy the Jupyter Notebook into your directory

```bash
cd ~/project/
```
3. Create a new diretory named 'Lab10_CODEX':
```bash
mkdir Lab10_CODEX
```
4. Go to the Lab10_CODEX directory:
```bash
cd Lab10_CODEX
```
5. Copy the folder with notebooks to your folder:
```bash
cp -r /gpfs/gibbs/project/beng469/beng469_sb2723/Lab10_CODEX/notebooks ./
```

### Launch an Jupyter session:

Go to the **Jupyter** initialization page, and specify the parameters/resources as follows:

 Parameters      | Values |
| ----------- | ----------- |
| Environment Setup (select the miniconda environment) | spacodex  |
| Number of hours   | 6        |
| Number of CPU cores per node   | 2        |
| Memory per CPU core in GiB   | 8       |
| Partitions   | gpu        |
| Number of GPUs per node | 1 |
| Reservation | beng469 |
| Additional modules for Jupyter (optional) | CUDAcore/11.3.1 cuDNN/8.2.1.32-CUDA-11.3.1 |


### Open your Notebook folder and follow the instructions
