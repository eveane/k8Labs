#!/bin/bash
source nodes.sh


ssh root@${WORKER1_IP} "kubeadm reset -f; iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X; rm -rf /var/lib/etcd"
ssh root@${WORKER2_IP} "kubeadm reset -f; iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X; rm -rf /var/lib/etcd"
ssh root@${WORKER3_IP} "kubeadm reset -f; iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X; rm -rf /var/lib/etcd"

export JOINCMD=`ssh root@${MASTER1_IP} -- kubeadm token create --print-join-command`

ssh root@${WORKER1_IP} -- "$JOINCMD"
ssh root@${WORKER2_IP} -- "$JOINCMD"
ssh root@${WORKER3_IP} -- "$JOINCMD"

sleep 30

ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl get pods --all-namespaces
ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl get nodes
