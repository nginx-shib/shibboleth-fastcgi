Recompiling Shibboleth SP RPMs with FastCGI support
===================================================

.. image:: https://travis-ci.org/nginx-shib/shibboleth-fastcgi.svg?branch=master
   :target: https://travis-ci.org/nginx-shib/shibboleth-fastcgi

The Shibboleth SP software features FastCGI authorizer and responder
applications for use with any web server that supports FastCGI.
This is used with Nginx with the `nginx-http-shibboleth
<https://github.com/nginx-shib/nginx-http-shibboleth>`_ module, but is
entirely web-server agnostic as it is simply a rebuild of the existing
packages.

Why?
----

Unfortunately, the default distributions of the Shibboleth SP don't come with
FastCGI support built by default.  Questions have been raised on the
Shibboleth mailing list about adding this support to the core build, but to
date this hasn't happened because the ``fcgi-devel`` package lives in the EPEL
repositories and not the core.

If you can help twist someone's arm to adjust this decision, that'd help
eliminate the need for this repository and us manually rebuilding Shibboleth
each time a new release comes out.

By "manually", we mean watching for or otherwise being told about new
Shibboleth SP releases.  Here's the `current ATOM feed <https://wiki.shibboleth.net/confluence/spaces/createrssfeed.action?spaces=NEWS&sort=modified&title=Shibboleth+News+Blog&maxResults=15&publicFeed=true&rssType=atom&timeSpan=365&showContent=true&types=blogpost&maxResults=20>`_
from the Shibboleth wiki covering their blog post announcements, which
occasionally includes SP software releases.

Building
--------

This will always build the **latest version** of the Shibboleth SP and does so
by spinning up a Docker container for recompilation of the RPMs.

#. Ensure `Docker <https://docs.docker.com/>`_ and `Docker Compose
   <https://docs.docker.com/compose>`_ are installed.

#. Run the following::

       git clone https://github.com/nginx-shib/shibboleth-fastcgi.git
       cd shibboleth-fastcgi
       docker-compose up

#. Enjoy your new RPMs, available in the `build/` directory, categorised by
   OS and distribution name.

#. When finished building, clean up your environment::

       docker-compose down -v

If you're not into Docker, then you can use the ``shibboleth-rebuild.sh``
script directly on your own RHEL or CentOS VM.  You'll need to ensure you have
set up the basic dependencies of building RPMs first; see any of the
``Dockerfile`` files for more information.

If you're just looking to download something that works and don't want to
rebuild things yourself, the James Cook University eResearch Centre provides
EL x86_64 packages in repos at
https://www.hpc.jcu.edu.au/repos/jcu_eresearch/. You'll need to trust our RPM
building skills and note that no support is offered to the public for this
service.

Developing
----------

If running ``docker-compose up`` repeatedly, such as when you might be
modifying the build scripts, note that ``docker-compose`` create anonymous
volumes and retains the file system from the initial run of the containers.
This means that the built ``shibboleth`` packages will be "installed" already.
We automatically handle this by cleaning up this situation in each relevant
``Dockerfile`` but you can start afresh with a call like so::

   docker-compose up -V

which removes the anonymous volumes before starting again.

Contributing
------------

Pull requests are welcome, especially if you want to add another distribution
or OS to the list of builds.  All support maintaining the existing
configuration or these packages is greatly appreciated.
