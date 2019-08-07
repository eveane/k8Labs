#!/bin/bash
source nodes.sh

scp bootstrap-scripts/static_kubelet.sh root@${ETCD1_IP}:static_kubelet.sh
scp bootstrap-scripts/static_kubelet.sh root@${ETCD2_IP}:static_kubelet.sh
scp bootstrap-scripts/static_kubelet.sh root@${ETCD3_IP}:static_kubelet.sh

ssh root@${ETCD1_IP} ./static_kubelet.sh
ssh root@${ETCD2_IP} ./static_kubelet.sh
ssh root@${ETCD3_IP} ./static_kubelet.sh

ssh root@${ETCD1_IP} kubeadm init phase certs etcd-ca

scp root@${ETCD1_IP}:/etc/kubernetes/pki/etcd/ca.crt bootstrap-config/etcd-ca.crt
scp root@${ETCD1_IP}:/etc/kubernetes/pki/etcd/ca.key bootstrap-config/etcd-ca.key

ssh root@${ETCD2_IP} mkdir -p /etc/kubernetes/pki/etcd
ssh root@${ETCD3_IP} mkdir -p /etc/kubernetes/pki/etcd

scp bootstrap-config/etcd-ca.crt root@${ETCD2_IP}:/etc/kubernetes/pki/etcd/ca.crt
scp bootstrap-config/etcd-ca.key root@${ETCD2_IP}:/etc/kubernetes/pki/etcd/ca.key

scp bootstrap-config/etcd-ca.crt root@${ETCD3_IP}:/etc/kubernetes/pki/etcd/ca.crt
scp bootstrap-config/etcd-ca.key root@${ETCD3_IP}:/etc/kubernetes/pki/etcd/ca.key

cat > bootstrap-config/etcd1.yaml <<ENDFILE
apiVersion: "kubeadm.k8s.io/v1beta1"
kind: ClusterConfiguration
kubernetesVersion: ${K8S_PATCH} 
etcd:
    local:
        serverCertSANs:
        - "${ETCD1_IP}"
        peerCertSANs:
        - "${ETCD1_IP}"
        extraArgs:
            initial-cluster: ${ETCD1_HOST}=https://${ETCD1_IP}:2380,${ETCD2_HOST}=https://${ETCD2_IP}:2380,${ETCD3_HOST}=https://${ETCD3_IP}:2380
            initial-cluster-state: new
            name: ${ETCD1_HOST}
            listen-peer-urls: https://${ETCD1_IP}:2380
            listen-client-urls: https://${ETCD1_IP}:2379
            advertise-client-urls: https://${ETCD1_IP}:2379
            initial-advertise-peer-urls: https://${ETCD1_IP}:2380
ENDFILE

cat > bootstrap-config/etcd2.yaml <<ENDFILE
apiVersion: "kubeadm.k8s.io/v1beta1"
kind: ClusterConfiguration
kubernetesVersion: ${K8S_PATCH}
etcd:
    local:
        serverCertSANs:
        - "${ETCD2_IP}"
        peerCertSANs:
        - "${ETCD2_IP}"
        extraArgs:
            initial-cluster: ${ETCD1_HOST}=https://${ETCD1_IP}:2380,${ETCD2_HOST}=https://${ETCD2_IP}:2380,${ETCD3_HOST}=https://${ETCD3_IP}:2380
            initial-cluster-state: new
            name: ${ETCD2_HOST}
            listen-peer-urls: https://${ETCD2_IP}:2380
            listen-client-urls: https://${ETCD2_IP}:2379
            advertise-client-urls: https://${ETCD2_IP}:2379
            initial-advertise-peer-urls: https://${ETCD2_IP}:2380
ENDFILE

cat > bootstrap-config/etcd3.yaml <<ENDFILE
apiVersion: "kubeadm.k8s.io/v1beta1"
kind: ClusterConfiguration
kubernetesVersion: ${K8S_PATCH}
etcd:
    local:
        serverCertSANs:
        - "${ETCD3_IP}"
        peerCertSANs:
        - "${ETCD3_IP}"
        extraArgs:
            initial-cluster: ${ETCD1_HOST}=https://${ETCD1_IP}:2380,${ETCD2_HOST}=https://${ETCD2_IP}:2380,${ETCD3_HOST}=https://${ETCD3_IP}:2380
            initial-cluster-state: new
            name: ${ETCD3_HOST}
            listen-peer-urls: https://${ETCD3_IP}:2380
            listen-client-urls: https://${ETCD3_IP}:2379
            advertise-client-urls: https://${ETCD3_IP}:2379
            initial-advertise-peer-urls: https://${ETCD3_IP}:2380
ENDFILE

scp bootstrap-config/etcd1.yaml root@${ETCD1_IP}:etcd.yaml
scp bootstrap-config/etcd2.yaml root@${ETCD2_IP}:etcd.yaml
scp bootstrap-config/etcd3.yaml root@${ETCD3_IP}:etcd.yaml

ssh root@${ETCD1_IP} "kubeadm init phase certs etcd-server --config=etcd.yaml; kubeadm init phase certs etcd-peer --config=etcd.yaml;kubeadm init phase certs etcd-healthcheck-client --config=etcd.yaml;kubeadm init phase certs apiserver-etcd-client --config=etcd.yaml"
ssh root@${ETCD2_IP} "kubeadm init phase certs etcd-server --config=etcd.yaml; kubeadm init phase certs etcd-peer --config=etcd.yaml;kubeadm init phase certs etcd-healthcheck-client --config=etcd.yaml;kubeadm init phase certs apiserver-etcd-client --config=etcd.yaml"
ssh root@${ETCD3_IP} "kubeadm init phase certs etcd-server --config=etcd.yaml; kubeadm init phase certs etcd-peer --config=etcd.yaml;kubeadm init phase certs etcd-healthcheck-client --config=etcd.yaml;kubeadm init phase certs apiserver-etcd-client --config=etcd.yaml"

ssh root@${ETCD1_IP} "kubeadm init phase etcd local --config=etcd.yaml"
ssh root@${ETCD2_IP} "kubeadm init phase etcd local --config=etcd.yaml"
ssh root@${ETCD3_IP} "kubeadm init phase etcd local --config=etcd.yaml"

scp bootstrap-scripts/etcdctl.sh root@${ETCD1_IP}:/etcdctl.sh
scp bootstrap-scripts/etcdctl.sh root@${ETCD2_IP}:/etcdctl.sh
scp bootstrap-scripts/etcdctl.sh root@${ETCD3_IP}:/etcdctl.sh

ssh -t root@${ETCD1_IP} /etcdctl.sh member list
