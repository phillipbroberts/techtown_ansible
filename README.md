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


## Second example - hello world

In our second example we are using the [ansible provisioner](https://www.vagrantup.com/docs/provisioning/ansible.html) in Vagrant to run our playbook.

```
cd hello-world
cat Vagrantfile
cat playbook.yml
```

Take note of the *name* descriptions above each task, you will see that is what Ansible will output when runnign our playbook, so it is good to be as descriptive as possible.

Bring our Vagrant VM up and let Ansible provision our NodeJS test app stored in the app directory of our project.

```
vagrant up
```

Once completed you can test that we are getting *hello world* by hitting port 8080

```
curl http://localhost:8080
```

