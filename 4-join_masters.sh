#!/bin/bash
source nodes.sh

rm -rf bootstrap-config/master-1-pki
rm -rf bootstrap-config/master-2-pki
rm -rf bootstrap-config/master-3-pki
rm -f bootstrap-config/admin.conf

ssh root@${MASTER2_IP} bootstrap-scripts/reset.sh
ssh root@${MASTER3_IP} bootstrap-scripts/reset.sh
ssh root@${MASTER2_IP} rm -f /etc/kubernetes/admin.conf
ssh root@${MASTER3_IP} rm -f /etc/kubernetes/admin.conf

scp -r root@${MASTER1_IP}:/etc/kubernetes/pki/ bootstrap-config/master-1-pki
scp root@${MASTER1_IP}:/etc/kubernetes/admin.conf bootstrap-config/admin.conf

cp -r bootstrap-config/master-1-pki bootstrap-config/master-2-pki
cp -r bootstrap-config/master-1-pki bootstrap-config/master-3-pki

rm bootstrap-config/master-2-pki/api*
rm bootstrap-config/master-2-pki/front-proxy-client*
rm bootstrap-config/master-2-pki/etcd/health*
rm bootstrap-config/master-2-pki/etcd/peer*
rm bootstrap-config/master-2-pki/etcd/server*

rm bootstrap-config/master-3-pki/api*
rm bootstrap-config/master-3-pki/front-proxy-client*
rm bootstrap-config/master-3-pki/etcd/health*
rm bootstrap-config/master-3-pki/etcd/peer*
rm bootstrap-config/master-3-pki/etcd/server*

ssh root@${MASTER2_IP} mkdir /etc/kubernetes/pki
ssh root@${MASTER2_IP} -- mkdir /etc/kubernetes/pki/etcd
scp bootstrap-config/etcd-ca.crt root@${MASTER2_IP}:/etc/kubernetes/pki/etcd/ca.crt
scp bootstrap-config/etcd-apiserver-etcd-client.crt root@${MASTER2_IP}:/etc/kubernetes/pki/apiserver-etcd-client.crt
scp bootstrap-config/etcd-apiserver-etcd-client.key root@${MASTER2_IP}:/etc/kubernetes/pki/apiserver-etcd-client.key
scp -r bootstrap-config/master-2-pki/* root@${MASTER2_IP}:/etc/kubernetes/pki
scp bootstrap-config/admin.conf root@${MASTER2_IP}:/etc/kubernetes/admin.conf

ssh root@${MASTER3_IP} mkdir /etc/kubernetes/pki
ssh root@${MASTER3_IP} -- mkdir /etc/kubernetes/pki/etcd
scp bootstrap-config/etcd-ca.crt root@${MASTER3_IP}:/etc/kubernetes/pki/etcd/ca.crt
scp bootstrap-config/etcd-apiserver-etcd-client.crt root@${MASTER3_IP}:/etc/kubernetes/pki/apiserver-etcd-client.crt
scp bootstrap-config/etcd-apiserver-etcd-client.key root@${MASTER3_IP}:/etc/kubernetes/pki/apiserver-etcd-client.key
scp -r bootstrap-config/master-3-pki/* root@${MASTER3_IP}:/etc/kubernetes/pki
scp bootstrap-config/admin.conf root@${MASTER3_IP}:/etc/kubernetes/admin.conf


export JOINCMD=`ssh root@${MASTER1_IP} -- kubeadm token create --print-join-command`

echo "$JOINCMD --experimental-control-plane" 

ssh root@${MASTER2_IP} -- "$JOINCMD --experimental-control-plane"

ssh root@${MASTER3_IP} -- "$JOINCMD --experimental-control-plane"

sleep 30

ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl get pods --all-namespaces
ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl get nodes
