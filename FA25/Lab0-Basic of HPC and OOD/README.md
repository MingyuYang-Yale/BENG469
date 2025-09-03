# Lab 0 : Basic of HPC and OOD (09/04/2025)

## Outline

* What is High-Performance computing (HPC)?

* How to access HPC?

* What is Open OnDemand (OOD)?

## What is HPC?

* High Performance Computing (HPC) cluster is a collection of networked computers and data storage.

<p><img width="400" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/cluster-v2.png" alt="foo bar" title="train &amp; tracks" />
    <img height="400" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/clusters.png" alt="foo bar" title="train &amp; tracks" />
</p>

* Access via the login nodes.
* Shared filesystem presents data across all nodes.
* Submit jobs scheduled to run on compute nodes.

### Why use HPC?
*  Don’t want to tie up your own machine 
*  Have many long running jobs to run
*  Want to run in parallel to get results quicker 
*  Need more disk space 
*  Need more memory
*  Want to use software installed on the cluster
*  Want to access data stored on the cluster 
*  Want to use GPUs 

### Yale HPC

|Cluster||CPUs|Nodes|Login Address|Purpose|
|------|-------|------|-------|------|------|
|<a href="https://docs.ycrc.yale.edu/clusters/bouchet/"> Bouchet </a>|<p><img height="100" src="https://docs.ycrc.yale.edu/img/edward-bouchet.jpg" alt="foo bar" title="train &amp; tracks" /> </p>|11,000|180|bouchet.ycrc.yale.edu|All research with low-risk data|
|<a href="https://docs.ycrc.yale.edu/clusters/grace/"> Grace </a>|<p><img height="100" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Grace.png" alt="foo bar" title="train &amp; tracks" /> </p>|26,000|670|grace.hpc.yale.edu|General|
|<a href="https://docs.ycrc.yale.edu/clusters/mccleary/"> McCleary </a>|<p><img height="100" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Mccleary.png" alt="foo bar" title="train &amp; tracks" /> </p>|13,000|340|mccleary.ycrc.yale.edu|Medical/Life science,YCGA|
|<a href="https://docs.ycrc.yale.edu/clusters/milgram/"> Milgram </a>|<p><img height="100" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Milgram.png" alt="foo bar" title="train &amp; tracks" /> </p>|2,000|50|milgram.hpc.yale.edu|Sensitive data|
|<a href="https://docs.ycrc.yale.edu/clusters/misha/"> Misha </a>|<p><img height="100" src="https://docs.ycrc.yale.edu/img/misha.jpeg" alt="foo bar" title="train &amp; tracks" /> </p>|2,000|40|misha.ycrc.yale.edu|<a href="https://wti.yale.edu/"> Wu Tsai Institute </a>|

More information: https://docs.ycrc.yale.edu/clusters/

----
## Setting up an account

You should have received an email from Yale Center for Research Computing:
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/mail-from-ycrc-bouchet-2025-2.png" alt="foo bar" title="train &amp; tracks" /></p>

### Log in to the HPC

Only reachable from Yale campus network:
- YaleSecure (on campus)
- Yale VPN (off campus)

#### Three general methods to login:
1. Command line SSH (Linux or MacOS)
```
    ssh beng469f_my393@bouchet.ycrc.yale.edu
```
2. Graphical ssh tool (MobaXterm for Windows)
  
3. Open OnDemand(OOD), web-based login

For the first two methods, you'll need an ssh key to access. The process of generating SSH keys varies depending on your platform. Find detailed instructions on how to generate and upload SSH keys <a href="https://docs.ycrc.yale.edu/clusters-at-yale/access/ssh/"> **here** </a> .

**In this class, we will mainly use Open OnDemand to access the HPC.** For more advanced use cases not well supported by the Open OnDemand, you can connect to the HPC using SSH.

## What is Open OnDemond(OOD)
- OOD is an open-source web portal for HPC centers to provide users with an easy-to-use web interface to HPC clusters.
- Web-based, doesn't require the installation of client software on your local machine.
- Easy to use and simple to learn.
- The easiest way to run GUI applications remotely on HPC.


