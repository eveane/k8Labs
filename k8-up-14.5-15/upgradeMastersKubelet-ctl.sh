#!/bin/bash

# replace x in 1.15.x-00 with the latest patch version
apt-mark unhold kubelet kubectl && \
apt-get update && apt-get install -y kubelet=1.15.2-00 kubectl=1.15.2-00 && \
apt-mark hold kubelet kubectl

systemctl restart kubelet

