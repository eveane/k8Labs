#!/bin/bash

kubeadm reset -f
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X
rm -rf /var/lib/etcd

rm /etc/systemd/system/kubelet.service.d/*

cat << EOF > /etc/systemd/system/kubelet.service.d/20-etcd-service-manager.conf
[Service]
ExecStart=
ExecStart=/usr/bin/kubelet --cgroup-driver=systemd  --address=127.0.0.1 --pod-manifest-path=/etc/kubernetes/manifests --allow-privileged=true
Restart=always
EOF

systemctl daemon-reload
systemctl restart kubelet
sleep 5

systemctl status kubelet