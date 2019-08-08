#!/bin/bash

apt-get install -y docker.io

docker kill haproxy
docker rm haproxy

#docker run --name haproxy -p 9000:9000 -p 6443:6443  -d chadmoon/kube-apiserver-haproxy:latest

cat ~/bootstrap-config/haproxy.cfg

docker run --name haproxy -d -p 6443:6443 -p 9000:9000 -v /root/bootstrap-config/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg haproxy:1.9.4