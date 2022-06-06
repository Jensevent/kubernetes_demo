# Create Ubuntu Desktop VM
## Install VMware
Download the VMware Workstation 16 Pro from [here](https://www.vmware.com/products/workstation-pro/workstation-pro-evaluation.html). A public key for this is:
```
ZF3R0-FHED2-M80TY-8QYGC-NPKYF
```
>Source: https://gist.github.com/williamgh2019/cc2ad94cc18cb930a0aab42ed8d39e6f

## Create Ubuntu Desktop VM

Get the *.iso* file from [here](https://ubuntu.com/download/desktop).
Create a VM with (preferably):
- 4 GB RAM
- 2 Processors (1 per core)
- 20 GB disk
- Network Adaptor NAT

## Networking
**IF** you cant connect to the internet, you can change the netplan file:
```bash
sudo nano /etc/netplan/01-network-manager-all.yaml
```
Change the text to:
```yaml                       
# Let NetworkManager manage all devices on this system
network:
  version: 2
  ethernets:
    ens33:
      nameservers:
        addresses: [8.8.8.8]
      dhcp4: true
  renderer: NetworkManager
```
**USE SPACES FOR INDENTS, NOT TABS**

Save using *Ctrl + S* and exit using *Ctrl + X*.
Next, test and apply the testplan.
```bash
#attempt to use the new netplan
netplan try

#if the try doesnt give any errors, apply the new config
netplan apply
```
>Source: https://linuxconfig.org/how-to-configure-static-ip-address-on-ubuntu-18-04-bionic-beaver-linux

# Install Docker

```bash
#update all packages
sudo apt update

#install neccessary packages
sudo apt install apt-transport-https ca-certificates curl software-properties-common

#add key for the official docker repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#add the repo to the APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

#install docker
sudo apt install docker-ce

#validate if its installed
sudo systemctl status docker

#(optional) if you want to run docker without sudo
sudo usermod -aG docker ${USER}
```
>Source: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04


# Install kubectl

```bash
#download the latest release
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

#install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

#validate if its installed
kubectl version --client
```
>Source: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

# Install Kind
```bash
#download the latest release
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.14.0/kind-linux-amd64

#make the kind file executable
chmod +x ./kind

#move kind to PATH
sudo mv ./kind /usr/local/bin/kind
```
>Source: https://kind.sigs.k8s.io/docs/user/quick-start#installation

# Create Full demo
```
#clone repo
git clone https://github.com/Jensevent/kubernetes_demo.git

#go into the folder
cd kubernetes-demo

#make the startup.sh file runnable
chmod +x ./startup.sh

#run the script
./startup.sh
```
