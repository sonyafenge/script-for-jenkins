#!/bin/bash

echo "Clean up folders and files in preset machines"

export PRESET_KUBE_MASTER_IP=172.31.6.63  #54.149.252.144
export PRESET_KUBE_MINION1_IP=172.31.11.206  #35.160.80.224

read -r -d '' CMD_CLEAN_DIR << EOM
  sudo rm -rf /etc/motd
  sudo rm -rf /etc/systemd/system/multi-user.target.wants/kubelet.service
  sudo rm -rf /etc/kubernetes
  sudo rm -rf /etc/srv/kubernetes
  sudo rm -rf /etc/systemd/system/kubelet.service.d
  sudo rm -rf /home/ubuntu/.kube/
  sudo rm -rf /lib/systemd/system/kubelet.service
  sudo rm -rf /mnt/master-pd
  sudo rm -rf /root/.kube
  sudo rm -rf /srv/kubernetes
  sudo rm -rf /tmp/bootstrap-script  
  sudo rm -rf /tmp/kubernetes-server-linux-amd64.tar.gz
  sudo rm -rf /tmp/master-user-data  
  sudo rm -rf /usr/bin/kubeadm
  sudo rm -rf /usr/bin/kubectl
  sudo rm -rf /usr/bin/kubelet
  sudo rm -rf /usr/libexec/kubernetes
  sudo rm -rf /usr/libexec/kubernetes/kubelet-plugins
  sudo rm -rf /usr/local/bin/kube-proxy
  sudo rm -rf /usr/share/sosreport/sos/plugins/__pycache__/kubernetes.cpython-35.pyc
  sudo rm -rf /usr/share/sosreport/sos/plugins/kubernetes.py  
  sudo rm -rf /usr/bin/kubelet
  sudo rm -rf /var/log/containers/* 
  sudo rm -rf /var/log/workload-controller-manager.log 
  sudo rm -rf /var/cache/kubernetes-install
  sudo rm -rf /var/log/pods  
  sudo rm -rf /usr/share/sosreport/sos/plugins/__pycache__/etcd.cpython-35.pyc
  sudo rm -rf /usr/share/sosreport/sos/plugins/etcd.py
  sudo rm -rf /var/lib/etcd
  sudo rm -rf /var/etcd 
EOM

ssh -o 'StrictHostKeyChecking no' -i ${JENKINS_HOME}/secrets/ArktosE2E ubuntu@${PRESET_KUBE_MASTER_IP} "$CMD_CLEAN_DIR" || true
ssh -o 'StrictHostKeyChecking no' -i ${JENKINS_HOME}/secrets/ArktosE2E ubuntu@${PRESET_KUBE_MINION1_IP} "$CMD_CLEAN_DIR" || true

echo "Done clean up"
