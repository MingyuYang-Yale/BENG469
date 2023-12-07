
# BENG 469 Lab session 10 - instructions

### Python environment and Jupyter Notebook
Please keep this part within the class because the package we are using has not been published yet.
```bash
conda create -n spacodex python=3.10 jupyterlab jupyter
```
```bash
export GITHUB_USER=xxx
```
```bash
export GITHUB_TOKEN=xxx
```
```bash
pip install git+https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/yuqiyuqitan/SAP.git@preppip
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
| Additional modules for Jupyter (optional) | TensorFlow/2.13.0-foss-2022b |

https://docs.ycrc.yale.edu/img/ood_jupyter.png

### Open your Notebook folder and follow the instructions
