#!/bin/sh

# Download specific Shibboleth version or just the latest version
if [ "$_SHIBBOLETH_VERSION"  ]; then
    yumdownloader --source "shibboleth-$_SHIBBOLETH_VERSION"
else
    yumdownloader --source shibboleth
fi

# Install the SRPM's dependencies
# There currently appears to be a bug in yum-builddep where it tries to
# install a 32-bit version of httpd-devel when run against the RPM vs
# its spec file.
#sudo yum-builddep -y shibboleth*.src.rpm

sudo rpm -i shibboleth*.src.rpm
sudo yum-builddep -y ~/rpmbuild/SPECS/shibboleth.spec

# Is there a way of passing --with fastcgi to yum-builddep or getting PreReq
# installed without manual intervention?
sudo yum install -y \
    fcgi-devel \
    xmltooling-schemas \
    opensaml-schemas

# Rebuild with FastCGI support
rpmbuild --rebuild shibboleth*.src.rpm --with fastcgi

# Remove original SRPM
rm shibboleth*.src.rpm -f
