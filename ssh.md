~/.ssh/config | /etc/ssh/ssh_config

1.force ssh client to use only password auth?
ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no example.com

2.
Host *(a space separated list of made up aliases you want to use for the host)
    User git
    Hostname (ip or hostname of git server)
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa_(the key you want for this repo)

Host *
    User                   max
    StrictHostKeyChecking  no
    IdentityFile          ~/.ssh/id_dsa
    PubkeyAcceptedKeyTypes ssh-dss
================================================
ssh localhost
ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys

======================================================= 
ssh -vvv localhostHost 

=======================================================
ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa


========================================================================
=======================================================
ssh-keygen -t rsa -b 2048
ssh-copy-id id@server
