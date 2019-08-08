 less bootstrap-scripts/run_haproxy.sh
  553  vi k8-up-14.5-15/upgradeAdditionalMaster.sh.swp
  554  vi k8-up-14.5-15/upgradeAdditionalMaster.sh
  555  chmod +x k8-up-14.5-15/upgradeAdditionalMaster.sh
  556  vi k8-up-14.5-15/upgradeMastersKubelet-ctl.sh
  557  scp -r k8-up-14.5-15 root@${MASTER1_IP}:~
  558  scp -r k8-up-14.5-15 root@${MASTER2_IP}:~
  559  scp -r k8-up-14.5-15 root@${MASTER3_IP}:~
  560  3ssh root@${MASTER2_IP} chmo
  561  chmod +x k8-up-14.5-15/upgradeMastersKubelet-ctl.sh
  562  scp -r k8-up-14.5-15 root@${MASTER1_IP}:~
  563  scp -r k8-up-14.5-15 root@${MASTER2_IP}:~
  564  scp -r k8-up-14.5-15 root@${MASTER3_IP}:~
  565  ssh root@${MASTER2_IP} k8-up-14.5-15/upgradeAdditionalMaster.sh
  566  ssh root@${MASTER3_IP} k8-up-14.5-15/upgradeAdditionalMaster.sh
  567  ssh root@${MASTER1_IP} k8-up-14.5-15/upgradeMastersKubelet-ctl.sh
  568  ssh root@${MASTER1_IP}
  569  scp -rf k8-up-14.5-15 root@${MASTER1_IP}:~
  570  scp k8-up-14.5-15/upgradeMastersKubelet-ctl.sh root@${MASTER1_IP}:~
  571  scp k8-up-14.5-15/upgradeMastersKubelet-ctl.sh root@${MASTER2_IP}:~
  572  scp k8-up-14.5-15/upgradeMastersKubelet-ctl.sh root@${MASTER3_IP}:~
  573  ssh root@${MASTER1_IP} k8-up-14.5-15/upgradeMastersKubelet-ctl.sh
  574  ssh root@${MASTER1_IP}
  575  ssh root@${MASTER1_IP} k8-up-14.5-15/upgradeMastersKubelet-ctl.sh
  576  ssh root@${MASTER2_IP} k8-up-14.5-15/upgradeMastersKubelet-ctl.sh
  577  ssh root@${MASTER2_IP} chmod +x k8-up-14.5-15/upgradeMastersKubelet-ctl.sh
  578  ssh root@${MASTER2_IP} k8-up-14.5-15/upgradeMastersKubelet-ctl.sh
  579  ssh root@${MASTER3_IP} chmod +x k8-up-14.5-15/upgradeMastersKubelet-ctl.sh
  580  ssh root@${MASTER3_IP} k8-up-14.5-15/upgradeMastersKubelet-ctl.sh
  581  ls -al k8-up-14.5-15/
  582  scp -rf k8-up-14.5-15 root@${WORKER1_IP}:~
  583  scp -r k8-up-14.5-15 root@${WORKER1_IP}:~
  584  scp -r k8-up-14.5-15 root@${WORKER2_IP}:~
  585  scp -r k8-up-14.5-15 root@${WORKER3_IP}:~
  586  scp root@${WORKER1_IP} k8-up-14.5-15/upgradekubeadm.sh
  587  ssh root@${WORKER1_IP} k8-up-14.5-15/upgradekubeadm.sh
  588  ssh root@${WORKER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubecttl get nodes
  589  ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubecttl get nodes
  590  ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl get nodes
  591  ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl drain k8s-worker-1 --ignore-daemonsets
  592* ssh root@${WORKER3_IP} kubeadm upgrade node
  593  ssh root@${WORKER1_IP} k8-up-14.5-15/upgradeMastersKubelet-ctl.sh
  594  ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl uncordon k8s-worker-1
  595  scp root@${WORKER2_IP} k8-up-14.5-15/upgradekubeadm.sh
  596  ssh root@${WORKER2_IP} k8-up-14.5-15/upgradekubeadm.sh
  597  ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl drain k8s-worker-2 --ignore-daemonsets
  598  ssh root@${WORKER2_IP} kubeadm upgrade node
  599  ssh root@${WORKER2_IP} k8-up-14.5-15/upgradeMastersKubelet-ctl.sh
  600  ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl uncordon k8s-worker-2
  601  ssh root@${WORKER3_IP} k8-up-14.5-15/upgradekubeadm.sh
  602  ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl drain k8s-worker-3 --ignore-daemonsets
  603  ssh root@${WORKER2_IP} kubeadm upgrade node
  604  ssh root@${WORKER3_IP} kubeadm upgrade node
  605  ssh root@${WORKER3_IP} k8-up-14.5-15/upgradeMastersKubelet-ctl.sh
  606  ssh root@${MASTER1_IP} -- KUBECONFIG=/etc/kubernetes/admin.conf kubectl uncordon k8s-worker-3