### Access OOD

- Open OOD site for our class: <a href="https://secure.its.yale.edu/cas/login?service=https%3a%2f%2fbeng469f.ycrc.yale.edu%2fpun%2fsys%2fdashboard"> **beng469f.ycrc.yale.edu** </a>
- Log in with your Yale NetID and password
   <p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/bouchet-login.png" alt="foo bar" title="train &amp; tracks" /></p>

- After login you will see the OOD dashboard.

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-2025f.png" alt="foo bar" title="train &amp; tracks" /></p>

- Click **Clusters** -> **shell access**
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-ssh-login-2025f.png" alt="foo bar" title="train &amp; tracks" /></p>


- Click **Files**

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-storages-2025f.png" alt="foo bar" title="train &amp; tracks" /></p>

- Storage Types
  
|Name|Location|Good for|Quota|
|------|-------|------|-------|
|Home|~/|Scripts|125GiB/user|
|Project|~/project|Larger datasets (keep a copy elsewhere)|4TiB/Group|
|Scratch|~/scratch|Temporary, shared files, purged every 60 days|10TiB/Group|



- Click **interactive apps** -> **Rstudio Server**

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Rstudio-ood11.png" alt="foo bar" title="train &amp; tracks" /></p>

- After it’s running, then click the "connect to Rstudio Server".

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Rstudio-ood22.png" alt="foo bar" title="train &amp; tracks" /></p>

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Rstudio-ood33.png" alt="foo bar" title="train &amp; tracks" /></p>

- Click **interactive apps** -> **Jupyter**

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Python-ood11.png" alt="foo bar" title="train &amp; tracks" /></p>

- After it’s running, then click the "connect to Jupyter".
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Python-ood22.png" alt="foo bar" title="train &amp; tracks" /></p>

---
## Navigating Files and Directories by command line

```
who
```
You can find out where you are by running a command called:
```
pwd
```
(which stands for “print working directory”).

### List Your Files and Directories
We can see what’s in our home directory by running `ls`, which stands for “listing”:
```
ls 
```
```
ls -l
```
```
ls --help
```

### Move Around
The command to change locations is `cd` followed by a directory name to change our working directory. cd stands for “change directory”.
```
cd project
```

### Make a Directory
Create a new directory called "Lab0" 
```
mkdir Lab0
```
(mkdir means “make directory”)

change directory to "Lab0"
```
cd Lab0
```

### Copy a File
The cp command to copy a file 
```
cp /vast/palmer/scratch/beng469/beng469_my393/students.txt ./
```

### Rename a File
We can change the file’s name using `mv`, which is short for “move”:

```
mv students.txt students-beng469-sp25.txt
```

### Look inside files: 

#### ```cat```

The cat (short for “concatenate“), which means join together, we can use ```cat``` to join multiple files together and print out their contents. we can also use cat print out only a file's content.

Let's use ```cat``` to display contents of students-beng469-sp25.txt :  
```
cat students-beng469-sp25.txt
```
when you add ```-n``` flag can show us the line number
```
cat -n students-beng469-sp25.txt
```

#### ```head/tail```

head: output the first n lines of a file. 

```
head -n 5 students-beng469-sp25.txt
```
tail: output the last n lines of a file. 
```
tail -n 3 students-beng469-sp25.txt
```
Copy a cancer gene list file to your own directory:

```
cp /vast/palmer/scratch/beng469/beng469_my393/cancer-genes.txt ./
```
```
head cancer-genes.txt
```
```
tail cancer-genes.txt
```

#### ```less```
```
less cancer-genes.txt
```
* Use ```space bar``` to go to the next page, ```b``` move up one page.
* Use ```arrow key```:arrow_down: :arrow_up: to go down or go up just one line at a time. 
* Use ```q``` key to exit.


### Count lines, Words and Characters 

Next let's see how many lines/words/characters in a file, use ```wc``` command. ```wc``` is the “word count” command, it counts the number of lines, words, and characters in files.
```
wc students-beng469-sp25.txt
```

