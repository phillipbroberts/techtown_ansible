#!/bin/bash

echo "Updating apt package index"
sudo apt-get -qq update

echo "Installing software-properties-common"
sudo apt-get -qqy install software-properties-common

echo "Adding ansible package repository"
sudo add-apt-repository -y ppa:ansible/ansible

echo "Updating apt package index"
sudo apt-get -qq update

echo "Installing ansible"
sudo apt-get -qqy install ansible

echo "Installing pip"
sudo apt-get -qqy install python-pip

echo "Installing digital ocean python module dopy"
sudo pip install 'dopy>=0.3.5,<=0.3.5'
