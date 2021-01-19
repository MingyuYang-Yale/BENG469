#### Submit task to compute node 

(connect to Yale's VPN if off campus)

```
ssh -Y beng469_my393@farnam.hpc.yale.edu

srun --pty --x11 -p interactive --mem=50g bash

cd /gpfs/ysm/project/beng469/beng469_my393

cd Assignment3-SNV

cp /gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV/Figure3.r ./

module load R/3.6.1-foss-2018b

sbatch Figure3.sh
```
#### Open a new terminal window:
```
scp beng469_my393@farnam.hpc.yale.edu:/gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV/Figure3abxxxxx.Rmd ./

scp beng469_my393@farnam.hpc.yale.edu:/gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV/MDP_allsamples_results.rds ./

scp beng469_my393@farnam.hpc.yale.edu:/gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV/MDP_trajectory_allsamples_for_each_gene.rds ./
```

#### Open Rstudio Cloud (https://rstudio.cloud/projects)

Open a New Project and upload these following files: 
1. final_sample_summary.rds 
2. pheno.rds

3. Fig3ab-20210118A.Rmd  
4. MDP_allsamples_results.rds
5. MDP_trajectory_allsamples_for_each_gene.rds

```
ssh -Y beng469_my393@farnam.hpc.yale.edu
srun --pty --x11 -p interactive --mem=50g bash
```


