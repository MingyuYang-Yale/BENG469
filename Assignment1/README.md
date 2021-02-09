
# Introduction to HPC

## What is HPC?
High Performance Computing (HPC) cluster is a collection of networked computers and data storage.

<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment1/clusters.png" alt="foo bar" title="train &amp; tracks" /></p>


## Why Use a HPC? 
*  Don’t want to tie up your own machine 
*  Have many long running jobs to run
*  Want to run in parallel to get results quicker 
*  Need more disk space 
*  Need more memory
*  Want to use software installed on the cluster
*  Want to access data stored on the cluster 
*  Want to use GPUs 


## Yale Clusters

|Cluster|CPUs|Login Address|Purpose|
|------|-------|------|-------|
|Grace|20,000|grace.hpc.yale.edu|general|
|Farnam|5,100|farnam.hpc.yale.edu|medical/life science|
|Ruddle|3,100|ruddle.hpc.yale.edu|Yale Center for Genome Analysis|
|Milgram|1,600|milgram.hpc.yale.edu|HIPAA|


## Setting up an account

You should have received a email from Yale Center for Research Computing:
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment1/mail-from-ycrc.png" alt="foo bar" title="train &amp; tracks" /></p>


## Log on to the Clusters

* Yale's clusters can only be accessed on the Yale network. For **off campus** access, you will need to first connect to Yale's **VPN**(https://software.yale.edu/software/cisco-vpn-anyconnect). 

* Use SSH with SSH key pairs to log in to the clusters. 
    
    SSH (Secure Shell) keys are a set of two pieces of information that you use to identify yourself and encrypt communication to and from a server. 
    Usually this  takes the form of two files: a public key (often saved as id_rsa.pub) and a private key (id_rsa or id_rsa.ppk). 
    To use an analogy, your public key is like a lock and your private key is what unlocks it. 
    It is ok for others to see the lock (public key), but anyone who knows the private key can open your lock (and impersonate you)



* (More information: https://docs.ycrc.yale.edu/clusters-at-yale/access/) 


### Log on to the Clusters (macOS and Linux)

#### Generate Your Key Pair 

To generate a new key pair, first open a terminal window. (search Terminal). Generate your public and private ssh keys. Type the following into the terminal window:
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

#### Connect on macOS and Linux

Once your key has been copied to the appropriate places on the clusters, you can log in with the command:
```
    ssh beng469_my393@farnam.hpc.yale.edu (change my393 to your NETID)
```    
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment1/login-mac.png" alt="foo bar" title="train &amp; tracks" /></p>

### Log on to the Clusters (Windows)
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

## Navigating Files and Directories
#### Questions
* How can I move around on HPC?
* How can I see what files and directories I have?
* How can I specify the location of a file or directory on HPC?

Who Are You? Type the command:
```
whoami
```
then press the ENTER key (sometimes marked Return) to send the command to the shell. The command’s output is the ID of the current user:

<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment1/whoami.png" alt="foo bar" title="train &amp; tracks" /></p>

Where are you?
Next, let’s find out where we are by running a command called:
```
pwd
```
(which stands for “print working directory”). 
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment1/pwd.png" alt="foo bar" title="train &amp; tracks" /></p>

### List Your Files and Directories

Now let’s learn the command that will let us see the contents of our own file system. We can see what’s in our home directory by running ls, which stands for “listing”:

<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment1/ls.png" alt="foo bar" title="train &amp; tracks" /></p>

ls prints the names of the files and directories in the current directory in alphabetical order, arranged neatly into columns. 

ls has lots of options. To find out what they are, we can type:

```
ls --help
```


(Many bash commands, and programs that people have written that can be run from within bash, support a --help flag to display more information on how to use the commands or programs.)

### Move Around
The command to change locations is cd followed by a directory name to change our working directory. cd stands for “change directory”.
```
cd /gpfs/ysm/project/beng469/beng469_my393
```

These commands will move us from our home directory into the SCB-course-data directory. cd doesn’t print anything, but if we run pwd(print work directory) after it

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment1/cd.png" alt="foo bar" title="train &amp; tracks" /></p>

we can see that we are now in ```/gpfs/ysm/project/beng469/beng469_my393```

(brings you up)
```
cd .. 
```
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment1/cd-up.png" alt="foo bar" title="train &amp; tracks" /></p>

(bring you to the previous directory you was in 
```
cd – 
```
This is a very efficient way of moving back and forth between directories

(tilde or squiggle line, bring you to the user’s home directory)
```
cd ~ 
```
```cd ~``` is equivalent to ```cd /home/beng469_my393```


