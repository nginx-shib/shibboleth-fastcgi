FROM centos:8

# Install Shibboleth's recommended Service Provider repo as per
# https://shibboleth.net/downloads/service-provider/RPMS/
ADD shibboleth.repo /etc/yum.repos.d/shibboleth.repo

# Accept Shibboleth's GPG keys
RUN rpm --import https://shibboleth.net/downloads/service-provider/RPMS/repomd.xml.key
RUN rpm --import https://shibboleth.net/downloads/service-provider/RPMS/cantor.repomd.xml.key

# Install EPEL for fcgi-devel
RUN dnf install -y epel-release

# Install required packages for building
RUN dnf install -y \
  make \
  rpm-build \
  rpmdevtools \
  sudo \
  'dnf-command(config-manager)' \
  'dnf-command(download)' \
  'dnf-command(builddep)' \
  rsync

# Make the build area available
RUN mkdir -p /app/build

# 1. Build
# 2. Test by installing/running
#    Remove any installed packages from previous docker-compose runs
# 3. Copy the RPMs back to the host volume
CMD /app/shibboleth-rebuild.sh && \
  dnf remove -y shibboleth* && \
  dnf install -y ~/rpmbuild/RPMS/x86_64/*.rpm && \
  /usr/lib64/shibboleth/shibauthorizer && \
  /usr/lib64/shibboleth/shibresponder && \
  mkdir -p /app/build/centos-8/ && \
  rsync --no-relative -vahu ~/rpmbuild/RPMS ~/rpmbuild/SRPMS /app/build/centos-8/
