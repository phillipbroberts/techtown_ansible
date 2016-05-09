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
| ansible.cfg | configuraiton defaults for ansible |
| development.ini | inventory file for your development environment |
| production.ini | inventory file for your production environment |
| staging.ini | inventory file for your staging environment |
| requirements.yml | third party roles from ansible galaxy |
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
ansible-playbook -i development.ini playbooks/webservers.yml
```

or

```
ansible-playbook -i staging playbooks/site.yml
```


You can also run one off commands like:

```
ansible postgres000.dev.example.com -i development.ini -m command -a "uptime"
```

