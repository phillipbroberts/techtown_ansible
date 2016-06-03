#!/bin/bash

echo "Updating apt package index"
apt-get -qq update
echo "Upgrading base system"
apt-get -qqy dist-upgrade
echo "Installing LXC"
cp /vagrant/conf/lxc-net /etc/default/
apt-get -qqy install lxc lxc-templates lxctl debootstrap
echo "Installing git"
apt-get -qqy install git
echo "Installing Java"
apt-get -qqy install default-jre-headless openjdk-8-jre-headless
echo "Installing Jenkins"
wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
cp /vagrant/conf/jenkins.list /etc/apt/sources.list.d/
apt-get -qq update
apt-get -qqy install jenkins
echo "Adding jenkins to sudo group"
adduser jenkins sudo
cp /vagrant/conf/sudoers /etc/sudoers
chmod 440 /etc/sudoers
chown root:root /etc/sudoers
echo "Copying lxc helper scripts for jenkins"
cp /vagrant/scripts/* /usr/local/bin
chmod 755 /usr/local/bin/build_base_containers /usr/local/bin/spinup_lxc /usr/local/bin/run_lxc /usr/local/bin/teardown_lxc
/usr/local/bin/build_base_containers
echo "Cleaning up"
apt-get clean

echo "*** IMPORTANT *** IMPORTANT *** IMPORTANT ***"
echo -n "Jenkins has created a random password you will need to login for the first time: "
cat /var/lib/jenkins/secrets/initialAdminPassword 
echo "*** IMPORTANT *** IMPORTANT *** IMPORTANT ***"
