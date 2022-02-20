
This is the assignment instruction for the SNV part. Try to finish this assignment in two weeks (before March 6 23:59 EST).

If you have any difficuties to finish this assignment, feel free to contact us.

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
* change email address

<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment2/2021-02-25/email3.png" alt="foo bar" title="train &amp; tracks" /></p>

* hit ```esc``` key (From insert mode to command mode type)
* type ```:wq``` (write file and exit vim)

#### Submit job 
```
sbatch submit.sh 
```

You will get emails when the job begin and end. (This job will takes ~ 2 days to finish when HPC crowded)
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment2/2021-02-25/email2.png" alt="foo bar" title="train &amp; tracks" /></p>

<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment2/2021-02-25/email1.png" alt="foo bar" title="train &amp; tracks" /></p>


#### Results:

There are 2 rds files generated:

MDP_allsamples_results.rds

MDP_trajectory_allsamples_for_each_gene.rds
