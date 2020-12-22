
#### Setup X11 (MAC):
Download and install XQuartz(https://www.xquartz.org)
```
launchctl load -w /Library/LaunchAgents/org.macosforge.xquartz.startx.plist
```
quit and reopen terminal 
```
echo $DISPLAY 
```
the terminal should respond : " /private/tmp/com.apple.launchd.y8vzcm7AMF/org.macosforge.xquartz:0 "

(sudo vi /etc/ssh/ssh_config).   
(export DISPLAY=:0.0).        


#### Test X11
```
ssh -Y beng469_my393@farnam.hpc.yale.edu
srun --pty --x11 -p interactive --mem=20g bash
```
```
ls -lrt
cd /gpfs/ysm/project/beng469/beng469_my393
cd Assignment2-CNV/SCICoNE/pyscicone/
module load Mesa/17.0.2-foss-2017a
module load Python/3.6.2-foss-2017b
ipython3
```
https://github.com/cbg-ethz/SCICoNE/blob/master/notebooks/tutorial.ipynb

#### Results from cellranger-dna cnv :

/gpfs/ysm/scratch60/beng469/beng469_my393
