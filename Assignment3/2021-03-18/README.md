***
#### Setup X11 (On macOS)
* Download and install XQuartz(https://www.xquartz.org)
* open a termianl window, and run:
```
launchctl load -w /Library/LaunchAgents/org.macosforge.xquartz.startx.plist
```
* Log out(```quit```) and log back in to your Mac to reset some variables.
**(quit and reopen terminal window)**
```
echo $DISPLAY
```
the terminal should respond : " /private/tmp/com.apple.launchd.y8vzcm7AMF/org.macosforge.xquartz:0 "

#### Test X11
When using ssh to log in to the clusters, use the ```-Y``` option to enable X11 forwarding. Example: ssh -Y
```
ssh -Y beng469_my393@farnam.hpc.yale.edu
```
```
srun --pty --x11 -p interactive --mem=20g bash
```
```
xclock
```

***
#### Login HPC:
(need to connect to Yale's **VPN** if off campus)

```
ssh beng469_my393@farnam.hpc.yale.edu
srun --pty -p interactive --mem=20g bash
cd project
mkdir Assignment3-CNV && cd Assignment3-CNV
```
***

###  Install packages && Download datasets.
Jack Kuipers, Mustafa Anıl Tuncel, Pedro Ferreira, Katharina Jahn, Niko Beerenwinkel. Single-cell copy number calling and event history reconstruction. bioRxiv 2020.04.28.065755; doi: https://doi.org/10.1101/2020.04.28.065755

#### Load Modules:
```
module load CMake/3.9.1
module load Python/3.6.2-foss-2017b
module load Perl/5.26.0-GCCcore-6.4.0
```

#### Install graphviz:
```
wget https://www2.graphviz.org/Packages/stable/portable_source/graphviz-2.44.1.tar.gz
tar -zxvf graphviz-2.44.1.tar.gz 
cd graphviz-2.44.1/
mkdir build
./configure --prefix=/gpfs/ysm/project/beng469/beng469_my393/Assignment3-CNV/graphviz-2.44.1/build
make 
make install
cd ../
```

#### Install nlopt:
```
git clone git://github.com/stevengj/nlopt
cd nlopt
mkdir build 
mkdir out.build
cd build
cmake .. -DCMAKE_C_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/gcc -DCMAKE_CXX_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/g++ -DCMAKE_INSTALL_PREFIX=../out.build
make 
make install
cd ../../
```

#### Install SCICoNE:
```
git clone https://github.com/cbg-ethz/SCICoNE.git
cd SCICoNE
mkdir build && cd build
cmake .. -DCMAKE_C_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/gcc -DCMAKE_CXX_COMPILER=/ysm-gpfs/apps/software/GCCcore/6.4.0/bin/g++ -DCMAKE_PREFIX_PATH=/gpfs/ysm/project/beng469/beng469_my393/Assignment3-CNV/nlopt/out.build
make 
```
```
cd ../pyscicone
pip install scipy --upgrade --user
pip install . --user 
pip install jupyter --user
pip install PyQt5==5.9.2
```

#### Download the 10x Genomics data 

We apply SCICoNE to the 10x Genomics data set from section E of a frozen breast tumor tissue from a triple negative ductal carcinoma with an estimated tumor purity of 75%, which is available here (https://support.10xgenomics.com/single-cell-dna/datasets/1.1.0/breast_tissue_E_2k). The raw data contain 2053 cells and 154794 genomic bins. 

```
wget http://cf.10xgenomics.com/samples/cell-dna/1.1.0/breast_tissue_E_2k/breast_tissue_E_2k_cnv_data.h5
```

***
### Running SCICoNE on 10x Genomics data
```
ipython3
```
Import scicone and create the SCICoNE object.
```python
import scicone
import numpy as np

install_path = '../build/'
temporary_outpath = './'
seed = 42 # for reproducibility

np.random.seed(seed)

# Create SCICoNE object
sci = scicone.SCICoNE(install_path, temporary_outpath, verbose=False)
```

SCICoNE's API is prepared to handle the format from the standard cnv_data.h5 file produced by the 10x Genomics CNV pipeline. We use the function read_10x to extract the GC bias-corrected read counts, the unmappable bins and the chromosome stop bins to build the cells by bins matrix required by SCICoNE, and store everything at SCICoNE.data. We set downsampling_factor=10 to aggregate the 20kbp-sized bins into 200kbp.

```python
sci.read_10x('breast_tissue_E_2k_cnv_data.h5', downsampling_factor=10)
```

Let's normalize the cells by their total read counts and plot the data.
```python
normalized_counts = sci.data['filtered_counts'] / np.sum(np.abs(sci.data['filtered_counts']), axis=1).reshape(-1, 1)
normalized_counts *= normalized_counts.shape[1]

scicone.plotting.plot_matrix(normalized_counts, cbar_title='Normalized\n  counts',
                            chr_stops_dict=sci.data['filtered_chromosome_stops'], vmax=2,
                            cluster=True)
```
The first step is to find the breakpoints that define copy number regions. Because we assume breakpoints define copy number regions which are shared across cells, at this stage we use a random subset of 100 cells instead of the full batch. We pass the chromosome coordinates as known regions.

```python
# Take cells randomly
cell_subset = np.random.choice(2000, size=100, replace=False)
```
```python
bps = sci.detect_breakpoints(data=sci.data['filtered_counts'][cell_subset], verbosity=1,
                            input_breakpoints=list(sci.data['filtered_chromosome_stops'].values()),
                            window_size=50)
```
```python
scicone.plotting.plot_matrix(normalized_counts, bps=bps['segmented_regions'],
                             chr_stops_dict=sci.data['filtered_chromosome_stops'],
                             cbar_title='Normalized\n  counts', vmax=2)
```
Instead of assuming the copy number neutral state is 2 for all chromosomes, we will use the region_neutral_states argument of learn_trees to adjust the root of the copy number aberration tree. In this case the patient is a female, so we set all chromosomes to have 2 as neutral except chromosome Y, which has 0 copies.
```python
chr_neutral_states = dict(zip(sci.data['filtered_chromosome_stops'].keys(), 
                         [2] * len(sci.data['filtered_chromosome_stops'].keys())))
chr_neutral_states['Y'] = 0

region_neutral_states = scicone.utils.set_region_neutral_states(sci.bps['segmented_regions'], 
                                                                 list(sci.data['filtered_chromosome_stops'].values()), 
                                                                 list(chr_neutral_states.values()))
```
We are now ready to jointly call copy number states and reconstruct the event history tree.
```python
diploid_tree = sci.learn_tree(region_neutral_states=region_neutral_states, 
                              cluster_tree_n_iters=40000,
                              cluster=True, full=False, n_reps=10, max_tries=4,
                              copy_number_limit=4, seed=seed)
```
```python
diploid_tree.plot_tree(gene_labels=True, tumor_type='breast',
                       node_labels=True, node_sizes=True, event_fontsize=8, nodesize_fontsize=10)
```
Let's compare the normalized counts with the inferred copy number profiles. To facilitate the visualization, we group cells based on of their copy number states, and cluster the normalized counts of the cells within each clone.
```python
scicone.plotting.plot_matrix(normalized_counts, mode='data', cbar_title='Raw counts', vmax=2,
                            chr_stops_dict=sci.data['filtered_chromosome_stops'],
                            labels=diploid_tree.cell_node_labels)

scicone.plotting.plot_matrix(diploid_tree.outputs['inferred_cnvs'], mode='cnv', cbar_title='CNV', vmax=4,
                            chr_stops_dict=sci.data['filtered_chromosome_stops'],
                            labels=diploid_tree.cell_node_labels)
```
