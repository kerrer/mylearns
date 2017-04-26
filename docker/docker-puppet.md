1.
docker run --name puppet --hostname puppet -v /job/puppet/code:/etc/puppetlabs/code/  -v /job/puppet/r10k.yaml:/etc/puppetlabs/r10k/r10k.yaml puppet/puppetserver-standalone


2. agent:
   (1) add host:
       xx.xx.xx.xx  puppet
   (2)  sign:
       client: puppet agent --test
       server: puppet cert list
               puppet cert sign client-node
               
   (3) install r10k
        gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
        gem install r10k --no-document
        
   (4) config r10k
       /etc/puppetlabs/r10k/r10k.yaml
       
       ```/etc/puppetlabs/r10k/r10k.yaml
       # The location to use for storing cached Git repos
       :cachedir: '/var/cache/r10k'

       # A list of git repositories to create
       :sources:
       # This will clone the git repository and instantiate an environment per
       # branch in /etc/puppetlabs/code/environments
       :base:
          remote: 'git@github.com:puppetmax/puppet-r10k-work.git'
          basedir: '/etc/puppetlabs/code/environments'
       ```
       
    （5）Deploy it as a new environment using the /opt/puppetlabs/puppet/bin/r10k deploy environment -p -v
    
     (6) puppet agent -t --environment test
         or
         
         ``` /etc/puppetlabs/puppet/puppet.conf
         [agent]
         environment = test
         ```
