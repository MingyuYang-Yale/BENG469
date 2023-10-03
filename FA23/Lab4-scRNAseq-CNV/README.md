# BENG 469 Lab session 4 - instructions

In this computational lab, we will go through examples of calculating single cell copy number profiles from 10X single cell RNA data, predicting tumor and normal cells, and inferring tumor subclones from using [CopyKAT](https://github.com/navinlabcode/copykat) and [InferCNV](https://github.com/broadinstitute/inferCNV/wiki). We will try to replicate the results presented in Figure 2a and 2c from the [Paper](https://www.nature.com/articles/s41587-020-00795-2) discussed last Thursday.

#### 1. Prerequisites:

As the HPC is temporarily unavailable due to scheduled maintenance, I will conducting the lab session using my personal laptop for demonstration purposes. To actively participate during the session, please [install R](https://cran.r-project.org/) and [R Studio](https://posit.co/download/rstudio-desktop/) on your own laptop prior to the lab session. Alternatively, you can listen during the lab session, and then revisit the materials once the HPC is back online.

#### 2. Download files:
Download the folder "10-5-2023 _ L4 _ scRNA-seq (4) CNV and clonal heterogeneity" from Files on Canvas.
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/download-1.png" alt="foo bar" title="train &amp; tracks" /></p>

#### 3. Open the **CopyKAT** and **InferCNV** RMD files inside Rstudio Server

Inside Rstudio, click the ellipsis icon in the file navigating panel at the bottom right. 

<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/ood-5.png" alt="foo bar" title="train &amp; tracks" /></p>

In the "Go To Folder" window that pops out, paste ```~/project/scRNA-CNV``` to the "Directory" box: , then click "Ok". 

<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/ood-6.png" alt="foo bar" title="train &amp; tracks" /></p>

This will lead you to the directory where CopyKAT.Rmd and InferCNV.Rmd are located. You can click these files to open them.


