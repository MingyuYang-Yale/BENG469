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
- Command line SSH (Linux or MacOS)
```
ssh beng469_netid@mccleary.ycrc.yale.edu
```
- Graphical ssh tool (MobaXterm Windows)
- Open OnDemand(OOD), web-based login
```
beng469.ycrc.yale.edu
```
For most users, we recommend using the OOD, to access the clusters.

## SSH Connection (Linux or MacOS)

https://docs.ycrc.yale.edu/clusters-at-yale/access/ssh/

#### Generate Your Key Pair on macOS and Linux

To generate a new key pair, first open a terminal/xterm session. 

If you are on macOS, open Applications -> Utilities -> Terminal.
Generate your public and private ssh keys. Type the following into the terminal window:
```
ssh-keygen
```
Your terminal should respond:

    Generating public/private rsa key pair. 
    Enter file in which to save the key (/home/yourusername/.ssh/id_rsa):

Press Enter to accept the default value. Your terminal should respond:

    Enter passphrase (empty for no passphrase):
Choose a secure passphrase. Your passphrase will prevent access to your account in the event your private key is stolen. You will not see any characters appear on the screen as you type. The response will be:

    Enter same passphrase again:

Enter the passphrase again. The key pair is generated and written to a directory called .ssh in your home directory. The public key is stored in ~/.ssh/id_rsa.pub. If you forget your passphrase, it cannot be recovered. Instead, you will need to generate and upload a new SSH key pair.

Next, upload your public SSH key on the cluster. Run the following command in a terminal:

    cat ~/.ssh/id_rsa.pub

Copy and paste the output to https://sshkeys.hpc.yale.edu/  (Note: It can take a few minutes for newly uploaded keys to sync out to the clusters so your login may not work immediately.)

#### Log on to the Clusters (macOS and Linux)
Once your key has been copied to the appropriate places on the clusters, you can log in with the command:
```
ssh beng469_netid@mccleary.ycrc.yale.edu
```    
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/login-mac.png" alt="foo bar" title="train &amp; tracks" /></p>

***
### Log in to the Clusters (Windows)
We recommend using MobaXterm to connect to the clusters. You can download, extract & install MobaXterm from 
( https://mobaxterm.mobatek.net/ ). 

#### Generate Your Key Pair

* Open MobaXterm.
* From the top menu choose Tools -> MobaKeyGen (SSH key generator).
* Leave all defaults and click the "Generate" button.
* Wiggle your mouse.
* Click "Save public key" and save your public key as id_rsa.pub.
* Choose a secure passphrase and enter into the two relevant fields. Your passphrase will prevent access to your account in the event your private key is stolen.
* Click "Save private key" and save your private key as id_rsa.ppk (this one is secret, don't give it to other people).
* Copy the text of your public key and paste it into the text box to https://sshkeys.hpc.yale.edu/.
* Your key will be synced out to the clusters in a few minutes.


#### Connect with Windows

* Open MobaXterm.
* From the top menu select Sessions -> New Session.
* Click the SSH icon in the top left.
* Enter the cluster login node address (e.g. farnam.hpc.yale.edu) as the Remote Host.
* Check "Specify Username" and Enter your netID as the the username.
* Click the "Advanced SSH Settings" tab and check the "Use private key box", then click the file icon / magnifying glass to choose where you saved your private key (id_rsa.ppk).
* Click OK.

<p><img width="800" src="https://docs.ycrc.yale.edu/img/ssh-connection.png" alt="foo bar" title="train &amp; tracks" /></p>

research.computing.yale.edu
docs.ycrc.yale.edu
