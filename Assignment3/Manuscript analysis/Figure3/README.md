(connect to Yale's VPN if off campus)
```
scp beng469_my393@farnam.hpc.yale.edu:/gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV/Figure3abxxxxx.Rmd ./

scp beng469_my393@farnam.hpc.yale.edu:/gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV/MDP_allsamples_results.rds ./

scp beng469_my393@farnam.hpc.yale.edu:/gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV/MDP_trajectory_allsamples_for_each_gene.rds ./
```

#### Open Rstudio Cloud (https://rstudio.cloud/projects)

Open a New Project and upload these following files: 
1. **Fig3ab-20210118A.Rmd** , 
2. **final_sample_summary.rds** 
3. **MDP_allsamples_results.rds**
4. **MDP_trajectory_allsamples_for_each_gene.rds**

```
ssh -Y beng469_my393@farnam.hpc.yale.edu
srun --pty --x11 -p interactive --mem=50g bash
```

```
cd /gpfs/ysm/project/beng469/beng469_my393
cd Assignment3-SNV
```

