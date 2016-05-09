# Techtown Ansible Course

## Required software

You will need to download and install the following software:

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads.html)
- [Git if you are on Windows](https://git-scm.com/download/win)

## Clone this repository

To download the example code used throughout the course, clone this repository:

```
git clone https://github.com/mjsprojects/techtown_ansible.git
```

## Set up a control host

Start the virtual machine

```
cd control
vagrant up
vagrant ssh
```


Add the package repository

```
sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
```

Test that Ansible is installed successfully

```
ansible --version
```

Terminate vagrant VM upon completion

```
vagrant destroy
```

