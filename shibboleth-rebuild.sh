#!/bin/sh
set -e

# Handle different package manager changes
if [ -x "$(command -v dnf)" ]; then
    pkgmanager="dnf"
    download_cmd="dnf download"
    builddep_cmd="dnf builddep"

    # For build dependencies: doxygen
    dnf config-manager --enable powertools
else
    pkgmanager="yum"
    download_cmd="yumdownloader"
    builddep_cmd="yum-builddep"
fi

# EL6 requires specific packages
os_version=$(rpm -qa --queryformat '%{VERSION}' '(redhat|sl|slf|centos|oraclelinux)-release(|-server|-workstation|-client|-computenode)')
case $os_version in
    6*)
      builddep_pkgs="httpd-devel"
    ;;
esac

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
sudo $pkgmanager install -y \
    fcgi-devel \
    $builddep_pkgs

# Rebuild with FastCGI support
rpmbuild --rebuild shibboleth*.src.rpm --with fastcgi

# Remove original SRPM
rm shibboleth*.src.rpm -f
