
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

( Xiaoyu : CANCELLED **DUE TO TIME LIMIT** )

```
cd /gpfs/ysm/scratch60/beng469/beng469_xq39
vi run-CNV.sh

#SBATCH --time=4320
```
Once the run is completed, navigate to the outs directory.
```
cd /gpfs/ysm/scratch60/beng469/beng469_my393/breast_tissue_A_2k/outs/
```
Open the web_summary.html file in a web browser
```
scp beng469_my393@farnam.hpc.yale.edu:/gpfs/ysm/scratch60/beng469/beng469_my393/breast_tissue_A_2k/outs/web_summary.html ./
```
In this dataset there are **2.32 billion** NovaSeq paired end reads.

*Note that the sequencing was 100 x 100 following standard sequencing requirements, but the first 16 bases, the 10x barcode that identifies the droplet, are trimmed from Read 1.

## Cell Plots

This is a histogram of barcodes ranked by mapped reads. A clean dataset should have a single steep cliff or drop off demonstrating the separation of signal (droplets containing cells) from noise (empty droplets), as seen below.

https://support.10xgenomics.com/single-cell-dna/datasets/1.1.0/breast_tissue_A_2k
