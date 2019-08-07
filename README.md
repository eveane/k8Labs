# k8Labs
> set nodes.sh with correct ip and versions
## first run external etcd cluster deployment:
run ./00-setup_etcds.sh
run ./00-setup_all-masters.sh
run ./00-setup_all-workers.sh
run ./1-launch_haproxy.sh
run ./etcd_bootstrap.sh
run ./2-get_etcd_certs.sh
run ./3-init-master.sh
run ./4-join-masters.sh
run ./5-join-workers.sh

## reset setup

run ./0-reset_all.sh
run ./0-reset_etcd.sh

## run stacked etcd cluster (to be validated)

run ./00-setup_all-masters.sh
run ./00-setup_all-workers.sh
run ./1-launch_haproxy.sh
run ./etcd_bootstrap.sh
run ./3-init-master.sh  (code to be reviewed)
run ./4-join-masters.sh (code to handle join when experimental join is not supported or in prod)
run ./5-join-workers.sh

### comments

full bootstraps scripts to be updated
