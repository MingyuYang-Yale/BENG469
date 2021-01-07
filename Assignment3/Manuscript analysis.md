## Manuscript analysis

(https://github.com/bowmanr/scDNA_myeloid/tree/master/data)
```
cp /gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV/data/*.rds ./data
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
```
setwd("/gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV")
final_NGTs<-readRDS(file="./data/final_NGTs.rds")
pheno<-readRDS(file="./data/pheno.rds")
```
```
#exclude samples <100 cells.

high_quality_samples<-names(final_NGTs)[sapply(names(final_NGTs),function(x){
  nrow(final_NGTs[[x]])>100
})]
```
