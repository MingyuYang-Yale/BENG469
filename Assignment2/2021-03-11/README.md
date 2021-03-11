
#### open Rstudio Cloud (https://rstudio.cloud/)
Download ZIP : https://github.com/MingyuYang-Yale/BENG469



---
### Login HPC:
(need to connect to Yale's **VPN** if off campus)

```
ssh beng469_my393@farnam.hpc.yale.edu
```
```
srun --pty -p interactive --mem=50g bash
```
```
cd project
```
```
cd Assignment2-SNV
```
#### Copy the following two files to your own folder.
```
cp /gpfs/ysm/project/beng469/beng469_my393/Assignment2-SNV/Figure3.r ./
```
```
cp /gpfs/ysm/project/beng469/beng469_my393/Assignment2-SNV/Figure3.sh ./
```
open R
```
module load R/3.6.1-foss-2018b
```
```
R
```
Install R packages (about 5 mins)
* (CRAN mirrors choose "1")
```
install.packages('knitr')
```
```
install.packages('kableExtra')
```
```
install.packages('ReinforcementLearning')
```
```
install.packages('dplyr')
```
```
install.packages('tidyr')
```
```
install.packages('reshape2')
```
```
install.packages('igraph')
```

```
quit()  # choose n to not save workspace image
```
