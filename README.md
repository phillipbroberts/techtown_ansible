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


## More complex example using a role

Our next example is a server running rocket.chat, a software package aimed at providing an in-house service similar to Slack.

This example moves most of the task execution out of the main playbook and in to a role.

```
cd rocket-chat
cat playbook.yml
```

You will see our main playbook is extremely basic, and all the logic has moved in to our rocketchat role, have a look through the various tasks in roles/rocketchat/tasks starting with main.yml to get a feel for how this role sets up the rocketchat stack.

Bring the virtual machine up and make sure the service gets installed successfully by opening a browser to http://localhost:3000/

## Recommended directory structure

Using the [Ansible best practises](http://docs.ansible.com/ansible/playbooks_best_practices.html) page as a guide, I would recommend the following directory structure for your Ansible project.

| Location | Description |
| --- | --- |
| ansible.cfg | configuration defaults for ansible |
| requirements.yml | third party roles from ansible galaxy |
| inventory/ | directory containing your inventory definitions |
| inventory/development | inventory file for your development environment |
| inventory/staging | inventory file for your staging environment |
| inventory/production | inventory file for your production environment |
| group_vars/ | group variable definitions |
| group_vars/all/ | apply to all hosts |
| group_vars/webserver/ | apply to hosts in the webserver group |
| playbooks/ | playbooks directory |
| roles/ | directory containing your roles |
| roles/internal/ | any internally developed roles |
| roles/external/ | any external roles downloaded from ansible galaxy |
| scripts/ | any internal utility scripts like the example to update external roles |

Using this suggested directory structure should give you a good amount of flexibility.

You can update all external roles from ansible galaxy using the ./scripts/update_external_roles.sh  script, just make sure it is defined in requirements.yml first.

You can apply your playbooks to specific environments using a command like:

```
ansible-playbook -i inventory/development playbooks/webservers.yml
```

or

```
ansible-playbook -i inventory/staging playbooks/main.yml
```


You can also run one off commands like:

```
ansible postgres000.dev.example.com -i inventory/development -m command -a "uptime"
```

## WordPress Example

In the wordpress-nginx folder you will find a more complete example of a deployment using multiple roles and group variables.

The site.yml is intentionally minimal, all logic has been moved out to roles, and those roles are configured using the group_vars/all file.

## Docker

The Docker folder contains an example of configuring an instance for hosting docker containers, Ansible has very good support for building and managing Docker containers, the documentation for the Docker module can be found at http://docs.ansible.com/ansible/docker_module.html

## Dynamic inventory


The dynamic folder of the repo provides a Vagrant config that will start four virtual machines, we then use the dynamic inventory script found in inventory/dynamic.py to interact with that inventory and perform tasks on it.

You will need the paramiko module to use this inventory script.

```
pip install paramiko
```

use 'vagrant up' to start the machines and 'vagrant status' to make sure they are all running.

A dynamic inventory script should provide a list of all hosts given the *--list* argument and should provide details about a single host given the *--host=hostname* argument.

Once the vagrant instances have started try the following commands to see an example:

```
python inventory/dynamic.py --list
```

```
python inventory/dynamic.py --host=db1
```

Let's first try and get a ping reply from all VMs in our inventory.

```
ansible all -i inventory -m ping
```


we can dumpout all the setup facts gathered from a specific instance

```
ansible web1 -i inventory -m setup
```

Our dynamic  inventory script only knows how to query vagrant for vm information, additional inventory examples can be found in the Ansible repository https://github.com/ansible/ansible/tree/devel/contrib/inventory

