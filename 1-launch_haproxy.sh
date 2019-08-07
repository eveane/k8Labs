#!/bin/bash

source nodes.sh

cat <<EOF >bootstrap-config/haproxy.cfg
global
defaults
	timeout client		30s
	timeout server		30s
	timeout connect		30s

frontend k8s-api
	bind			0.0.0.0:6443
	mode			tcp
	default_backend		k8s-api

backend k8s-api
   mode tcp
   option tcp-check
   balance roundrobin
   default-server inter 10s downinter 5s rise 2 fall 2 slowstart 60s maxconn 250 maxqueue 256 weight 100

       server kube-apiserver-1 ${MASTER1_IP}:6443 check
       server kube-apiserver-2 ${MASTER2_IP}:6443 check
       server kube-apiserver-3 ${MASTER3_IP}:6443 check

listen stats # Define a listen section called "stats"
  bind 0.0.0.0:9000 # Listen on localhost:9000
  mode http
  stats enable  # Enable stats page
  stats hide-version  # Hide HAProxy version
  stats realm Haproxy\ Statistics  # Title text for popup window
  stats uri /  # Stats URI
EOF

scp -r bootstrap-scripts/ root@${HAPROXY_IP}:bootstrap-scripts
scp -r bootstrap-config/ root@${HAPROXY_IP}:bootstrap-config

ssh root@${HAPROXY_IP} bootstrap-scripts/run_haproxy.sh