# Basic of HPC and OOD (09/07/2023)


### Outline

* What is HPC?

* How to access HPC?

* How to transfer data?

* What is OOD?


### What is HPC?

* High Performance Computing (HPC) cluster is a collection of networked computers and data storage.
* HPC are modern day supercompters (rack-mounted computers, Networking, Storage)


<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/clusters.png" alt="foo bar" title="train &amp; tracks" /></p>


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

Three general methods to login:
- Command line ssh (Linux or MacOS)  beng469_netid@mccleary.ycrc.yale.edu
- Graphical ssh tool (MobaXterm Windows)
- Open OnDemand, web-based login  beng469.ycrc.yale.edu

research.computing.yale.edu
docs.ycrc.yale.edu
