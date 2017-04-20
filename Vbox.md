vboxmanage clonehd original.vmdk new.vdi --format VDI

sdelete –z c:
sdelete64 –z c:

sudo dd if=/dev/zero of=/bigemptyfile bs=4096k
sudo rm -rf /bigemptyfile

vboxmanage modifyhd /path/to/thedisk.vdi --compact
VboxManage clonehd name-of-original-vm.vdi name-of-clone-vm.vdi
