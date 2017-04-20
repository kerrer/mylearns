
Solaris
========================================================================
OpenSolaris was Sun's open-sourcing of most of the System V (plus much else) Unix based Solaris operating system. It's now the third major family of open-source Unix, after Linux and BSD.

When Oracle closed Solaris source in 2010, illumos and OpenIndiana forked from OpenSolaris.

Illumos is considered the canonical open-source upstream. All derived systems have ZFS filesystem, DTrace instrumentation, Zones lightweight virtualization, Crossbow networking virtualization, and added recently, KVM hypervisor functionality.

OpenIndiana is a general purpose distribution with X and desktop environment. If you intend to run illumos on the desktop, you want OpenIndiana.

NexentaOS is a storage-oriented distribution with illumos kernel and GNU/Ubuntu userland, from a vendor of storage appliances.

SmartOS, created by Joyent, is a specialised distribution designed to be a minimal hypervisor host. It's designed to be either PXE/iPXE netbooted or booted from a discrete USB-based flash and to run from compressed RAM. It's comparable to ESXi or CoreOS, and it forms the foundation of Joyent's Smart Data Center (SDC) cloud platform. SmartOS is patched or upgraded by booting to a newer release system image. NetBSD's packaging system is native and can be used to install applications. SmartOS runs Zones virtualization and KVM virtualization; live-migration of KVM guests is not supported, in large part because all storage is local -- SDC doesn't depend on shared storage, and is mostly intended to run cloud (i.e., resilient application-level high availability) instances. Because SmartOS can boot from USB and runs from RAM, it might also be a good choice for a ZFS-based NAS appliance.

OmniOS is a server-only minimal self-hosting distribution of illumos maintained by OmniTI. It gets releases twice a year like Ubuntu Linux, and it gets a patch release every week of the year. OmniOS uses IPS, the Solaris 10 and OpenSolaris packaging mechanism. It doesn't have X or a desktop, but OmniOS is probably the best illumos distribution for running apps on metal and general server functionality (ZFS, CIFS/SMB and NFS serving, webserving). 

