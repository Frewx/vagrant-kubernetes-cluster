# vagrant-kubernetes-cluster

Kubernetes cluster automation via Vagrant

# Prerequisites

To create VMs with vagrant, you need to install:
- Vagrant (This project is tested on Vagrant 2.2.7)
- Virtualbox (This project is tested on Virtualbox 6.1.28)

# Usage

To create VMs and bootstrap your kubernetes cluster

`vagrant up`

After creation of VMs is complete ssh into master and check kubernetes cluster status

`vagrant ssh master`

`kubectl get nodes`

To check your kubernetes cluster, you can create an nginx deployment and expose it (from port 30080) with

`kubectl apply -f /vagrant/nginx-deployment.yml && kubectl apply -f /vagrant/nginx-service.yml`

After deployment you can check your page with 

`curl http://<worker-ip>:30080`
