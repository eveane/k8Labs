#!/bin/bash
source nodes.sh

cat > bootstrap-scripts/install_docker.sh <<ENDFILE
#!/bin/bash
apt-get remove -y docker-ce

# Install Docker CE
## Set up the repository:
### Update the apt package index
    apt-get update

### Install packages to allow apt to use a repository over HTTPS
    apt-get update && apt-get install -y apt-transport-https ca-certificates curl software-properties-common

### Add Docker’s official GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

### Add docker apt repository.
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    \$(lsb_release -cs) \
    stable"

## Install docker ce.
apt-get update && apt-get install -y docker-ce=${DOCKER_VERSION}

# Setup daemon.
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=${CGROUP_DRIVER}"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

mkdir -p /etc/systemd/system/docker.service.d

# Restart docker.
systemctl daemon-reload
systemctl restart docker
ENDFILE

chmod +x bootstrap-scripts/install_docker.sh

scp bootstrap-scripts/install_docker.sh root@${WORKER1_IP}:/tmp/install_docker.sh
scp bootstrap-scripts/install_docker.sh root@${WORKER2_IP}:/tmp/install_docker.sh
scp bootstrap-scripts/install_docker.sh root@${WORKER3_IP}:/tmp/install_docker.sh

ssh root@${WORKER1_IP} /tmp/install_docker.sh
ssh root@${WORKER2_IP} /tmp/install_docker.sh
ssh root@${WORKER3_IP} /tmp/install_docker.sh

cat > bootstrap-scripts/install_kubeadm.sh <<ENDFILE
#!/bin/bash
apt-get remove -y kubelet kubeadm kubectl
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet=${K8S_PATCH}-00 kubeadm=${K8S_PATCH}-00 kubectl=${K8S_PATCH}-00
ENDFILE

chmod +x bootstrap-scripts/install_kubeadm.sh

scp bootstrap-scripts/install_kubeadm.sh root@${WORKER1_IP}:/tmp/install_kubeadm.sh
scp bootstrap-scripts/install_kubeadm.sh root@${WORKER2_IP}:/tmp/install_kubeadm.sh
scp bootstrap-scripts/install_kubeadm.sh root@${WORKER3_IP}:/tmp/install_kubeadm.sh
ssh root@${WORKER1_IP} /tmp/install_kubeadm.sh
ssh root@${WORKER2_IP} /tmp/install_kubeadm.sh
ssh root@${WORKER3_IP} /tmp/install_kubeadm.sh
