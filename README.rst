Recompiling Shibboleth SP RPMs with FastCGI support
===================================================

The Shibboleth SP software features FastCGI authorizer and responder
applications for use with your favourite non-Apache and non-IIS web server.
Unfortunately, the default distributions don’t come with it built by default.

This is powered by `Vagrant <http://vagrantup.com>`_ to quickly spin up a
CentOS VM, recompile the RPMs, and destroy it afterwards.  If you're not
so inclined to use Vagrant (why?), then you can use the ``rebuild.sh`` script
directly on your own RHEL or CentOS VM.

Go!
---

This will always build the **latest version** of the Shibboleth SP. 

#. Ensure Vagrant is installed. This was tested with Vagrant 1.2.7 and
   VirtualBox 4.2.16.

#. Run this::

       git clone https://github.com/jcu-eresearch/shibboleth-fastcgi.git
       cd shibboleth-fastcgi
       vagrant up; vagrant destroy -f
       ls -lah x86_64

#. Look at the result of the final command and marvel at the RPMs.

Note
----

If you’re just looking to download something that works and don’t want to
rebuild things yourself, we have EL 6, x86_64 packages available in a Yum
repo at https://www.hpc.jcu.edu.au/rpm/. You’ll need to trust our RPM
building skills, though.
