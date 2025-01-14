# Basic of HPC and OOD (01/16/2025)

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
|Grace|<p><img height="100" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Grace.png" alt="foo bar" title="train &amp; tracks" /> </p>|16,000|740|grace.hpc.yale.edu|General|
|McCleary|<p><img height="100" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Mccleary.png" alt="foo bar" title="train &amp; tracks" /> </p>|13,000|340|mccleary.ycrc.yale.edu|Medical/Life science,YCGA|
|Milgram|<p><img height="100" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Milgram.png" alt="foo bar" title="train &amp; tracks" /> </p>|2,000|50|milgram.hpc.yale.edu|HIPAA and other sensitive data|
|Misha|<p><img height="100" src="https://docs.ycrc.yale.edu/img/misha.jpeg" alt="foo bar" title="train &amp; tracks" /> </p>|2,000|40|misha.ycrc.yale.edu|<a href="https://wti.yale.edu/"> Wu Tsai Institute </a>|
|Bouchet|<p><img height="100" src="https://docs.ycrc.yale.edu/img/edward-bouchet.jpg" alt="foo bar" title="train &amp; tracks" /> </p>|4,000|60|Coming Soon |<a href="https://www.mghpcc.org/"> Massachusetts Green High Performance Computing Center (MGHPCC) </a>|

More information: https://docs.ycrc.yale.edu/clusters/

----
## Setting up an account

You should have received a email from Yale Center for Research Computing:
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/mail-from-ycrc-mccleary-2025.png" alt="foo bar" title="train &amp; tracks" /></p>

### Log in to the HPC

Only reachable from Yale campus network:
- YaleSecure (on campus)
- Yale VPN (off campus)

