#!/bin/bash

source nodes.sh

ssh root@${HAPROXY_IP} docker kill haproxy
ssh root@${HAPROXY_IP} docker rm haproxy

ssh root@${MASTER1_IP} rm -rf bootstrap-scripts
ssh root@${MASTER1_IP} rm -rf bootstrap-config
scp -r bootstrap-scripts/ root@${MASTER1_IP}:bootstrap-scripts
scp -r bootstrap-config/ root@${MASTER1_IP}:bootstrap-config
ssh root@${MASTER1_IP} bootstrap-scripts/reset.sh

ssh root@${MASTER2_IP} rm -rf bootstrap-scripts
ssh root@${MASTER2_IP} rm -rf bootstrap-config
scp -r bootstrap-scripts/ root@${MASTER2_IP}:bootstrap-scripts
scp -r bootstrap-config/ root@${MASTER2_IP}:bootstrap-config
ssh root@${MASTER2_IP} bootstrap-scripts/reset.sh

ssh root@${MASTER3_IP} rm -rf bootstrap-scripts
ssh root@${MASTER3_IP} rm -rf bootstrap-config
scp -r bootstrap-scripts/ root@${MASTER3_IP}:bootstrap-scripts
scp -r bootstrap-config/ root@${MASTER3_IP}:bootstrap-config
ssh root@${MASTER3_IP} bootstrap-scripts/reset.sh

ssh root@${WORKER1_IP} rm -rf bootstrap-scripts
ssh root@${WORKER1_IP} rm -rf bootstrap-config
scp -r bootstrap-scripts/ root@${WORKER1_IP}:bootstrap-scripts
scp -r bootstrap-config/ root@${WORKER1_IP}:bootstrap-config
ssh root@${WORKER1_IP} bootstrap-scripts/reset.sh

ssh root@${WORKER2_IP} rm -rf bootstrap-scripts
ssh root@${WORKER2_IP} rm -rf bootstrap-config
scp -r bootstrap-scripts/ root@${WORKER2_IP}:bootstrap-scripts
scp -r bootstrap-config/ root@${WORKER2_IP}:bootstrap-config
ssh root@${WORKER2_IP} bootstrap-scripts/reset.sh

ssh root@${WORKER3_IP} rm -rf bootstrap-scripts
ssh root@${WORKER3_IP} rm -rf bootstrap-config
scp -r bootstrap-scripts/ root@${WORKER3_IP}:bootstrap-scripts
scp -r bootstrap-config/ root@${WORKER3_IP}:bootstrap-config
ssh root@${WORKER3_IP} bootstrap-scripts/reset.sh

