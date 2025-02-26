
# BENG 469 Lab session 6 - instructions

In this computational lab, we will go through some of the downtream analysis for multi-modality epigenetic data using the examples of Nano CUT&Tag in the paper https://www.nature.com/articles/s41596-023-00932-6.

### Pre-lab task:
1. Download "L6_nanoCUTTag.Rmd" under "2-27-2025 _ L6 _ scCUT&Tag histone modification/" from Files on Canvas.

2. Upload the files to your project folder on HPC:

Open McCleary OnDemand at [beng469.ycrc.yale.edu](https://beng469.ycrc.yale.edu)  in a browser window, and go to **Files** menu and click open your project folder (/gpfs/gibbs/project/beng469/beng469_YourNetID).

Then create a new directory called "**Lab6**" and upload the files ("L6_nanoCUTTag.Rmd") under this new directory. 

### During the lab session (Thursday):

1. Open OOD at [beng469.ycrc.yale.edu](https://beng469.ycrc.yale.edu) in your web browser (make sure that you are on Yale Secure Network or Yale VPN).
2. Launch an Rstudio-server session:
Go to the Rstudio-server initialization page, and specify the parameters/resources as follows:

| Parameters      | Values |
| ----------- | ----------- |
| R version      | R/4.2.0-foss-2020b       |
| Number of hours   | 6        |
| Number of CPU cores per node   | 1        |
| Memory per CPU core in GiB   | 32       |
| Partitions   | devel / day / education     |

Then click Launch to launch an Rstudio session, and connect the Rstudio session once it’s started

3. Open the R markdown tutorials:

Once you are inside Rstudio, use the file navigation panel at the bottom right to click open your **project**/ folder then the **Lab6**/ folder you created, then click open “**L6_nanoCUTTag.Rmd**” . 
