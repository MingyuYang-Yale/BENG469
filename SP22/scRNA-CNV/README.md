***

In this computational lab, we will go through examples of calculating single cell copy number profiles from 10X single cell RNA data, predicting tumor and normal cells, and inferring tumor subclones from using CopyKAT and InferCNV, try to repeat figure2a and 2c.

<p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/copykat-paper.png" alt="foo bar" title="train &amp; tracks" /></p>
<p><img width="650" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/Fig2ac.png" alt="foo bar" title="train &amp; tracks" /></p>

***
Login HPC by Open OnDemand:

1. Open Farnam OnDemand:

Go to [beng469.ycrc.yale.edu](https://beng469.ycrc.yale.edu) in your web browser (make sure that you are on Yale Network or Yale VPN). You will see the following window once you logged in.

<p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/ood-1.png" alt="foo bar" title="train &amp; tracks" /></p>

2. Click open **RStudio Server**

<p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/ood-2.png" alt="foo bar" title="train &amp; tracks" /></p>

3. Request computation resources

 Specify the resources as shown below 
 
 Additional module: **JAGS/4.3.0-foss-2020b**
 
 (you can leave other optional boxes blank), then click **Launch**
 
 <p><img width="700" src="https://github.com/MingyuYang-Yale/BENG469/blob/main/SP21/ood-3.PNG" alt="foo bar" title="train &amp; tracks" /></p>
