#!/bin/sh
set -e

# Download specific Shibboleth version or just the latest version
if [ "$_SHIBBOLETH_VERSION"  ]; then
    yumdownloader --source "shibboleth-$_SHIBBOLETH_VERSION"
else
    yumdownloader --source shibboleth
fi

# Install the SRPM's dependencies
sudo yum-builddep -y shibboleth*.src.rpm

# At time of writing (Sep 2018) there is no way of engaging conditional flags
# with yum-builddep so the optional PreReq packages need to be manually installed
# Info is scarce on this topic but see https://github.com/ceph/ceph/pull/8016
#
# There is also an issue where yum-builddep tries to install a 32-bit httpd-devel
# when run against a .src.rpm on CentOS 6.  The same issue doesn't happen
# against the .spec file. Conversely, libmemcached-devel has the same issue in
# reverse on CentOS 7 (installs with .src.rpm and doesn't under .spec).
# See https://github.com/nginx-shib/shibboleth-fastcgi/issues/3
sudo yum install -y \
    fcgi-devel \
    xmltooling-schemas \
    opensaml-schemas \
    httpd-devel \
    libmemcached-devel

# Rebuild with FastCGI support
rpmbuild --rebuild shibboleth*.src.rpm --with fastcgi

# Remove original SRPM
rm shibboleth*.src.rpm -f
