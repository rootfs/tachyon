#!/bin/bash
set -e
vagrant up --provider=openstack --no-provision

rm -f files/hosts.overwrite
HOSTS=`vagrant ssh-config 2>/dev/null |grep -w Host |awk '{print $2}'`
for h in $HOSTS
do
  addr=`vagrant ssh $h -c "ifconfig eth0" |grep -w inet|awk '{print $2}'`
  echo ${addr} ${h}".local" >> files/hosts.overwrite
done

vagrant provision