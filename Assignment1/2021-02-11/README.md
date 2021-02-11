### Open a terminal and login to HPC: 

(need to connect to Yale's VPN if off campus)
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
Otherwise, make directory first and then change directory to **testdata**:
```
mkdir testdata
cd testdata
```

### Create/Edit Text

Let’s run Vim to create a file called draft.txt.

Opening a New File:

* type ```vim slist.txt``` (create a file named slist.txt)
* type ```i``` ( From command mode to insert mode type)
* copy and paste the follwing texts to slist.txt:  
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
* Step 4: hit ```Esc``` key (From insert mode to command mode type)
* Step 5: type ```:wq``` (write file and exit vim)

### Look inside files: (cat, head, tail, less)

cat has nothing to do with cats. 
<p><img width="300" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment1/real-cat.png" alt="foo bar" title="train &amp; tracks" /></p>

In linux, cat is short for concatenate,and concatenate means join together, so we can cat or join multiple files together and print out the contents.

cat: print on the standard output.  
```
cat slist.txt
```

Sometimes you just want a quick look at the beginning or end of a file. This is useful for getting a sense of the contents of very large files.

head: output the first n lines of files. 
```
head -5 test.txt 
```
tail: output the last n lines of files. 
```
tail -3 test.txt  
```

### Count lines, Words and Characters 

Next let's see how many lines/words/characters in **slist.txt**, run the command:
```
wc slist.txt 
```
wc is the “word count” command, it counts the number of lines, words, and characters in files
If we run wc -l instead of just wc, the output shows only the number of lines per file:
```
wc -l slist.txt
```
You can also use -w to get only the number of words, or -c to get only the number of characters.


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