```
wc cancer-genes.txt
```

If we run wc -l instead of just wc, the output shows only the number of lines per file:
```
wc -l students-beng469-sp25.txt
```
You can also use -w to get only the number of words, or -c to get only the number of characters.


### Delete a File

```
rm students-beng469-sp25.txt
```
This command removes files (```rm``` is short for “remove”). 

Deleting Is Forever! Linux doesn’t have a trash bin that we can recover deleted files. So think twice when you use `rm` command.

```rm``` by default only works on files, not directories.


### Delete a directory

lets create two new test directories first.
```
mkdir test1 test2
```
To remove test1 directory, we can do this with the recursive option for rm : 

```
rm -r test1
```

Removing the files in a directory recursively can be a very dangerous operation. We can add the “interactive” flag -i to `rm` which will ask you to confirm the deletion
```
rm -r -i test2
```


### Quotas
To monitor your current storage usage & limits, run:
```
getquota
```
* All storage areas have quotas, both size and file count
* If you hit your limit, jobs fail
* Home quota is per user, small
* Project, scratch has a group quota shared with your group, large
  
---

## Transfer Data
- GUI-based: Open OnDemand, CyberDuck, MobaXterm
- Command line:  ```scp``` or ```rsync```
- For large datasets : Globus

#### Globus

- very fast
- automatic integrity checks
- Restartable
- Email notifications

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Globus.png" alt="foo bar" title="train &amp; tracks" /></p>

(More information about how to log in and tranfer files with globus <a href="https://docs.globus.org/how-to/get-started/?_gl=1*1s9ku91*_ga*MTczODQzNTcyMy4xNjg5Mjc2NzEw*_ga_7ZB89HGG0P*MTY5NDAzNDk5NC42LjEuMTY5NDAzNTAxMS4wLjAuMA..">  **here** </a>)

---


## Partitions
#### Public Purpose:
* **day**: for most batch jobs. This is the default if you don't specify one with --partition.
* **devel**: for jobs with which you need ongoing interaction. For example, exploratory analyses or debugging compilation.
* **week**: for jobs that need a longer runtime than day allows.
* **long**: for jobs that need a longer runtime than week allows.
* **gpu**: for jobs that make use of GPUs.
* **bigmem**: for jobs that have memory requirements other partitions can't handle.
* **scavenge**: uses idle nodes from other partitions (can be preempted).

#### PI Partitions
These partitions are purchased by groups for private use. 
#### YCGA partitions 
Intended for projects related to the Yale Center for Genome Analysis

**More information about Bouchet cluster, see** <a href="https://docs.ycrc.yale.edu/clusters/bouchet/">  **here** </a>

---
## Interactive vs. Batch

#### Interactive jobs:
* For development, debugging, or interactive environments like R and Matlab
* One or a few jobs at a time
#### Batch jobs:
* Non-interactive
* Can run many jobs simultaneously
* Usually your best choice for production computing

---
## Software

#### Modules
common software we have installed is available using module.  
To see available software, run module avail
```
module avail
```
```
module avail Python
```
```
module load Python
```

#### Module commands
|Command|Function|
|------|-------|
|module avail|Browse all modules|
|module avail string|Find module with string in name|
|module load name|Make a module available for use|
|module list|show loaded modules|
|module unload name|unload a module|
|module purge|unload all modules|

---

## **Online Tutorials**

https://docs.ycrc.yale.edu/resources/online-tutorials/

https://research.computing.yale.edu/self-guided-training-resources#hpc

https://www.youtube.com/watch?si=C76V3SUrr7H46Kpj&v=Wvao_o1ACBQ&feature=youtu.be
https://www.youtube.com/watch?si=135TmpuvVE1MQ6eF&v=_kMHT_tkweo&feature=youtu.be
https://www.youtube.com/watch?si=2-45fmJpKxjPPnfz&v=qCeqjStTXcE&feature=youtu.be

---


https://supercontainers.github.io/hpc-containers-survey/2024/two-thousand-twenty-four/