#### Three general methods to login:
1. Command line SSH (Linux or MacOS)
```
    ssh beng469_netid@mccleary.ycrc.yale.edu
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

- open OOD site for our class: 
```
beng469.ycrc.yale.edu
```
- Log in with your Yale NetID and password
   <p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-login.png" alt="foo bar" title="train &amp; tracks" /></p>

- After login you will see the OOD dashboard.

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-2025.png" alt="foo bar" title="train &amp; tracks" /></p>

- click **Clusters** -> **shell access**
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-ssh-login-2025.png" alt="foo bar" title="train &amp; tracks" /></p>


- click **Files**

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-storages-2025.png" alt="foo bar" title="train &amp; tracks" /></p>

#### Storage Types
|Name|Location|Good for|Quota|
|------|-------|------|-------|
|Home|~/|Scripts|125GiB/Person|
|Project|~/project|Larger datasets (keep a copy elsewhere)|4TiB/Group|
|Scratch|~/scratch|Temporary, shared files, purged every 60 days|10TiB/Group|

#### Quotas
To check our course’s cluster quotas, you can click **Utilities** -> **Quotas**
  <p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/quota-check.png" alt="foo bar" title="train &amp; tracks" /></p>

* All storage areas have quotas, both size and file count
* If you hit your limit, jobs fail
* Home quota is per user, small
* Project, scratch60 has a group quota shared with your group, large
---

- click **interactive apps** -> **Rstudio Server**

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-rstudio-2025.png" alt="foo bar" title="train &amp; tracks" /></p>

## Transfer Data
- Command line:  ```scp``` or ```rsync```
- GUI-based: Open OnDemand, CyberDuck, MobaXterm
- For large datasets : Globus

#### Globus

- very fast
- automatic integrity checks
- Restartable
- Email notifications

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Globus.png" alt="foo bar" title="train &amp; tracks" /></p>

(More information about how to log in and tranfer files with globus <a href="https://docs.globus.org/how-to/get-started/?_gl=1*1s9ku91*_ga*MTczODQzNTcyMy4xNjg5Mjc2NzEw*_ga_7ZB89HGG0P*MTY5NDAzNDk5NC42LjEuMTY5NDAzNTAxMS4wLjAuMA..">  **here** </a>)



change directory to **project**.
```
cd project
```
list what’s in your **project** directory by running ```ls```
```
ls 
```
### Rename a File
draft.txt isn’t a particularly informative name, so let’s change the file’s name using mv, which is short for “move”:

```
mv draft.txt students-list.txt
```

The first parameter tells mv what we’re “moving”, while the second is where it’s to go. In this case, we’re moving draft.txt to student-list.txt, which has the same effect as renaming the file. 


### Copy a File
The cp command works very much like mv, except it copies a file instead of moving it. 
```
cp students-list.txt students-list-sp22.txt
```
```
ls -lrt
```

### Look inside files: 

#### ```cat```

The cat (short for “concatenate“), which means join together, we can use ```cat``` to join multiple files together and print out their contents. we can also use cat print out only a file's content.

Let's use ```cat``` to display contents of students-list.txt :  
```
cat students-list-sp22.txt
```
when you add ```-n``` flag can show us the line number
```
cat -n students-list-sp22.txt
```
---
#### ```head/tail```

head: output the first n lines of a file. 

```
head -n 5 students-list-sp22.txt 
```
tail: output the last n lines of a file. 
```
tail -n 3 students-list-sp22.txt  
```
Copy a cancer gene list file to your own directory:

```
cp /gpfs/ysm/project/beng469/beng469_my393/00.database/cancer-gene.txt ./
```
```
head cancer-gene.txt
```
```
tail cancer-gene.txt
```

---
#### ```less```
```
less cancer-gene.txt
```
* Use ```space bar``` to go to the next page, ```b``` move up one page.
* Use ```arrow key```:arrow_down: :arrow_up: to go down or go up just one line at a time. 
* Use ```q``` key to quit out less.

---
### Count lines, Words and Characters 

Next let's see how many lines/words/characters in a file, use ```wc``` command. ```wc``` is the “word count” command, it counts the number of lines, words, and characters in files.
```
wc students-list.txt
```

```
wc cancer-gene.txt
```

If we run wc -l instead of just wc, the output shows only the number of lines per file:
```
wc -l students-list.txt
```
You can also use -w to get only the number of words, or -c to get only the number of characters.

---
### Delete a File

```
rm students-list.txt
```
This command removes files (```rm``` is short for “remove”). 

Deleting Is Forever! Linux doesn’t have a trash bin that we can recover deleted files. Instead, when we delete files, they are unhooked from the file system so that their storage space on disk can be recycled. 

```rm``` by default only works on files, not directories.



### Delete a directory

To remove testdata directory, we can do this with the recursive option for rm : 

```
rm -r testdata
```

Removing the files in a directory recursively can be a very dangerous operation. If we’re concerned about what we might be 
deleting we can add the “interactive” flag -i to rm which will ask us for confirmation before each step.
```
rm -r -i testdata
```
This removes everything in the directory, then the directory itself, asking at each step for you to confirm the deletion.


---
## Slurm Overview
#### Slurm manages all the details of compute node usage:
* Prioritizing and scheduling jobs
* Listing running and pending jobs
* Canceling jobs
* Checking job resource usage

#### General workflow for jobs
* You request an allocation
* Slurm finds then grants you compute resources
* You run commands or execute a script on those resources
* You or your script exits and system automatically releases resources

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

**More information about Mccleary cluster, see** <a href="https://docs.ycrc.yale.edu/clusters/mccleary/">  **here** </a>

## Interactive vs. Batch

#### Interactive jobs:
* For development, debugging, or interactive environments like R and Matlab
* One or a few jobs at a time
#### Batch jobs:
* Non-interactive
* Can run many jobs simultaneously
* Usually your best choice for production computing

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


https://research.computing.yale.edu/training/introduction-hpc

https://research.computing.yale.edu/ycrc-bootcamp-practical-introduction-linux 

https://research.computing.yale.edu/training/intro-python

https://research.computing.yale.edu/r-optimization-training-video 

