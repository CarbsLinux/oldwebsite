Carbs Linux is an in-development Linux® distribution with a suckless mindset.
The system will consist of only the necessary programs to create a Linux
distribution.

Package Manager
---------------

Carbs Linux is built upon the world's best Linux distribution 
[KISS Linux](https://getkiss.org) and uses [kiss](https://github.com/kisslinux/kiss)
as its package manager, which has proven to be extremely flexible. I aim to move Carbs
to an even more suckless path.


Sane defaults
-------------

By default, Carbs Linux comes with busybox for coreutils, runit as the system 
supervisor, and sinit as the init, though nothing holds you from changing any
of them.


Links
-----

* Reddit - [/r/carbslinux](http://reddit.com/r/carbslinux)
* Matrix - [#carbs-linux:matrix.org](https://matrix.to/#/#carbs-linux:matrix.org)


News
----

### Jan 28 2020

Web Server is now on a Carbs Linux server. It is not complete yet,
but I will be adding a little more for the intended functionality.
Downtimes can be expected.

UPDATE: ssl is now working.
UPDATE2: downloads are back again.

### Jan 22 2020

Expect downtime on Jan 24 2020 22:00 UTC as I will be migrating
this web server to my Carbs Linux server!

### Jan 15 2020

sinit has been taken to `core`, and is now officially supported

### Jan 13 2020 - 2

sinit is now released on the `extra` repository!

### Jan 13 2020

**Busybox update reqires manual intervention**

The new busybox package conflicts with the pre-update busybox-init. That's why
you should rebuild and install `busybox-init` before doing the update.

<pre><code>
# Do a kiss update first (but don't actually update it yet), or manually pull the git repository
$ kiss u  # Cancel this operation after it asks for you to confirm the update

# Install the busybox-init package
$ kiss b busybox-init && kiss i busybox-init

# Continue your update as you normally would.
$ kiss u

</code></pre>

I have moved runit and logging utilities from the busybox-init package to the busybox
package, which is the cause of these conflicts.

### Jan 10 2020

carbs-rootfs-20200110.tar.xz was [released](//dl.carbslinux.org/releases)

### Jan 09 2020

Happy new year, everyone! I am back after some long silence. I was unable to commit for a
while, but I have pulled some new updates from the KISS repository, added some of my own.
This week I will be changing/adding some things.

Important things are,

* Carbs-init was updated to 0.3.
* I will be adding an implementation of suckless.org's [sinit](//core.suckless.org/sinit) as `carbs-sinit`
* Carbs Repository was added to [repology.org](//repology.org/repository/carbs)
* A new rootfs tarball will be coming up tomorrow.

### Dec 18 2019

carbs-rootfs-20191218.tar.xz was [released](//dl.carbslinux.org/releases)

### Dec 17 2019

Installation instruction are now complete. A review would be greatly appreciated!

### Dec 15 2019

Carbs Linux Wiki is now available to be edited and updated by the users go
to the [wiki](//wiki.carbslinux.org) to obtain more information.

### Dec 12 2019

Busybox and Busybox-init has been seperated into two different packages.
This is for adding standalone runit/runit-init to the repositories.

### Dec 10 2019

First alpha release was made. See the [downloads page](//dl.carbslinux.org/releases).
