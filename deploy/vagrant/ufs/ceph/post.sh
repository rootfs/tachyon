#!/bin/sh
set -e
install_opt="--dev giant"
NODES=`cat /tachyon/conf/slaves`
#on admin node, create ssh key and deploy on all NODES  
CLUSTER=""
for i in ${NODES[@]}
do
    echo $i
    CLUSTER=`echo -n $i $CLUSTER`
done

# choose the last node as master
MASTER=$i

yum install -y -q ceph-deploy  

ceph-deploy install ${install_opt} ${CLUSTER}
#create ceph cluster
ceph-deploy new ${MASTER}  
ceph-deploy mon create ${MASTER}
ceph-deploy gatherkeys ${MASTER}  

#create ceph osd  
for i in ${NODES[@]}
do
    ceph-deploy disk zap ${i}:sdb
    ceph-deploy osd create ${i}:sdb
done

ceph-deploy admin ${CLUSTER}

#start ceph on all NODES  
for i in ${NODES[@]}
do
    echo $i
    ssh root@${i} service ceph restart
done

#see if we are ready to go  
#osd tree should show all osd are up  
ceph osd tree  
#ceph health should be clean+ok  
ceph health  
# create a pool
ceph osd pool create data 128
rados -p data ls  
#create a file in the pool  
rados -p data put group /etc/group  
#see if the file is created  
rados -p data ls  
