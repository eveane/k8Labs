#!/bin/bash
source nodes.sh

scp root@${ETCD1_IP}:/etc/kubernetes/pki/etcd/ca.crt bootstrap-config/etcd-ca.crt
scp root@${ETCD1_IP}:/etc/kubernetes/pki/apiserver-etcd-client.crt bootstrap-config/etcd-apiserver-etcd-client.crt
scp root@${ETCD1_IP}:/etc/kubernetes/pki/apiserver-etcd-client.key bootstrap-config/etcd-apiserver-etcd-client.key

