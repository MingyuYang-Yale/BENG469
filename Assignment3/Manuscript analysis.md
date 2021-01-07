## Manuscript analysis

```
mkdir Manuscript_analysis && cd Manuscript_analysis
```

(https://github.com/bowmanr/scDNA_myeloid/tree/master/data)

```
wget https://github.com/bowmanr/scDNA_myeloid/blob/master/data/final_NGTs.rds
wget https://github.com/bowmanr/scDNA_myeloid/blob/master/data/final_sample_summary.rds
wget https://github.com/bowmanr/scDNA_myeloid/blob/master/data/pheno.rds
```

### Figure 1: Cohort characterization

#### Open R:
```
R
```
```
# load R packages
library(dplyr)
library(tidyr)
library(ggplot2)
```
setwd("/gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV")
