#!/bin/sh

echo "Installing EPEL repository"
sudo yum --quiet --assumeyes  install epel-release

echo "Installing Ansible"
sudo yum --quiet --assumeyes  install ansible
sudo rm -rf /etc/ansible/*

echo "Installing SSH private key"
cp /vagrant/.private_key /home/vagrant/.ssh/id_rsa
chmod 600 /home/vagrant/.ssh/id_rsa
