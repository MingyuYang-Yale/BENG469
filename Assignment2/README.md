
#### Setup X11 (MAC):
Download and install XQuartz(https://www.xquartz.org)
```
launchctl load -w /Library/LaunchAgents/org.macosforge.xquartz.startx.plist
```
quit and reopen terminal 
```
echo $DISPLAY 
```
the terminal should respond : " /private/tmp/com.apple.launchd.y8vzcm7AMF/org.macosforge.xquartz:0 "

(sudo vi /etc/ssh/ssh_config)   
(export DISPLAY=:0.0)        


#### Test X11
```
ssh -Y beng469_my393@farnam.hpc.yale.edu
srun --pty --x11 -p interactive --mem=20g bash
```
```
ls -lrt
cd /gpfs/ysm/project/beng469/beng469_my393
cd Assignment2-CNV/SCICoNE/pyscicone/
module load Mesa/17.0.2-foss-2017a
module load Python/3.6.2-foss-2017b
ipython3
```
https://github.com/cbg-ethz/SCICoNE/blob/master/notebooks/tutorial.ipynb

https://youtu.be/kchwMk4R2g8

***

### Results from cellranger-dna cnv :

Email from farnam cluster:

<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment2/email%20from%20cluster.png" alt="foo bar" title="train &amp; tracks" /></p>

( Rong : **Disk quota exceeded** (os error 122) )

```
cd /gpfs/ysm/scratch60/fan/rf273
cp /gpfs/ysm/project/fan/rf273/Assignment2-CNV/run-CNV.sh ./
sbatch run-CNV.sh
```

#### Storage
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment2/Storage.png" alt="foo bar" title="train &amp; tracks" /></p>

All storage areas have quotas, both size and file count
To check your group’s cluster quotas, run **getquota**

***
( Xiaoyu : CANCELLED **DUE TO TIME LIMIT** )

```
cd /gpfs/ysm/scratch60/beng469/beng469_xq39
vi run-CNV.sh

#SBATCH --time=4320
```
###


Once the run is completed, navigate to the outs directory.
```
cd /gpfs/ysm/scratch60/beng469/beng469_my393/breast_tissue_E_2k/outs/
```

Transfer Data to your laptop: ( scp -r netid@farnam.hpc.yale.edu:sourcedir ~/destdir )

```
scp beng469_my393@farnam.hpc.yale.edu:/gpfs/ysm/scratch60/beng469/beng469_my393/breast_tissue_E_2k/outs/web_summary.html ./

```
Open the web_summary.html file in a web browser

***



**Sequencing** :In this dataset there are **3.02 billion** NovaSeq paired end reads. (Note that the sequencing was 100 x 100 following standard sequencing requirements, but the first 16 bases, the 10x barcode that identifies the droplet, are trimmed from Read 1.)
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment2/Sequencing.png" alt="foo bar" title="train &amp; tracks" /></p>

https://support.10xgenomics.com/single-cell-dna/datasets/1.1.0/breast_tissue_A_2k

**Cell Plots** : A histogram of barcodes ranked by mapped reads. A clean dataset should have a single steep cliff or drop off demonstrating the separation of signal (droplets containing cells) from noise (empty droplets), as seen below.
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment2/Cell%20Plots-E.png" alt="foo bar" title="train &amp; tracks" /></p>

The green portion on the left is mapped reads in cells, that are retained for subsequent analyses.

Note that both axes are on a logarithmic scale. Most barcodes called as cells have >1M mapped reads, in contrast to barcodes called as empty droplets which have <10K mapped reads. 

**DIMAPD** : Depth-Independent Median Absolute deviation of Pairwise Differences (DIMAPD) **measures the bin-to-bin deviation of read depth in a cell**, perturbed by biological or technical variability. It is one of two methods to detect noisy cells. Most of the cells should have a DIMAPD below the threshold for noisy cells marked by the dashed red line as seen here.
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment2/DIMAPD-E.png" alt="foo bar" title="train &amp; tracks" /></p>

Look at other output files in the outs directory:
```
scp beng469_my393@farnam.hpc.yale.edu:/gpfs/ysm/scratch60/beng469/beng469_my393/breast_tissue_E_2k/outs/per_cell_summary_metrics.csv ./
```
The per_cell_summary_metrics.csv contains various metrics that provide per-cell information, and is easily visualized in Excel.
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment2/Per%20cell%20summary-E.png" alt="foo bar" title="train &amp; tracks" /></p>

The **cnv_data.h5** file is in the HDF5 file format is designed to manage and store large datasets. It is structured similar to a dictionary, with a series of keys storing values, which contains all of the key outputs of the pipeline. HDF5 files can be read by tools like **h5py**. 



## Running SCICoNE on 10x Genomics data

/gpfs/ysm/scratch60/beng469/beng469_my393/breast_tissue_E_2k/outs/cnv_data.h5

```
cd /gpfs/ysm/project/beng469/beng469_my393/Assignment2-CNV/SCICoNE/pyscicone
module load Mesa/17.0.2-foss-2017a
module load Python/3.6.2-foss-2017b
ipython3
```
https://github.com/cbg-ethz/SCICoNE/blob/master/notebooks/10x_example.ipynb

