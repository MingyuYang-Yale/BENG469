
# Introduction to HPC

## Log on to the Clusters

Yale's clusters can only be accessed on the Yale network. Therefore, in order to access a cluster from off campus, you will need to first connect to Yale's VPN (https://software.yale.edu/software/cisco-vpn-anyconnect). 

You must be on the campus network to access the clusters. For off-campus access you need to use the Yale VPN.

Use SSH with SSH key pairs to log in to the clusters. 

SSH (Secure Shell) keys are a set of two pieces of information that you use to identify yourself and encrypt communication to and from a server. Usually this takes the form of two files: a public key (often saved as id_rsa.pub) and a private key (id_rsa or id_rsa.ppk). To use an analogy, your public key is like a lock and your private key is what unlocks it. It is ok for others to see the lock (public key), but anyone who knows the private key can open your lock (and impersonate you)


(More information: https://docs.ycrc.yale.edu/clusters-at-yale/access/) 

Generate Your Key Pair

To generate a new key pair, first open a terminal/xterm session. If you are on macOS, open Applications -> Utilities -> Terminal. Generate your public and private ssh keys. Type the following into the terminal window:
   ```
   ssh-keygen
```
Your terminal should respond:

    Generating public/private rsa key pair. Enter file in which to save the key (/home/yourusername/.ssh/id_rsa):

Press Enter to accept the default value. Your terminal should respond:

    Enter passphrase (empty for no passphrase):

Choose a secure passphrase. Your passphrase will prevent access to your account in the event your private key is stolen. You will not see any characters appear on the screen as you type. The response will be:

    Enter same passphrase again:

Enter the passphrase again. The key pair is generated and written to a directory called .ssh in your home directory. The public key is stored in ~/.ssh/id_rsa.pub. If you forget your passphrase, it cannot be recovered. Instead, you will need to generate and upload a new SSH key pair.

Next, upload your public SSH key on the cluster. Run the following command in a terminal:

    cat ~/.ssh/id_rsa.pub

Copy and paste the output to https://sshkeys.hpc.yale.edu/  (Note: It can take a few minutes for newly uploaded keys to sync out to the clusters so your login may not work immediately.)

Connect on macOS and Linux

Once your key has been copied to the appropriate places on the clusters, you can log in with the command:
    ssh beng469_my393@farnam.hpc.yale.edu (change my393 to your NETID)
