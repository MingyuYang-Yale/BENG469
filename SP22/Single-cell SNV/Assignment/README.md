---
#### Login HPC:
(need to connect to Yale's **VPN** if off campus)

```
ssh beng469_NETID@farnam.hpc.yale.edu
```
```
srun --pty -p interactive --mem=5g bash
```
```
cd project
```
```
cd scDNA-SNV
```
#### Copy the following two files to your own folder.
```
cp /gpfs/ysm/project/beng469/beng469_my393/00.bin/MDP_trajectory.r ./
```
```
cp /gpfs/ysm/project/beng469/beng469_my393/00.bin/submit.sh ./
```

#### open R
```
module load R/3.6.1-foss-2018b
```
