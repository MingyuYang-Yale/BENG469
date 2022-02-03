# Basic of HPC and coding tutorial (02/01/2022)

## What is HPC?
High Performance Computing (HPC) cluster is a collection of networked computers and data storage.

<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/clusters.png" alt="foo bar" title="train &amp; tracks" /></p>

***
## Why Use a HPC? 
*  Don’t want to tie up your own machine 
*  Have many long running jobs to run
*  Want to run in parallel to get results quicker 
*  Need more disk space 
*  Need more memory
*  Want to use software installed on the cluster
*  Want to access data stored on the cluster 
*  Want to use GPUs 

***

## Yale Clusters

|Cluster|CPUs|Nodes|Login Address|Purpose|
|------|-------|------|-------|------|
|Grace|29,000|900|grace.hpc.yale.edu|general|
|Farnam|6,700|275|farnam.hpc.yale.edu|medical/life science|
|Ruddle|3,200|200|ruddle.hpc.yale.edu|Yale Center for Genome Analysis|
|Milgram|2,400|80|milgram.hpc.yale.edu|HIPAA and other sensitive data (HIPPA: Health Insurance Portability and Accountability Act)|

***
## Setting up an account

You should have received a email from Yale Center for Research Computing:
<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/mail-from-ycrc.png" alt="foo bar" title="train &amp; tracks" /></p>

***
## Log in to the Clusters

