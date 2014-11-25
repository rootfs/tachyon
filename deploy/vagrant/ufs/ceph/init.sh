#!/bin/bash

# config yum repo
cat > /etc/yum.repos.d/epel.repo <<EOF
[epel]
name=Extra Packages for Enterprise Linux 6 - $basearch
mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=\$basearch
#failovermethod=priority
enabled=1
gpgcheck=0

EOF

sudo yum update -q
sudo rpm -Uvh http://ceph.com/rpm/rhel6/noarch/ceph-release-1-0.el6.noarch.rpm
yum install ceph-release python-itsdangerous python-werkzeug python-jinja2 python-flask java-1.7.0-openjdk-devel jna juit -y -q
echo "export HOME=/root" >> ~/.bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk.x86_64">> ~/.bashrc
# build tachyon pkg
#cd /tachyon
#mvn -q install -Dtest.profile=rados -Djava.version=1.7 -DskipTests
