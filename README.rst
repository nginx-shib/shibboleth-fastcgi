Recompiling Shibboleth SP RPMs with FastCGI support
===================================================

.. image:: https://travis-ci.org/jcu-eresearch/shibboleth-fastcgi.svg?branch=master
   :target: https://travis-ci.org/jcu-eresearch/shibboleth-fastcgi

The Shibboleth SP software features FastCGI authorizer and responder
applications for use with your favourite non-Apache and non-IIS web server
(perhaps nginx with `nginx-http-shibboleth
<https://github.com/nginx-shib/nginx-http-shibboleth>`_?).

Why?
----

Unfortunately, the default distributions of the Shibboleth SP don't come with
this support built by default.  Asking nicely for this to be added hasn't
happened because of the `fcgi-devel` package living in the EPEL repositories
and not the core.

If you can help twist someone's arm, that'd help eliminate the need for this
repository and us manually rebuilding Shibboleth each time a new release comes
out.

Building
--------

This will always build the **latest version** of the Shibboleth SP and does so
by spinning up a Docker container for recompilation of the RPMs.

#. Ensure `Docker <https://docs.docker.com/>`_ and `Docker Compose
   <https://docs.docker.com/compose>`_ are installed.

#. Run the following::

       git clone https://github.com/jcu-eresearch/shibboleth-fastcgi.git
       cd shibboleth-fastcgi
       docker-compose up

#. Enjoy your new RPMs, available in the `build/` directory.

If you're not into Docker, then you can use the ``shibboleth-rebuild.sh``
script directly on your own RHEL or CentOS VM.  You'll need to ensure you have
set up the basic dependencies of building RPMs first; see the ``Dockerfile``
for more information.

Note
----

If you're just looking to download something that works and don't want to
rebuild things yourself, we have EL 6 x86_64 packages available in a
repo at https://www.hpc.jcu.edu.au/rpm/. You'll need to trust our RPM
building skills, though.
