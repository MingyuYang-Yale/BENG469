Open a terminal and login to HPC:(need to connect to Yale's VPN if off campus)
```
ssh beng469_my393@farnam.hpc.yale.edu (change my393 to your own NETID)
```
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
Otherwise, run:
```
mkdir testdata && cd testdata
```

### Create/Edit Text

Let’s run a text editor called Vim to create a file called draft.txt.

#### Opening a New File

* Step 1: type ```vim draft.txt``` (create a file named filename)
* Step 2: type ```i``` ( switch to insert mode)
* Step 3: enter text ```Hello World```
* Step 4: hit ```Esc``` key (switch back to command mode)
* Step 5: type ```:wq``` (write file and exit vim)

#### Some useful commands for VIM
* From command mode to insert mode type ```i```
* From insert mode to command mode type ```Esc``` (escape key)
* ```:wq``` Write file to disk and quit the editor
* ```dd``` Delete line
* ```u```  Undo last change


wc: word count. 
```
wc -l thesis.txt 
```
cat: concatenate files and print on the standard output.  
```
cat thesis.txt
```
head: output the first part of files. 
```
head -5 test.txt 
```
tail: output the last part of files. 
```
tail -10 test.txt  
```

```
cp xxx ./
```
less: displays the contents of a file, one page at a time. 

```
less xxx
```

```
cp test.txt test2.txt
```

```
mv test2.txt work.txt 
```

```
ls
```

```
rm test.txt 
```

```
cd ..
```

```
cp -r testdata testdata2
```

```
mv testdata2 Assignment1
```

```
ls 
```

```
rm -r -i testdata 
```

### Permission

* chmod change file access permissions (eg. chmod 777/755)

#### .bashrc

history

Storage Types
|Name|Location|Good for|Quota|
|------|-------|------|-------|
|Home|~/|Scripts|125GiB/Person|
|Project|~/project|Larger datasets (keep a copy elsewhere)|4TiB/Group|
|Scratch60|~/scratch60|Temporary, shared files, purged every 60 days|20TiB/Group|
|PI|/gpfs/fs/pi/group|Additional group-owned storage|Varies|

Cluster Software

scp 
wget
git clone

tar 
