#!/bin/bash

#EPEL required for fcgi-devel library
sudo rpm -ihv http://mirror.aarnet.edu.au/pub/epel/6/i386/epel-release-6-8.noarch.rpm

#Configure Shibboleth repository for dependencies
sudo wget http://download.opensuse.org/repositories/security://shibboleth/RHEL_6/security:shibboleth.repo -O /etc/yum.repos.d/shibboleth.repo

#Install all the things!
#Note: most of the following was manually determined. YMMV on newer versions.
sudo yum install -y \
	rpm-build \
	yum-utils \
	libxerces-c-devel \
	libxml-security-c-devel \
	libxmltooling-devel \
	xmltooling-schemas \
	libsaml-devel \
	opensaml-schemas \
	liblog4shib-devel \
	chrpath boost-devel \
	doxygen \
	unixODBC-devel \
	fcgi-devel \
	httpd-devel \
	redhat-rpm-config \
	pcre-devel \
	zlib-devel 

cd /vagrant

#Obtain the SPRM
yumdownloader --source shibboleth

#Rebuild with FastCGI support
rpmbuild --rebuild shibboleth*.src.rpm --with fastcgi

#Copy the RPMs out and back to the shared folder
rsync --no-relative -vahu ~/rpmbuild/RPMS/* .

#Remove original SRPM
rm shibboleth*.src.rpm -f

#All done - see ya!
