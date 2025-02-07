Open OOD site for our class: <a href="https://secure.its.yale.edu/cas/login?service=https%3a%2f%2fbeng469.ycrc.yale.edu%2fpun%2fsys%2fdashboard"> **beng469.ycrc.yale.edu** </a>

Click **Clusters** -> **shell access**
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-ssh-login-2025.png" alt="foo bar" title="train &amp; tracks" /></p>

Start an interactive job using the ```salloc```, This ensures you are running commands on a compute node rather than the login node.
```
salloc
```
Load the Miniconda module, Miniconda is needed to create and manage Python environments.
```
module load miniconda
```
Create a new Conda environment named CellPhoneDB
```
conda create -y -n cellphoneDB python=3.10
```
Activate the virtual environment
```
conda activate cellphoneDB
```
Install necessary Python packages
```
pip install scanpy seaborn gdown jupyter
```
```
pip install git+https://github.com/saezlab/liana-py
```
```
module purge
```
Update Conda environments for OOD
```
ycrc_conda_env.sh update
```
List all Conda environments 
```
cat ~/ondemand/conda-jupyter-env-list.txt
```

https://explore.data.humancellatlas.org/projects/f83165c5-e2ea-4d15-a5cf-33f3550bffde/project-matrices

vento18_10x.processed.h5ad
