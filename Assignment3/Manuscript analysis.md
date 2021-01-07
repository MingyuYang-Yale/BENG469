
***
Nature paper:https://www.nature.com/articles/s41586-020-2864-x

<p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Nature-paper.png" alt="foo bar" title="train &amp; tracks" /></p>

***
They used a commercial platform from **Mission Bio** called **Tapestri**. The methodology uses single cell droplet encapsulation and barcoded beads to perform amplicon next generation sequencing. 
<p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/Assignment3/Pipeline.png" alt="foo bar" title="train &amp; tracks" /></p>

***
### Login HPC:
(need to connect to Yale's **VPN** if off campus)

```
ssh -Y beng469_my393@farnam.hpc.yale.edu
srun --pty --x11 -p interactive --mem=50g bash
cd /gpfs/ysm/project/beng469/beng469_my393
cd Assignment3-SNV
```
```
mkdir Assignment3-SNV && cd Assignment3-SNV
```
