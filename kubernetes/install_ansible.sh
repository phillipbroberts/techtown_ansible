#!/bin/sh

echo "Installing EPEL repository"
sudo yum --quiet --assumeyes  install epel-release

echo "Installing Ansible"
sudo yum --quiet --assumeyes  install ansible python-netaddr
sudo rm -rf /etc/ansible/*
