Turn on the credential helper so that Git will save your password in memory for some time. By default, Git will cache your password for 15 minutes.

In Terminal, enter the following:

git config --global credential.helper cache
# Set git to use the credential memory cache
To change the default password cache timeout, enter the following:

git config --global credential.helper 'cache --timeout=3600'
# Set the cache to timeout after 1 hour (setting is in seconds)


git config --global core.editor "nano"

git config --global core.mergeoptions --no-edit
git pull --no-edit
git reset --hard @{1}

======
~/.gitconfig 

[core]
    mergeoptions = --no-edit


Github
========================================================================
Generating a new SSH key

ssh-keygen -t rsa -b 4096 -C "maxkerrer@live.com"

Before adding a new SSH key to the ssh-agent, you should have checked for existing SSH keys and generated a new SSH key.

Ensure ssh-agent is enabled:

# start the ssh-agent in the background
eval "$(ssh-agent -s)"
Agent pid 59566
Add your SSH key to the ssh-agent. If you used an existing SSH key rather than generating a new SSH key, you'll need to replace id_rsa in the command with the name of your existing private key file.

$ ssh-add ~/.ssh/id_rsa
Add the SSH key to your GitHub account.

sudo apt-get install xclip
# Downloads and installs xclip. If you don't have `apt-get`, you might need to use another installer (like `yum`)

$ xclip -sel clip < ~/.ssh/id_rsa.pub
# Copies the contents of the id_rsa.pub file to your clipboard

Adding a new SSH key to your GitHub account
Settings->SSH and GPG keys-> New SSH key
ssh -T git@github.com

submodule
========================================================================
add:git submodule add https://github.com/Cascading/vagrant-cascading-hadoop-cluster.git hadoop/cascading-hadoop
  
remove:
   git rm the_submodule
   rm -rf .git/modules/the_submodule




=======
With Version 1.9 of Git and later you can even download the submodules simultaneously

git clone --recursive -j8 git://github.com/foo/bar.git
cd bar
With version 1.6.5 of Git and later, you can use:

git clone --recursive git://github.com/foo/bar.git
cd bar
For already cloned repos, or older Git versions, just use:

git clone git://github.com/foo/bar.git
cd bar
git submodule update --init --recursive
git submodule init 
git submodule update

remove:
git submodule deinit asubmodule    
git rm the_submodule
git rm --cached asubmodule
rm -rf .git/modules/the_submodule 


change remote url
========================================================================
git remote -v
git remote set-url origin https://github.com/USERNAME/OTHERREPOSITORY.git
git remote -v
=======

github multi key for ssh config
========================================================================
With multiple Bitbucket accounts (and I assume GitHub too) you need multiple SSH keys. To generate a second key with a different name:

1. ssh-keygen -t rsa -b 4096 -f ~/.ssh/puppetmax -C "maxkerrer@gmail.com"
   To use multiple keys create a file at ~/.ssh/config  with contents similar to:

#maxkerrer@live.com
#git remote add origin git@github-kerrer:kerrer/maxshell.git
Host github-kerrer
  User git
  Hostname github.com
  PreferredAuthentications publickey
  IdentityFile ~/.ssh/id_rsa

#maxkerrer@gmail.com
git remote add origin git@github-puppetmax:kerrer/maxshell.git
Host github-puppetmax
  User git
  Hostname github.com
  PreferredAuthentications publickey
  IdentitiesOnly yes
  IdentityFile ~/.ssh/puppetmax

#kerrer@126.com
git remote add origin git@github-workdemos:kerrer/maxshell.git
Host github-workdemos
  User git
  Hostname github.com
  PreferredAuthentications publickey
  IdentitiesOnly yes
  IdentityFile ~/.ssh/workdemos
  
2. Clear currently stored identities:
   $ ssh-add -D
3. Add new keys:
   $ ssh-add id_rsa_personal
   $ ssh-add id_rsa_work
4. Test to make sure new keys are stored:
   $ ssh-add -l


tree
=========================
1).
git log --graph --oneline --all
export LESS="-R"
git log --graph --pretty=oneline --abbrev-commit | tig
git log --graph --pretty=oneline --abbrev-commit
git log --oneline --decorate --all --graph

2).
.gitconfig and call it easily:
[alias]
    tree = log --graph --decorate --pretty=oneline --abbrev-commit
And when you call it next time, you'll use:
git tree

3).
tig



prevent if subdir have .git
========================================================================
copy  to .git/hooks/


branch:
===================

show: git branch
add: git branch production  && git push origin production

delete: git branche -d master && git push origin :master
