#!/bin/zsh

echo "Hello World!"
BACKUPFOLD="/work/backup20170117"

#install --- install git geany thunderbird vlc atom
sudo yum install -y git geany thunderbird vlc atom

#intall oracle java 
sudo rpm -Uvh /path/to/binary/jdk-7u51-linux-x64.rpm 
sudo alternatives --install /usr/bin/java java /usr/java/latest/jre/bin/java 200000
sudo alternatives --install /usr/bin/javaws javaws /usr/java/latest/jre/bin/javaws 200000
sudo alternatives --install /usr/lib64/mozilla/plugins/libjavaplugin.so libjavaplugin.so.x86_64 /usr/java/latest/jre/lib/amd64/libnpjp2.so 200000
sudo alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000
sudo alternatives --install /usr/bin/jar jar /usr/java/latest/bin/jar 200000
java -version
echo 'export JAVA_HOME="/usr/java/latest"' >> ~/.zshrc

     
#jenv for java (http://www.jenv.be/)
 git clone https://github.com/gcuisinier/jenv.git ~/.jenv
 echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
 echo 'eval "$(jenv init -)"' >> ~/.zshrc
 #jenv add /System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
 #jenv global oracle64-1.6.0.39
 #jenv local oracle64-1.6.0.39
 #jenv shell oracle64-1.6.0.39
#rbenv for ruby rails puppet
 git clone https://github.com/rbenv/rbenv.git ~/.rbenv
 git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
 #echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
 ~/.rbenv/bin/rbenv init
 type rbenv

#sdk and scala maven ant gradle activator
 curl -s "https://get.sdkman.io" | bash
 source "$HOME/.sdkman/bin/sdkman-init.sh"
 sdk version
 sdk install java
 sdk install jbossforge
 sdk install leiningen
 sdk install maven
 sdk install sbt
 sdk install scala
 sdk install springboot
 sdk install groovy
 sdk install gradle
 sdk install ant
 sdk install activator
 sdk install grails
 
#gvm for golang
 bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
 gvm install go1.4
 
 gvm use go1.4 
#nvm for nodejs
  export NVM_DIR="$HOME/.nvm" && (
    git clone https://github.com/creationix/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
  ) && . "$NVM_DIR/nvm.sh"
  
  echo 'export NVM_DIR="$HOME/.nvm"'>> ~/.zshrc
  echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> ~/.zshrc
  source ~/.bashrc
  command -v nvm
  nvm install node
  nvm use node
#perlbrew for perl 5

#rakudobrew for perl 6

#/home/max/bin

#docker and pull docker images

#virtualbox 
  wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | rpm --import -
  curl http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo -O /etc/yum.repos.d/
  sudo dnf install -y virtualbox-5.1
#vagrant and pull vagrant boxes
  sudo dnf install https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1_x86_64.rpm
 

##virtualenvwrapper

##pyenv https://github.com/yyuu/pyenv, pyenv-virtualenv https://github.com/yyuu/pyenv-virtualenv

### ssh config and ssh for github ( ~/.ssh)
cp -R  ~/.ssh  $BACKUPFOLD/ssh

### stormpath maxkerrer@live.com 1tw (~/.stormpath)
### ~/.stormpath/apiKey.properties for https://api.stormpath.com  salty-squall:mk@live:1t9
cp -R  ~/.stormpath  $BACKUPFOLD/stormpath

###/etc/host , /etc/fstab, ~/.zshrc  /etc/pip.conf 
mkdir  $BACKUPFOLD/config 
cp /etc/hosts /etc/fstab ~/.zshrc /etc/pip.conf $BACKUPFOLD/config

### backup .vagrant.d/   /var/lib/docker

### ~/.m2/setting 
cp -R ~/.m2/settings.xml $BACKUPFOLD/maven_m2_setting.xml

####clitools for https://github.com/webdevops


###travis for travis-ci.com


##mulesoft maxkerrer 1tWS


#cas /etc/cas
sudo cp -R /etc/cas $BACKUPFOLD/etc_cas

#bin /home/max/bin
 cp -R ~/bin $BACKUPFOLD/bin


#OpenShift  maxkerrer@live.com  console.preview.openshift.com
