FROM centos:6
MAINTAINER "JCU eResearch Centre" <eresearch.nospam@jcu.edu.au>

# Install from OpenSUSE's Shibboleth repository
RUN curl https://download.opensuse.org/repositories/security://shibboleth/RHEL_6/security:shibboleth.repo > /etc/yum.repos.d/shibboleth.repo
RUN rpm --import https://download.opensuse.org/repositories/security:/shibboleth/RHEL_6//repodata/repomd.xml.key

# Configure EPEL for fcgi-devel
RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm

# Install required packages for building
RUN yum install -y \
  make \
  rpm-build \
  rpmdevtools \
  sudo \
  yum-utils \
  rsync

# Make the build area available
RUN mkdir -p /app/build

# 1. Build
# 2. Test
# 3. Copy the RPMs back to the host volume
CMD /app/shibboleth-rebuild.sh && \
  yum install -y ~/rpmbuild/RPMS/x86_64/*.rpm && \
  /usr/lib64/shibboleth/shibauthorizer && \
  /usr/lib64/shibboleth/shibresponder && \
  mkdir -p /app/build/centos-6/ && \
  rsync --no-relative -vahu ~/rpmbuild/RPMS ~/rpmbuild/SRPMS /app/build/centos-6/
