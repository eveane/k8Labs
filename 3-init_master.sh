#!/bin/bash
source nodes.sh

ssh root@${MASTER1_IP} bootstrap-scripts/reset.sh

cat <<EOF >bootstrap-config/master-external-etcd-${K8S_MINOR}.yaml
apiVersion: kubeadm.k8s.io/v1beta1
kind: ClusterConfiguration
kubernetesVersion: ${K8S_PATCH}
apiServer:
  certSANs:
  - "${HAPROXY_IP}"
controlPlaneEndpoint: "${HAPROXY_IP}:6443"
networking:
    podSubnet: "${POD_CIDR}"
etcd:
    external:
        endpoints:
        - https://${ETCD1_IP}:2379
        - https://${ETCD2_IP}:2379
        - https://${ETCD3_IP}:2379
        caFile: /etc/kubernetes/pki/etcd/ca.crt
        certFile: /etc/kubernetes/pki/apiserver-etcd-client.crt
        keyFile: /etc/kubernetes/pki/apiserver-etcd-client.key
EOF

ssh root@${MASTER1_IP} -- rm -rf bootstrap-scripts
ssh root@${MASTER1_IP} -- rm -rf bootstrap-config
scp -r bootstrap-scripts/ root@${MASTER1_IP}:bootstrap-scripts
scp -r bootstrap-config/ root@${MASTER1_IP}:bootstrap-config

# ssh root@${MASTER1_IP} -- mkdir /etc/kubernetes/pki
ssh root@${MASTER1_IP} -- mkdir -p /etc/kubernetes/pki/etcd
ssh root@${MASTER1_IP} -- mv bootstrap-config/etcd-ca.crt /etc/kubernetes/pki/etcd/ca.crt
ssh root@${MASTER1_IP} -- mv bootstrap-config/etcd-apiserver-etcd-client.crt /etc/kubernetes/pki/apiserver-etcd-client.crt
ssh root@${MASTER1_IP} -- mv bootstrap-config/etcd-apiserver-etcd-client.key /etc/kubernetes/pki/apiserver-etcd-client.key

ssh root@${MASTER1_IP} -- kubeadm init --config bootstrap-config/master-external-etcd-${K8S_MINOR}.yaml
ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl get pods --all-namespaces
ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl get nodes
ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl apply -f ${CNI_MANIFEST}
sleep 30
ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl get pods --all-namespaces
ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl get nodes
