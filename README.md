# k8Labs
> set nodes.sh with correct ip and versions
> source node.sh
> run ssh-keygen on local machine
> run ./ssh_copy_id.sh

## first run external etcd cluster deployment: 
1. run ./00-setup_etcds.sh
2. run ./00-setup_all-masters.sh
3. run ./00-setup_all-workers.sh
4. run ./1-launch_haproxy.sh
5. run ./etcd_bootstrap.sh
6. run ./2-get_etcd_certs.sh
7. run ./3-init-master.sh
8. run ./4-join-masters.sh
9. run ./5-join-workers.sh

## reset setup

1. run ./0-reset_all.sh
2. run ./0-reset_etcd.sh

## run stacked etcd cluster (to be validated)

1. run ./00-setup_all-masters.sh
2. run ./00-setup_all-workers.sh
3. run ./1-launch_haproxy.sh
4. run ./etcd_bootstrap.sh
5. run ./3-init-master.sh  (code to be reviewed)
6. run ./4-join-masters.sh (code to handle join when experimental join is not supported or in prod)
7. run ./5-join-workers.sh

### comments

full bootstraps scripts to be updated
need to fix nodes.sh (currently it is a symlink and node a file)
