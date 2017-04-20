inline script
===============
$mirrors_apt = <<SCRIPT
apt-get install curl -y
curl http://mirrors.163.com/.help/sources.list.precise -o /etc/apt/sources.list
apt-get update -y
SCRIPT
master.vm.provision :shell, :inline => $mirrors_apt

$mirrors_yum = <<SCRIPT
yum install curl -y
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
curl http://mirrors.163.com/.help/CentOS6-Base-163.repo -o /etc/yum.repos.d/CentOS-Base.repo
yum clean all && yum makecache
SCRIPT
two.vm.provision :shell, :inline => $mirrors_yum
