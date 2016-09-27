#!/bin/sh

# Obtain the SRPM
yumdownloader --source shibboleth

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
