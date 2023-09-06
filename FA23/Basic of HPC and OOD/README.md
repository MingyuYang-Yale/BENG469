# Basic of HPC and OOD (09/07/2023)


### Outline

* What is HPC?

* How to access HPC?

* What is OOD?

* How to transfer data to HPC?


### What is HPC?

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

## Yale HPC

|Cluster||CPUs|Nodes|Login Address|Purpose|
|------|-------|------|-------|------|------|
|Grace|<p><img height="100" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Grace.png" alt="foo bar" title="train &amp; tracks" /> </p>|69,000|740|grace.hpc.yale.edu|general|
|McCleary|<p><img height="100" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Mccleary.png" alt="foo bar" title="train &amp; tracks" /> </p>|13,000|340|mccleary.ycrc.yale.edu|medical/life science,YCGA|
|Milgram|<p><img height="100" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Milgram.png" alt="foo bar" title="train &amp; tracks" /> </p>|2,400|80|milgram.hpc.yale.edu|HIPAA and other sensitive data|


## Setting up an account

You should have received a email from Yale Center for Research Computing:
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/mail-from-ycrc-mccleary.png" alt="foo bar" title="train &amp; tracks" /></p>

## Log in to the HPC

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

- For the first two methods, you'll need an ssh key to access. The process of generating SSH keys varies depending on your platform. Find detailed instructions on how to generate and upload SSH keys here. [https://docs.ycrc.yale.edu/clusters-at-yale/access/](https://docs.ycrc.yale.edu/clusters-at-yale/access/ssh/)
- In this class, we will mainly use Open OnDemand to access the HPC. For more advanced use cases not well supported by the Open OnDemand, you can connect to the HPC using SSH.

```
beng469.ycrc.yale.edu
```
## Storage Types
|Name|Location|Good for|Quota|
|------|-------|------|-------|
|Home|~/|Scripts,final results|125GiB/Person|
|Project|~/project|Larger datasets (keep a copy elsewhere)|4TiB/Group|
|Scratch60|~/scratch|Temporary, shared files, purged every 60 days|10TiB/Group|
---
## Quotas
* To check our course’s cluster quotas, run:
```
getquota
```
* All storage areas have quotas, both size and file count
* If you hit your limit, jobs fail
* Home quota is per user, small
* Project, scratch has a group quota shared with your group, large
---

## Transfer Data to the HPC

- command line:  ```scp``` or ```rsync```
- GUI-based: Open OnDemand, CyberDuck, MobaXterm
- For large datasets : Globus

## What is Open OnDemond(OOD)
- OOD is an open-source web portal for HPC centers to provide users with an easy-to-use web interface to HPC clusters.
- Web-based, doesn't require the installation of client software on your local machine.
- Easy to use and simple to learn.
- The easiest way to run GUI applications remotely on a cluster.

Install R package

Due to the limited time, we can only give an brief introduction here. we will keep adding more materials to it on the following classes.

More need to learn:

R
Python
Linux
Slurm

student has different level, so 

research.computing.yale.edu
docs.ycrc.yale.edu
