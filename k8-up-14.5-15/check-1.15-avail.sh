#!/bin/bash

apt update
apt-cache policy kubeadm | grep "1.15"
# find the latest 1.15 version in the list
# it should look like 1.15.x-00, where x is the latest patch
