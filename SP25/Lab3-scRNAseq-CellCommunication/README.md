### 1. Finding the Data

The dataset is available at: https://explore.data.humancellatlas.org/projects/f83165c5-e2ea-4d15-a5cf-33f3550bffde/project-matrices

Open the link above. Scroll down until you find ```vento18_10x.processed.h5ad```. This file contains the processed single-cell data required for further analysis.
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/ccc-data.png" alt="foo bar" title="train &amp; tracks" /></p>

#### Using the Pre-downloaded File:
If you want to save time, you can use the version I have already downloaded.
The file is available at: 
```
/gpfs/gibbs/project/beng469/beng469_my393/vento18_10x.processed.h5ad
```

### 2. Setting Up the Environment for CellPhoneDB

Open OOD site for our class: <a href="https://secure.its.yale.edu/cas/login?service=https%3a%2f%2fbeng469.ycrc.yale.edu%2fpun%2fsys%2fdashboard"> **beng469.ycrc.yale.edu** </a>

Click **Clusters** -> **shell access**
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-ssh-login-2025.png" alt="foo bar" title="train &amp; tracks" /></p>

Start an interactive job using the ```salloc```, this ensures you are running commands on a compute node rather than the login node.
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
Purge all loaded modules
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
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/ccc-1.png" alt="foo bar" title="train &amp; tracks" /></p>

Copy the ```cellphondDB.ipynb``` to you lab3 folder.
```
cp /gpfs/gibbs/project/beng469/beng469_my393/lab3/cellphoneDB.ipynb ~/project/lab3/
```

Launch a jupyter server, select "cellphoneDB", and Launch, all the other part can use default parameters.
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/ccc-2.png" alt="foo bar" title="train &amp; tracks" /></p>



