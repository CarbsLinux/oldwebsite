Installation Instructions
=========================

This post will guide you step-by-step in order to install
Carbs Linux. It is not complete yet.

Contents
--------

<!-- vim-markdown-toc Marked -->

* [Downloading and Getting Ready to Chroot](#downloading-and-getting-ready-to-chroot)
	* [Requirements](#requirements)
	* [Download](#download)
	* [Check the integrity of the tarball](#check-the-integrity-of-the-tarball)
	* [Check the signatures](#check-the-signatures)
	* [Download Kiss Linux Chroot Helper](#download-kiss-linux-chroot-helper)
	* [Extract the rootfs tarball](#extract-the-rootfs-tarball)
* [Chroot](#chroot)
	* [Enable repository signing (Highly Recommended)](#enable-repository-signing-(highly-recommended))
	* [Installing Important Tools](#installing-important-tools)
	* [Install the Kernel](#install-the-kernel)
	* [Bootloader](#bootloader)
	* [Install init](#install-init)
	* [Enabling other repositories](#enabling-other-repositories)
	* [More](#more)

<!-- vim-markdown-toc -->

Downloading and Getting Ready to Chroot
=======================================

Installing Carbs Linux is the same as installing most 
rootfs distributions, such as Gentoo, or Void Linux.


Requirements
------------

You simply need a Live Linux ISO. Gentoo would be the best
as programs you will require will be already there. Get the
ISO, boot it and set up your network.

**Required Programs:**

* tar
* wget
* xz

Rest of the instructions assume that you have set all of these
up, and will continue on.


Download
--------

First, we need to download the rootfs tarball. In your terminal
type

<pre><code>$ wget https://carbslinux.org/releases/carbs-rootfs-20191210.tar.xz</code></pre>


Check the integrity of the tarball
----------------------------------

While optional, it is highly recommended to check the integrity
of the tarball.
<pre>
<code>
$ wget https://carbslinux.org/releases/carbs-rootfs-20191210.tar.xz.sha256sum
$ sha256sum -c carbs-rootfs-20191210.tar.xz.sha256sum
</code>
</pre>


Check the signatures
--------------------

While optional, it is highly recommended to check the signature 
of the tarball

<pre>
<code>
$ wget https://carbslinux.org/releases/carbs-rootfs-20191210.tar.xz.sig

Import the public key of release@carbslinux.org

$ gpg --recv-keys FF484BDFEFCEF8FF

$ gpg --verify carbs-rootfs-20191210.tar.xz.sig
</code>
</pre>

Download Kiss Linux Chroot Helper
---------------------------------

<pre>
<code>
$ wget https://dl.getkiss.org/kiss-chroot

Make the script executable

$ chmod +x kiss-chroot
</code>
</pre>

Extract the rootfs tarball
--------------------------

You need to extract the tarball to your mounted partition

<pre><code>$ tar xvpf carbs-rootfs-20191210.tar.xz -C /mnt</code></pre>

Chroot
======
Chroot into Carbs Linux
<pre><code>$ ./kiss-chroot /mnt</code></pre>

Enable repository signing (Highly Recommended)
-------------------------
This step is optional, but very highly recommended 
(I cannot stress out the amount I am recommending this). 
This ensures you are receiving updates from Carbs Linux 
and not some other source.

**Install GnuPG**

It is also a great time to learn how to use your new 
package manager, KISS! You simply build and install
the package

<pre>
<code>
$ kiss build gnupg1
$ kiss install gnupg1
</code>
</pre>

**Import my key**


<pre>
<code>
Import my public key (cem@ckyln.com)

$ gpg --recv-key 4356EE08A364CE09

Create a .gnupg directory if it doesn't exist

$ mkdir -p /root/.gnupg

Trust my public key

$ echo trusted-key 0x4356ee08a364ce09 >> /root/.gnupg/gpg.conf
</code>
</pre>

**Enable signature verification**


Git has a built in signature verification feature.
You can go to the repository directory and enable it

<pre>
<code>
$ cd /var/db/kiss/repo
$ git config merge.verifySignatures true
</code>
</pre>

Installing Important Tools
--------------------------

Since Carbs gives you one of the most minimal base,
you might need to apply some add-ons to your system.

**Update packages**

It might be a good idea to update your packages before
installing new packages. This ensure compatibility.

<pre><code>kiss update</code></pre>

**Filesystems**


Currently, e2fsprogs and dosfstools are supported,
as they are the most-used filesystems.

<pre>
<code>
Support for ext2, ext3, and ex4

$ kiss build e2fsprogs
$ kiss install e2fsprogs

Support for dosfstools

$ kiss build dosfstools
$ kiss install dosfstools
</code>
</pre>

**Device management**

<pre>
<code>
$ kiss build eudev
$ kiss install eudev
</code>
</pre>

**Wireless**

**wpa_supplicant**
<pre>
<code>
$ kiss build wpa_supplicant
$ kiss install wpa_supplicant
</code>
</pre>

**eiwd (WIP)**
<pre>
<code>
$ kiss build eiwd
$ kiss install eiwd
</code>
</pre>

**dhcpcd**

<pre>
<code>
$ kiss build dhcpcd
$ kiss install dhcpcd
</code>
</pre>

**Shells**

Carbs Linux comes preinstalled with busybox ash, but other shells
can be found on the repository

<pre>
<code>
Install bash

$ kiss build bash
$ kiss install bash

Install zsh

$ kiss build zsh
$ kiss install zsh
</code>
</pre>

Install the Kernel
------------------

Next step is installing the kernel, which might sound as a challenge
you should download and extract the kernel tarball first.

<pre>
<code>
$ wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.4.2.tar.xz

Let's move the sources to /usr/src

$ mv linux-5.4.2.tar.xz /usr/src
$ tar xf linux-5.4.2.tar.xz
$ cd linux-5.4.2
</code>
</pre>

**Configure the Kernel**

You can check <https://wiki.gentoo.org/wiki/Kernel/Configuration>
to learn more about kernel configuration. Overall, [Gentoo Wiki](https://wiki.gentoo.org)
is a good place to learn about kernel configuration related to
your hardware.

**Build and install the kernel**

The rest of it is simple, build the kernel with
`make` and install it with `make install`

Bootloader
----------

The default bootloader is GRUB (GRand Unified Bootloader).

Build and install GRUB

<pre>
<code>
$ kiss b grub
$ kiss i grub

Install efibootmgr as well if your
system requires it

$ kiss b efibootmgr
$ kiss i efibootmgr

</code>
</pre>

**Setup GRUB**
<pre>
<code>
For BIOS:
$ grub-install --target=i386-pc /dev/sdX

For UEFI:
$ grub-install --target=x86_64-efi --efi-directory=esp --bootloader-id=CarbsLinux

$ grub-mkconfig -o /boot/grub/grub.cfg

</code>
</pre>

Install init
------------

Currently, default init for Carbs Linux is `sinit`, but
busybox-init is also supported. You can also change this yourself.

To install init, you have to

<pre>
<code>
$ kiss b sinit
$ kiss i sinit
</code>
</pre>

This will also fetch busybox-init as its dependency.


Enabling other repositories
---------------------------

There are other repositories out there that might be of your
interest. The Official Repositories come with community and testing
repositories that are not enabled by default. You could also want to
add the Kiss Linux community repository, or someone's personal kiss
repository.

**Obtaining repositories**

Obtaining a repository is as simple as a git clone. You can do it
with Cem's personal repository as an example, but any other repository
will be the same.

<pre>
<code>
Clone the repository to your desired location
Optionally add "--depth 1" to save precious disk space
$ git clone --depth 1 git://git.ckyln.com/kiss-repository /var/db/kiss/cem-repository
</code>
</pre>

That's it, you have obtained a new repository!

<strong>Adding a repository to your KISS_PATH</strong>

Now that we have obtained Cem's repository, we can add it to our KISS\_PATH!

We need to edit `/etc/profile.d/kiss_path.sh` for this, but you
can also change your KISS\_PATH from your shellrc.

Add the full path to the repository, in this case
`/var/db/kiss/cem-repository/cem` to the variable
and add a `:` before/after it.

It must be looking like this.

<pre>
<code>
export KISS_PATH=/var/db/kiss/repo/core:/var/db/kiss/repo/extra:/var/db/kiss/repo/xorg:/var/db/kiss/cem-repository/cem
</code>
</pre>

Update your shell variables by doing `. /etc/profile.d/kiss_path.sh` so you can
immediately access the repository packages


More
----

You should now be able to boot into you Carbs Linux installation. 
To learn more, you can visit the [wiki](//wiki.carbslinux.org)
