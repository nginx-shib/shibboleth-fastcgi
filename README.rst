Shibboleth SP Packages with FastCGI support
=======================================

.. image:: https://github.com/nginx-shib/shibboleth-fastcgi/actions/workflows/build.yml/badge.svg
   :target: https://github.com/nginx-shib/shibboleth-fastcgi/actions/workflows/build.yml

The Shibboleth SP software features FastCGI authorizer and responder
applications for use with any web server that supports FastCGI.
These applications can be used with nginx with the
`nginx-http-shibboleth module
<https://github.com/nginx-shib/nginx-http-shibboleth>`_, but are
entirely web-server agnostic.  Whilst present in the Shibboleth SP
source code, these FastCGI applications are not built into existing
Shibboleth packages.  Hence, this repository – scripts for rebuilding
the existing Shibboleth packages with FastCGI support.

We currently support the following OSes:

* CentOS/RHEL 8 (x86_64)
* CentOS/RHEL 7 (x86_64)
* CentOS/RHEL 6 (x86_64)

The rebuilding script is designed to work with SP version 3.1.0 and up. Build
scripts for older versions of the SP can be found in the tags and commit
history.

Why?
----

Unfortunately, the default distributions of the Shibboleth SP don't come with
FastCGI support built by default.  Questions have been raised on the
Shibboleth mailing list about adding this support to the core build, but to
date this hasn't happened because the ``fcgi-devel`` package lives in the `EPEL
repositories <https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/f/>`_ and not the core.

If you can help twist someone's arm to adjust this decision, that'd help
eliminate the need for this repository and us manually rebuilding Shibboleth
each time a new release comes out.

By "manually", we mean watching for or otherwise being told about new
Shibboleth SP releases, and then ensuring the package rebuild process
continues to function.  Here's the `current ATOM feed <https://wiki.shibboleth.net/confluence/spaces/createrssfeed.action?spaces=NEWS&sort=modified&title=Shibboleth+News+Blog&maxResults=15&publicFeed=true&rssType=atom&timeSpan=365&showContent=true&types=blogpost&maxResults=20>`_
from the Shibboleth wiki covering their blog post announcements, which
occasionally includes SP software releases.


Building
--------

This will always build the **latest version** of the Shibboleth SP and does so
by spinning up a Docker container for recompilation of the packages.

#. Ensure `Docker <https://docs.docker.com/>`_ and `Docker Compose
   <https://docs.docker.com/compose>`_ are installed.

#. Run the following::

       git clone https://github.com/nginx-shib/shibboleth-fastcgi.git
       cd shibboleth-fastcgi
       make

#. Enjoy your new packages, available in the ``build/`` directory, categorised by
   OS and distribution name.

#. When finished building, clean up your environment::

       make clean

If you're not into Docker, then you can use the ``shibboleth-rebuild.sh``
script directly on your own VM.  You'll need to ensure you have set up the
basic dependencies of building RPMs or packages first; see any of the
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
modifying the build scripts, note that ``docker-compose`` creates anonymous
volumes and retains the file system from the initial run of the containers.
This means that the built ``shibboleth`` packages will be "installed" already.
We automatically handle this by cleaning up this situation in each relevant
``Dockerfile`` but you can start afresh with a call like so::

   make clean
   make

which cleans up the anonymous volumes before starting again.

For more details, see `Overview of Docker Compose
<https://docs.docker.com/compose/overview/#preserve-volume-data-when-containers-are-created>`_.

Contributing
------------

Pull requests are welcome, especially if you want to add another distribution
or OS to the list of builds.  All support maintaining the existing
configuration or these packages is greatly appreciated.
