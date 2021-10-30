#!/bin/bash -e

master_node=172.16.8.10
pod_network_cidr=192.168.0.0/16

initialize_master_node ()
{
sudo systemctl enable kubelet
sudo kubeadm config images pull
sudo kubeadm init --apiserver-advertise-address=$master_node --pod-network-cidr=$pod_network_cidr --ignore-preflight-errors=NumCPU
}

create_join_command ()
{
kubeadm token create --print-join-command | tee /vagrant/join_command.sh
chmod +x /vagrant/join_command.sh
}

configure_kubectl () 
{
mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

##For vagrant user
mkdir -p /home/vagrant/.kube
sudo cp -f /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chown 900:900 /home/vagrant/.kube/config
}

install_network_cni ()
{
kubectl apply -f /vagrant/kube-flannel.yml
}

initialize_master_node
configure_kubectl
install_network_cni
create_join_command