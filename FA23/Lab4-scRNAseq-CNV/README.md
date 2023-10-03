# BENG 469 Lab session 4 - instructions

In this computational lab, we will go through examples of calculating single cell copy number profiles from 10X single cell RNA data, predicting tumor and normal cells, and inferring tumor subclones from using CopyKAT and InferCNV. We will try to replicate the results presented in Figure 2a and 2c from the [Paper](https://www.nature.com/articles/s41587-020-00795-2) discussed in our session last Thursday.


### InferCNV: 

Inferring copy number alterations from tumor single cell RNA-Seq data.[Tutorial](https://github.com/broadinstitute/inferCNV/wiki)


### CopyKAT
Inference of genomic copy number and subclonal structure of human tumors from high-throughput single cell RNAseq data. [Tutorial](https://github.com/navinlabcode/copykat)


<p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/copykat-paper.png" alt="foo bar" title="train &amp; tracks" /></p>
<p><img width="650" src="https://media.springernature.com/full/springer-static/image/art%3A10.1038%2Fs41587-020-00795-2/MediaObjects/41587_2020_795_Fig2_HTML.png?as=webp" alt="foo bar" title="train &amp; tracks" /></p>

***

### 1. Open Farnam OnDemand:

Go to [beng469.ycrc.yale.edu](https://beng469.ycrc.yale.edu) in your web browser (make sure that you are on Yale Network or Yale VPN). You will see the following window once you logged in.

<p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/ood-1.png" alt="foo bar" title="train &amp; tracks" /></p>


### 2. Click open **Clusters** -> **Farnam Shell Access**

<p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/ood-0.png" alt="foo bar" title="train &amp; tracks" /></p>
<p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/ood-00.png" alt="foo bar" title="train &amp; tracks" /></p>

### 3. Copy **scRNA-CNV** to your project folder :

```
cd project
```
Copy the demo data and codes:
```
cp -r /gpfs/ysm/project/beng469/beng469_my393/scRNA-CNV ./
```

### 4. Click open **RStudio Server**

<p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/ood-2.png" alt="foo bar" title="train &amp; tracks" /></p>

### 5. Request computation resources

 Specify the resources as shown below 
 
 Additional module: **JAGS/4.3.0-foss-2020b**
 
 (you can leave other optional boxes blank), then click **Launch**
 
 <p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/ood-000.jpg" alt="foo bar" title="train &amp; tracks" /></p>

### 6. Lauch Rstudio Server
Wait for a few seconds until you see your requested session is running, then click **Connect to RStudio Server**. You will see a new window poping out.

<p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/ood-4.png" alt="foo bar" title="train &amp; tracks" /></p>

### 7. Open the **CopyKAT** and **InferCNV** RMD files inside Rstudio Server

Inside Rstudio, click the ellipsis icon in the file navigating panel at the bottom right. 

<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/ood-5.png" alt="foo bar" title="train &amp; tracks" /></p>

In the "Go To Folder" window that pops out, paste ```~/project/scRNA-CNV``` to the "Directory" box: , then click "Ok". 

<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/ood-6.png" alt="foo bar" title="train &amp; tracks" /></p>

This will lead you to the directory where CopyKAT.Rmd and InferCNV.Rmd are located. You can click these files to open them.


