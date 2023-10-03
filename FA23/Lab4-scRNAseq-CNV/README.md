# BENG 469 Lab session 4 - instructions

In this computational lab, we will go through examples of calculating single cell copy number profiles from 10X single cell RNA data, predicting tumor and normal cells, and inferring tumor subclones from using [CopyKAT](https://github.com/navinlabcode/copykat) and [InferCNV](https://github.com/broadinstitute/inferCNV/wiki). We will try to replicate the results presented in Figure 2a and 2c from the [Paper](https://www.nature.com/articles/s41587-020-00795-2) discussed last Thursday.

---

#### 1. Prerequisites:

- Since the HPC is temporarily unavailable due to scheduled maintenance, I will be conducting the lab session using my personal laptop for demonstration purposes.
- Considering the diverse local machines we use, unexpected errors may occur. If you prefer, you can choose to observe and listen during the lab session and revisit the materials once the HPC is back online.
- **Alternatively**, to actively participate during the session, please make sure to [install R](https://cran.r-project.org/) and [R Studio](https://posit.co/download/rstudio-desktop/) on your own laptop before the lab session.
  
#### 2. Download files:
Download the folder "10-5-2023 _ L4 _ scRNA-seq (4) CNV and clonal heterogeneity" from Files on Canvas.
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/download-1.png" alt="foo bar" title="train &amp; tracks" /></p>

#### 3. Open the R project and all RMD files

- Open the downloaded folder named '10-5-2023 _ L4 _ scRNA-seq (4) CNV and clonal heterogeneity.' Within this folder, click on the 'Lab4-scRNAseq-CNV.Rproj' file to launch Rstudio and initiate the R project.
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/demo1.png" alt="foo bar" title="train &amp; tracks" /></p>
- Open 'Install_packages.Rmd', install the related R packages on your local R environment (this should take approximately 10-20 minutes):
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/demo2.png" alt="foo bar" title="train &amp; tracks" /></p>

- Open both 'CopyKAT.Rmd' and 'InferCNV.Rmd' by clicking on them.
