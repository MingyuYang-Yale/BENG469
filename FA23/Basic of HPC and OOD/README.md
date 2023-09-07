# Basic of HPC and OOD (09/07/2023)

## Outline

* What is HPC?

* How to access HPC?

* What is OOD?


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
|Grace|<p><img height="100" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Grace.png" alt="foo bar" title="train &amp; tracks" /> </p>|69,000|740|grace.hpc.yale.edu|general|
|McCleary|<p><img height="100" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Mccleary.png" alt="foo bar" title="train &amp; tracks" /> </p>|13,000|340|mccleary.ycrc.yale.edu|medical/life science,YCGA|
|Milgram|<p><img height="100" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Milgram.png" alt="foo bar" title="train &amp; tracks" /> </p>|2,400|80|milgram.hpc.yale.edu|HIPAA and other sensitive data|


## Setting up an account

You should have received a email from Yale Center for Research Computing:
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/mail-from-ycrc-mccleary.png" alt="foo bar" title="train &amp; tracks" /></p>

### Log in to the HPC

Only reachable from Yale campus network:
- YaleSecure (on campus)
- Yale VPN (off campus)

#### Three general methods to login:
1. Command line SSH (Linux or MacOS)
```
    ssh beng469_netid@mccleary.ycrc.yale.edu
```
2. Graphical ssh tool (MobaXterm Windows)
  
3. Open OnDemand(OOD), web-based login

- For the first two methods, you'll need an ssh key to access. The process of generating SSH keys varies depending on your platform. Find detailed instructions on how to generate and upload SSH keys <a href="https://docs.ycrc.yale.edu/clusters-at-yale/access/ssh/"> **here** </a> .
- **In this class, we will mainly use Open OnDemand to access the HPC.** For more advanced use cases not well supported by the Open OnDemand, you can connect to the HPC using SSH.

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

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood.png" alt="foo bar" title="train &amp; tracks" /></p>

- click **Clusters** -> **shell access**
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-ssh-login.png" alt="foo bar" title="train &amp; tracks" /></p>

- click **Files**

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-storages.png" alt="foo bar" title="train &amp; tracks" /></p>

#### Storage Types
|Name|Location|Good for|Quota|
|------|-------|------|-------|
|Home|~/|Scripts|125GiB/Person|
|Project|~/project|Larger datasets (keep a copy elsewhere)|4TiB/Group|
|Scratch|~/scratch|Temporary, shared files, purged every 60 days|10TiB/Group|

#### Quotas
* To check our course’s cluster quotas, run:
```
getquota
```
* All storage areas have quotas, both size and file count
* If you hit your limit, jobs fail
* Home quota is per user, small
* Project, scratch60 has a group quota shared with your group, large
---

- click **interactive apps** -> **Rstudio Server**

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ood-rstudio.png" alt="foo bar" title="train &amp; tracks" /></p>

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

