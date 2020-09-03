#!/bin/sh
set -e

if [ -x "$(command -v dnf)" ]; then
    pkgmanager="dnf"
    download_cmd="dnf download"
    builddep_cmd="dnf builddep"

    # For build dependencies: doxygen
    dnf config-manager --set-enabled PowerTools
else
    pkgmanager="yum"
    download_cmd="yumdownloader"
    builddep_cmd="yum-builddep"
fi

# Download specific Shibboleth version or just the latest version
if [ "$_SHIBBOLETH_VERSION" ]; then
    $download_cmd --source "shibboleth-$_SHIBBOLETH_VERSION"
else
    $download_cmd --source shibboleth
fi

# Install the SRPM's dependencies
sudo $builddep_cmd -y shibboleth*.src.rpm

# At time of writing (Sep 2020) there is no way of engaging conditional flags
# with dnf builddep (or yum-builddep) so the optional PreReq packages need to
# be manually installed Info is scarce on this topic but see
# https://github.com/ceph/ceph/pull/8016
sudo $pkgmanager install -y fcgi-devel

# Rebuild with FastCGI support
rpmbuild --rebuild shibboleth*.src.rpm --with fastcgi

# Remove original SRPM
rm shibboleth*.src.rpm -f