* Yale's clusters can only be accessed on the Yale network. For **off campus** access, you will need to first connect to Yale's **VPN**(https://software.yale.edu/software/cisco-vpn-anyconnect). 

* Use SSH with SSH key pairs to log in to the clusters. 
    
    SSH (Secure Shell) keys are a set of two pieces of information that you use to identify yourself and encrypt communication to and from a server. 
    Usually this  takes the form of two files: a public key (often saved as id_rsa.pub) and a private key (id_rsa or id_rsa.ppk). 
    To use an analogy, your public key is like a lock and your private key is what unlocks it. 
    It is ok for others to see the lock (public key), but anyone who knows the private key can open your lock (and impersonate you)



* (More information: https://docs.ycrc.yale.edu/clusters-at-yale/access/) 

***

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


***

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

<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/whoami.png" alt="foo bar" title="train &amp; tracks" /></p>

Where are you?
Next, let’s find out where we are by running a command called:
```
pwd
```
(which stands for “print working directory”). 
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/pwd.png" alt="foo bar" title="train &amp; tracks" /></p>

***
### List Your Files and Directories

Now let’s learn the command that will let us see the contents of our own file system. We can see what’s in our home directory by running ls, which stands for “listing”:

<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/ls.png" alt="foo bar" title="train &amp; tracks" /></p>

ls prints the names of the files and directories in the current directory in alphabetical order, arranged neatly into columns. 

ls has lots of options. To find out what they are, we can type:

```
ls --help
```


(Many bash commands, and programs that people have written that can be run from within bash, support a --help flag to display more information on how to use the commands or programs.)
***
### Move Around
The command to change locations is cd followed by a directory name to change our working directory. cd stands for “change directory”.
```
cd /gpfs/ysm/project/beng469/beng469_my393
```

These commands will move us from our home directory into the SCB-course-data directory. cd doesn’t print anything, but if we run pwd(print work directory) after it

<p><img width="800" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/cd.png" alt="foo bar" title="train &amp; tracks" /></p>

we can see that we are now in ```/gpfs/ysm/project/beng469/beng469_my393```

(brings you up)
```
cd .. 
```
<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/cd-up.png" alt="foo bar" title="train &amp; tracks" /></p>

(bring you to the previous directory you was in) 
```
cd – 
```
This is a very efficient way of moving back and forth between directories

(tilde or squiggle line, bring you to the user’s home directory)
```
cd ~ 
```
```cd ~``` is equivalent to ```cd /home/beng469_my393```

## Working Files and Directories
#### Questions
* How can I create, copy, and delete files and directories?
* How can I edit files?

---
### Make a Directory
We now know how to explore files and directories, but how do we create them in the first place? 

First go to our project directory using the command : 
```
cd project
```
Then create a new directory called testdata 
```
mkdir testdata
```
(mkdir means “make directory”)

<p><img width="500" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/mkdir.png" alt="foo bar" title="train &amp; tracks" /></p>

---
### Create/Edit Text

Run ```vim``` to create a file called draft.txt :

(```vim``` is a text editor built to make creating and changing any kind of text)


```
vim draft.txt
``` 
* type ```i``` ( From command mode to insert mode type)
* copy and paste the follwing texts to draft.txt:  
```
student-A    aeb98
student-B    hc738
student-C    gmc62
student-D    eid8
student-E    ahe3
student-F    bdk35
student-G    tm827
student-H    sen37
student-I    aeq4
student-G    ser66
student-K    vsv6
student-L    av625
student-M    lw729
student-N    jrw74
student-O    qw239
```
* hit ```esc``` key (From insert mode to command mode type)
* type ```:wq``` (write file and exit vim)
---

# Basic of HPC and coding tutorial (02/03/2022)

### login to HPC

(need to connect to Yale's VPN if off campus)

For Mac users:
```
ssh beng469_my393@farnam.hpc.yale.edu (change my393 to your own NETID)
```
For windows user, please login to the cluster via MobaXterm.

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

### Copy a File
The cp command works very much like mv, except it copies a file instead of moving it. 
```
cp students-list.txt students-list-sp22.txt
```

### Delete a File

```
rm students-list.txt
```
This command removes files (```rm``` is short for “remove”). 

Deleting Is Forever! The Linux shell doesn’t have a trash bin that we can recover deleted files. Instead, when we delete files, they are unhooked from the file system so that their storage space on disk can be recycled. 

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


***


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

## Permissions

<p><img width="750" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/permissions-1.png" alt="foo bar" title="train &amp; tracks" /></p>

A file owner can change the permisson with ```chmod``` command, short for "change mode".
```
ls -lrt
```

```
chmod u=rwx,g=rx,o=r students-list.txt
```
```
chmod ugo=r students-list.txt
```
```
chmod ugo+x students-list.txt 
```
or
```
chmod u+w,go-rx students-list.txt
```

Setting the permission this way called alpha-beta notation. We can also change permissions in numeric code in Linux

* 1 = Execute
* 2 = Write
* 4 = Read

<p><img width="750" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Assignment1/permissions-3.png" alt="foo bar" title="train &amp; tracks" /></p>

```
chmod 754 students-list.txt
```
---

## Storage Types
|Name|Location|Good for|Quota|
|------|-------|------|-------|
|Home|~/|Scripts|125GiB/Person|
|Project|~/project|Larger datasets (keep a copy elsewhere)|4TiB/Group|
|Scratch60|~/scratch60|Temporary, shared files, purged every 60 days|20TiB/Group|

---
## Quotas
* To check our course’s cluster quotas, run:
```
getquota
```
* All storage areas have quotas, both size and file count
* If you hit your limit, jobs fail
* Home quota is per user, small
* Project, scratch60 has a group quota shared with your group, large
---

## Transfer Data

For transfer data, you can either use ```scp``` or ```rsync```
* command + source+ destination

the source or the destination can be remote or local

open a new terminal window on your local computer: (command + T)

* If you have some data that on the cluster, and want to download it to your own computer
```
scp beng469_my393@farnam.hpc.yale.edu:/home/beng469_my393/project/testdata/students-list.txt ./
```
* If you want to upload a file from your own compter to cluster. 
```
mv students-list.txt students-list-v2.txt 
```
```
scp ./students-list-v2.txt beng469_my393@farnam.hpc.yale.edu:/home/beng469_my393/project/testdata
```

if you want tranfer directory, just add ```-r``` for recursive grasp not just a file, but all contents of the directory.

for download: 
```
scp -r beng469_my393@farnam.hpc.yale.edu:/home/beng469_my393/project/testdata/ ./
```
for upload:
```
mv testdata testdata-v2
```
```
scp -r testdata-v2 beng469_my393@farnam.hpc.yale.edu:/home/beng469_my393/project/
```
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
---
### Partitions
#### General Purpose: 
* interactive for interactive jobs (srun)
* general default on Farnam/Ruddle
 
#### Special Use Cases:
* gpu nodes with gpus
* bigmem nodes with large RAM (for jobs requiring >= 100G)
* pi_name reserved for specific groups

#### Scavenge: (very useful for short or well-checkpointed jobs)
* scavenge uses idle nodes from other partitions (can be preempted)

---
### Interactive vs. Batch

#### Interactive jobs:
* For development, debugging, or interactive environments like R and Matlab
* One or a few jobs at a time
#### Batch jobs:
* Non-interactive
* Can run many jobs simultaneously
* Usually your best choice for production computing

---
### Interactive Allocation
```
srun --pty -p interactive --mem=8g bash
```
```
squeue
```
```
squeue -u beng469_my393
```
Use Exit to close the interactive node.
```
exit
```
---
### Software

#### Modules
common software we have installed is available using module.  
Load a module to use the software:
```
module load Python   (loads default version)
```
To see available software, run module avail
```
module avail
```
```
module avail Python
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

