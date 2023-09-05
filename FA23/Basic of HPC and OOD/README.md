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

## Yale Clusters

|Cluster||CPUs|Nodes|Login Address|Purpose||
|------|-------|------|-------|------|------|------|
|Grace|<p><img height="150" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Grace.png" alt="foo bar" title="train &amp; tracks" /> </p>|69,000|740|grace.hpc.yale.edu|general|The Grace cluster is is named for the computer scientist and United States Navy Rear Admiral Grace Murray Hopper, who received her Ph.D. in Mathematics from Yale in 1934.|
|McCleary|<p><img height="150" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Mccleary.png" alt="foo bar" title="train &amp; tracks" /> </p>|13,000|340|mccleary.ycrc.yale.edu|medical/life science,YCGA|Named for Beatrix McCleary Hamburg, who received her medical degree in 1948 and was the first female African American graduate of Yale School of Medicine.|
|Milgram|<p><img height="150" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/Milgram.png" alt="foo bar" title="train &amp; tracks" /> </p>|2,400|80|milgram.hpc.yale.edu|HIPAA and other sensitive data|Milgram is named for Dr. Stanley Milgram, a psychologist who researched the behavioral motivations behind social awareness in individuals and obedience to authority figures. He conducted several famous experiments during his professorship at Yale University including the lost-letter experiment, the small-world experiment, and the Milgram experiment.|



research.computing.yale.edu
docs.ycrc.yale.edu
