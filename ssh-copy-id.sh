#!/bin/bash

source nodes.sh

ssh-copy-id root@${HAPROXY_IP}
ssh-copy-id root@${ETCD1_IP}
ssh-copy-id root@${ETCD2_IP}
ssh-copy-id root@${ETCD3_IP}
ssh-copy-id root@${MASTER1_IP}
ssh-copy-id root@${MASTER2_IP}
ssh-copy-id root@${MASTER3_IP}
ssh-copy-id root@${WORKER1_IP}
ssh-copy-id root@${WORKER2_IP}
ssh-copy-id root@${WORKER3_IP}