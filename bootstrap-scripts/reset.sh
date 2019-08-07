#!/bin/bash

kubeadm reset -f
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X
rm -rf /var/lib/etcd