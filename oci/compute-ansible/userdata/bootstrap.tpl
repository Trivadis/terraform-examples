#!/bin/bash
sudo su
echo 'This instance was provisioned by Terraform.' | tee /etc/motd
sleep 20
yum -y install ansible git python
groupadd -r ansible
useradd -m -s /bin/bash -g ansible ansible
echo 'ansible ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo