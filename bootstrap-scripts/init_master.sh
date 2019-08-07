#!/bin/bash

# at this point certs should sent from master 1
# remove items we don't need 

rm /etc/kubernetes/pki/api*
rm /etc/kubernetes/pki/front-proxy-client*
rm /etc/kubernetes/pki/etcd/health*
rm /etc/kubernetes/pki/etcd/peer*
rm /etc/kubernetes/pki/etcd/server*