#!/bin/bash
 
# replace x in 1.15.x-00 with the latest patch version
apt-mark unhold kubeadm && \
apt-get update && apt-get install -y kubeadm=1.15.2-00 && \
apt-mark hold kubeadm

kubeadm upgrade node
