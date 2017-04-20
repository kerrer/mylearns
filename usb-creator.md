liveusb-creator - https://fedorahosted.org/liveusb-creator/

https://unetbootin.github.io/

sudo dd if=/path-to-the-iso/Fedora-16-x86_64-Live-Desktop.iso of=/dev/sdb bs=8M

livecd-tools
========================================================================
yum install livecd-tools
  su -c "livecd-iso-to-disk Fedora-Live-Desktop-x86_64-20-1.iso /dev/sdX"
  su -c "livecd-iso-to-disk --reset-mbr Fedora-Live-Desktop-x86_64-20-1.iso /dev/sdX"
  su -c "livecd-iso-to-disk --format --reset-mbr Fedora-Live-Desktop-x86_64-20-1.iso /dev/sdX"
  
dd
========================================================================
1.Identify the name of the USB drive partition. If using this method on Windows, with the port linked above, the dd --list command should provide you with the correct name.
2.Unmount all mounted partition from that device. This is very important, otherwise the written image might get corrupted. You can see all mounted partitions with
lsblk /dev/sdb
and unmount them with

umount /run/media/user/mountpoint
3.Write the ISO file to the device:
sudo dd if=/path/to/image.iso of=/dev/sdX bs=8M status=progress oflag=direct
where sdX is the name of your device. Wait until the command completes.
If you receive dd: invalid status flag: ‘progress’ error, your dd version doesn't support status=progress option and you'll need to remove it (and you won't see writing progress).

live usb
========================================================================
 - https://tails.boum.org/index.en.html
 - http://wiki.sugarlabs.org/go/Sugar_on_a_Stick
 - 

openindiana
======================================================================
http://wiki.openindiana.org/oi/Installing+OpenIndiana
 cat 1G.header OI-hipster-text-20160421.usb | dd bs=1024k of=/dev/sdd
