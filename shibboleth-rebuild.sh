#!/bin/sh

# Download specific Shibboleth version or just the latest version
if [ "$_SHIBBOLETH_VERSION"  ]; then
    yumdownloader --source "shibboleth-$_SHIBBOLETH_VERSION"
else
    yumdownloader --source shibboleth
fi

# Install the SRPM's dependencies
sudo yum-builddep -y shibboleth*.src.rpm
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
