### Open a terminal and login to HPC: 

(need to connect to Yale's VPN if off campus)
```
ssh beng469_my393@farnam.hpc.yale.edu (change my393 to your own NETID)
```
---
change directory to **project**.
```
cd project
```
list what’s in your **project** directory by running ```ls```
```
ls 
```
if you already have **testdata** directory, just run :
```
cd testdata 
```
Otherwise, make directory first and then change directory to **testdata**:
```
mkdir testdata
cd testdata
```
---
### Create/Edit Text

Run Vim to create a file called student-list.txt.

Opening a New File:

* type ```vim student-list.txt``` (create a file named slist.txt)
* type ```i``` ( From command mode to insert mode type)
* copy and paste the follwing texts to student-list.txt:  
```
student-A    sb2723
student-B    mb2823
student-C    bmb62
student-D    snd35
student-E    nee6
student-F    al2342
student-G    kl646
student-H    am2975
student-I    dfm42
student-G    svp26
student-K    wt263
student-L    jy568
```
* hit ```Esc``` key (From insert mode to command mode type)
* type ```:wq``` (write file and exit vim)
---
### Look inside files: 

#### ```cat```

cat has nothing to do with cats. 
<p><img width="300" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment1/real-cat.png" alt="foo bar" title="train &amp; tracks" /></p>

The cat (short for “concatenate“), which means join together, we can use ```cat``` to join multiple files together and print out their contents. we can also use cat print out only a file's content.

Let's use ```cat``` to display contents of student-list.txt :  
```
cat student-list.txt
```
when you add ```-n``` flag can show us the line number
```
cat -n student-list.txt
```
---
#### ```head/tail```

head: output the first n lines of a file. 

```
head -n 5 student-list.txt 
```
tail: output the last n lines of a file. 
```
tail -n 3 student-list.txt  
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
* Use ```space bar``` to go to the next page, ```b``` move up one page.
* Use ```arrow key```:arrow_down: :arrow_up: to go down or go up just one line at a time. 
* Use ```q``` key to quit out less.
```
less cancer-gene.txt
```
---
### Count lines, Words and Characters 

Next let's see how many lines/words/characters in a file, run the command:
```
wc student-list.txt
```

```
wc cancer-gene.txt
```

wc is the “word count” command, it counts the number of lines, words, and characters in files.

If we run wc -l instead of just wc, the output shows only the number of lines per file:
```
wc -l student-list.txt
```
You can also use -w to get only the number of words, or -c to get only the number of characters.

---

## Permissions

<p><img width="750" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment1/permissions-1.png" alt="foo bar" title="train &amp; tracks" /></p>

A file owner can change the permisson with ```chmod``` command, short for "change mode".
```
ls -lrt
```

```
chmod u=rwx,g=rx,o=r student-list.txt
```
```
chmod ugo=r student-list.txt
```
```
chmod ugo+x student-list.txt 
```
or
```
chmod a+x student-list.txt
```

Setting the permission this way called alpha-beta notation. We can also change permissions in numeric code in Linux

* 1 = Execute
* 2 = Write
* 4 = Read

<p><img width="750" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment1/permissions-3.png" alt="foo bar" title="train &amp; tracks" /></p>

```
chmod 754 student-list.txt
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

For transfer data, you can either use scp or rsync
* command + source+ destination

the source or the destination can be remote or local

open a new terminal window on your local computer: (command + T)

* If you have some data that on the cluster, and want to download it to your own computer
```
scp beng469_my393@farnam.hpc.yale.edu:/home/beng469_my393/project/testdata/student-list.txt ./
```
* If you want to upload a file from your own compter to cluster. 
```
mv student-list.txt student-list-v2.txt 
```
```
scp ./student-list-v2.txt beng469_my393@farnam.hpc.yale.edu:/home/beng469_my393/project/testdata
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

---
## Graphical Environments for Clusters
To use a graphical interface on the clusters, your connection needs to be set up for X11 forwarding, which will transmit the graphical window from the cluster back to your local machine. .

#### Setup X11 (On macOS)
* Download and install XQuartz(https://www.xquartz.org)
* Log out and log back in to your Mac to reset some variables.
**(quit and reopen terminal window)**
```
launchctl load -w /Library/LaunchAgents/org.macosforge.xquartz.startx.plist
```

```
echo $DISPLAY
```
the terminal should respond : " /private/tmp/com.apple.launchd.y8vzcm7AMF/org.macosforge.xquartz:0 "

#### Test X11
When using ssh to log in to the clusters, use the ```-Y``` option to enable X11 forwarding. Example: ssh -Y
```
ssh -Y beng469_my393@farnam.hpc.yale.edu
```
```
srun --pty --x11 -p interactive --mem=20g bash
```
#### Setup X11 (On Ubuntu)
http://laptops.eng.uci.edu/software-installation/using-linux/configure-ubuntu-for-x11-forwarding
(???)
