# BENG 469 Lab session 4 - instructions

In this computational lab, we will go through examples of calculating single cell copy number profiles from 10X single cell RNA data, predicting tumor and normal cells, and inferring tumor subclones from using [CopyKAT](https://github.com/navinlabcode/copykat) and [InferCNV](https://github.com/broadinstitute/inferCNV/wiki). We will try to replicate the results presented in Figure 2a and 2c from the [Paper](https://www.nature.com/articles/s41587-020-00795-2) discussed last Thursday.

#### 1. Prerequisites:

- HPC is currently under maintenance, so I will be conducting the lab session using my personal laptop for demonstration purposes.
- The files and data are uploaded to Canvas, you can download and upload them to HPC once it's back online, and run the analysis after the lab session.
- **Alternatively**, to actively participate during the session, you can [install R](https://cran.r-project.org/) and [R Studio](https://posit.co/download/rstudio-desktop/) on your own laptop prior the lab session and follow the instructions below on how to run the analysis locally on your own computer.
  
#### 2. Download files:
Download the folder "10-5-2023 _ L4 _ scRNA-seq (4) CNV and clonal heterogeneity" from Files on Canvas.
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/download-1.png" alt="foo bar" title="train &amp; tracks" /></p>

#### 3. Open the R project

- Open the downloaded folder named '10-5-2023 _ L4 _ scRNA-seq (4) CNV and clonal heterogeneity.' Within this folder, click on the 'Lab4-scRNAseq-CNV.Rproj' file to launch Rstudio and initiate the R project.
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/demo1.png" alt="foo bar" title="train &amp; tracks" /></p>


#### 4. Install related R packages (this should take approximately 10-20 minutes).

- Click to open 'Install_packages.Rmd'

<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/demo2.png" alt="foo bar" title="train &amp; tracks" /></p>

- Upon opening 'Install_packages.Rmd', you may notice a triangular icon appearing in the top left panel, indicating that certain packages need to be installed (as shown below). If you see this, please click "Install".

<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/demo3.png" alt="foo bar" title="train &amp; tracks" /></p>

- After clicking the "Install", a green progress bar will appear in the bottom left panel (as depicted below).

<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/demo4.png" alt="foo bar" title="train &amp; tracks" /></p>

- Next, run the first and second code chunks to initiate the package installation process.

- During the installation process, you will be prompted to interactively decide whether you want to update any existing packages. To decline updates, type ***'n'*** for No or ***'3'*** for None (as illustrated below).

<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/demo5.png" alt="foo bar" title="train &amp; tracks" /></p>
<p><img width="1000" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/demo6.png" alt="foo bar" title="train &amp; tracks" /></p>

- If you encounter errors when attempting to install this line: ```devtools::install_github("broadinstitute/inferCNV_NGCHM")```, please try to instal the standalone [JAGS](https://sourceforge.net/projects/mcmc-jags/files/JAGS/4.x/) software first and then attempt the installation again.

#### 5. Open both 'CopyKAT.Rmd' and 'InferCNV.Rmd' by clicking on them.

--- 

### CopyKAT Analysis Workflow

<p><img width="1000" src="https://media.springernature.com/full/springer-static/image/art%3A10.1038%2Fs41587-020-00795-2/MediaObjects/41587_2020_795_Fig1_HTML.png?as=webp" alt="foo bar" title="train &amp; tracks" /></p>

- The workflow takes the gene expression matrix as input.
- use Freeman-Turkey transformation to stabilize variance
- use dynamic linear modeling (DLM) to smooth the outliers.
- Define normal cells by the cluster that have minimal variance as estimated by Gaussian Mixture Model(GMM)
- Find the copy number variation breakpoints by using Markov Chain Monte Carlo(MCMC) segmentation and Kolmogorov-Smirnov(KS) testing.
- Perform hierarchical clustering to predict aneuploid turmor cells from the normal diploid cells.
- cluter the single cell copy number data to identify clonal subpopulations.



---

## Using HPC 

If you wanna do the analysis on HPC after it's back online, 

1. Go to [beng469.ycrc.yale.edu](https://beng469.ycrc.yale.edu) in your web browser (make sure that you are on Yale Secure Network or Yale VPN).

2. Go to the Rstudio-server initialization page, and specify the parameters/resources as follows:

| Parameters      | Values |
| ----------- | ----------- |
| R version      | R/4.2.0-foss-2020b       |
| Number of hours   | 6        |
| Number of CPU cores per node   | 8        |
| Memory per CPU core in GiB   | 10       |
| Partitions   | day        |
| Reservation (optional)   | beng469        |
| Additional modules (optional)  | JAGS/4.3.0-foss-2020b   |

Then click Launch to launch an Rstudio session, and connect the Rstudio session once it’s started





