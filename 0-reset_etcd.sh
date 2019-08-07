#!/bin/bash

source nodes.sh

ssh root@${ETCD1_IP} rm -rf bootstrap-scripts
ssh root@${ETCD1_IP} rm -rf bootstrap-config
scp -r bootstrap-scripts/ root@${ETCD1_IP}:bootstrap-scripts
scp -r bootstrap-config/ root@${ETCD1_IP}:bootstrap-config
ssh root@${ETCD1_IP} bootstrap-scripts/reset.sh

ssh root@${ETCD2_IP} rm -rf bootstrap-scripts
ssh root@${ETCD2_IP} rm -rf bootstrap-config
scp -r bootstrap-scripts/ root@${ETCD2_IP}:bootstrap-scripts
scp -r bootstrap-config/ root@${ETCD2_IP}:bootstrap-config
ssh root@${ETCD2_IP} bootstrap-scripts/reset.sh

ssh root@${ETCD3_IP} rm -rf bootstrap-scripts
ssh root@${ETCD3_IP} rm -rf bootstrap-config
scp -r bootstrap-scripts/ root@${ETCD3_IP}:bootstrap-scripts
scp -r bootstrap-config/ root@${ETCD3_IP}:bootstrap-config
ssh root@${ETCD3_IP} bootstrap-scripts/reset.sh

