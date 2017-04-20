============================================
virtualbox additions:
Mount the VBoxGuestAdditions.iso file as your Solaris guest's virtual CD-ROM drive, exactly the same way as described for a Windows guest in Section 4.2.1.1, “Installation”.

If in case the CD-ROM drive on the guest doesn't get mounted (observed on some versions of Solaris 10), execute as root:

    svcadm restart volfs
Change to the directory where your CD-ROM drive is mounted and execute as root:

pkgadd -G -d ./VBoxSolarisAdditions.pkg
Choose "1" and confirm installation of the Guest Additions package. After the installation is complete, re-login to X server on your guest to activate the X11 Guest Additions.

4.2.3.2. Uninstalling the Solaris Guest Additions

The Solaris Guest Additions can be safely removed by removing the package from the guest. Open a root terminal session and execute:

pkgrm SUNWvboxguest
=============================
password:
/etc/default/passwd 

===========================
openindina:
----package:
Option 1: Install software from OpenIndiana repositories via IPS
Set a remote repository:
:; pkg set-publisher -O http://pkg.openindiana.org/dev openindiana.org

Search for a package (in remote repositories):
:; pkg search -pr git

Install a package:
:; pkg install git

Option 2: Install software from SmartOS repositories via pkgin
If you want to install software via pkgin (installs every package to /opt), you need to (console as root):
add /opt/local/{s,}bin where all software is installed to your PATH (in your shell, maybe save to your .profile):
PATH=/opt/local/sbin:/opt/local/bin:$PATH 
export PATH
install the bootstrap-loader: (use the loader according to your repository, see http://pkgsrc.joyent.com/packages/SmartOS/bootstrap/)
:; curl http://pkgsrc.joyent.com/packages/SmartOS/bootstrap/bootstrap-2014Q2-x86_64.tar.gz | gtar -zxpf - -C /
update the repository database:
:; pkgin -y update
install the needed package, for example – Apache 2.4.6:
:; pkgin -y install apache-2.4.6
or, just for newest 2.4:

:; pkgin -y install apache-2.4

----upgrade
pfexec pkg publisher 
# pfexec pkg unset-publisher opensolaris.org
# pfexec pkg set-publisher -O http://pkg.openindiana.org/dev/ openindiana.org
You may want to update your packages fully in case of a bad pkg cache:

# pfexec pkg refresh --full
You can now identify what will be upgraded by issuing the command:

# pfexec pkg image-update -nv
The -n flag specifies to perform no action (i.e. perform a trial run), and the -v flag is the verbose option, to provide additional output.

If you are satisfied with the actions to be taken, you can perform the upgrade by typing:

# pfexec pkg image-update -v
