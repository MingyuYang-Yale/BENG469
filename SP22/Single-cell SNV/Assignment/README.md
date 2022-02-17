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
Use ```vim``` to change mail user: 
```
vi submit.sh
```
* type ```i``` ( From command mode to insert mode type)

<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment2/2021-02-25/shellscripts.png" alt="foo bar" title="train &amp; tracks" /></p>

* hit ```esc``` key (From insert mode to command mode type)
* type ```:wq``` (write file and exit vim)
