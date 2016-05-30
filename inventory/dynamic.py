#!/usr/bin/env python

import sys
import os.path
import subprocess
import re
from paramiko import SSHConfig
from cStringIO import StringIO
from optparse import OptionParser
from collections import defaultdict
try:
    import json
except:
    import simplejson as json

_group = 'vagrant'  # a default group
_ssh_to_ansible = [('user', 'ansible_ssh_user'),
                   ('hostname', 'ansible_ssh_host'),
                   ('identityfile', 'ansible_ssh_private_key_file'),
                   ('port', 'ansible_ssh_port')]

# Options
# ------------------------------

parser = OptionParser(usage="%prog [options] --list | --host <machine>")
parser.add_option('--list', default=False, dest="list", action="store_true",
                  help="Produce a JSON consumable grouping of Vagrant servers for Ansible")
parser.add_option('--host', default=None, dest="host",
                  help="Generate additional host specific details for given host for Ansible")
(options, args) = parser.parse_args()

#
# helper functions
#


# get all the ssh configs for all boxes in an array of dictionaries.
def get_ssh_config():
    return {k: get_a_ssh_config(k) for k in list_running_boxes()}


# list all the running boxes
def list_running_boxes():
    output = subprocess.check_output(["vagrant", "status"]).split('\n')

    boxes = []

    for line in output:
        matcher = re.search("([^\s]+)[\s]+running \(.+", line)
        if matcher:
            boxes.append(matcher.group(1))

    return boxes


# get the ssh config for a single box
def get_a_ssh_config(box_name):
    """Gives back a map of all the machine's ssh configurations"""

    output = subprocess.check_output(["vagrant", "ssh-config", box_name])
    config = SSHConfig()
    config.parse(StringIO(output))
    host_config = config.lookup(box_name)

    # man 5 ssh_config:
    # > It is possible to have multiple identity files ...
    # > all these identities will be tried in sequence.
    for id in host_config['identityfile']:
        if os.path.isfile(id):
            host_config['identityfile'] = id

    return {v: host_config[k] for k, v in _ssh_to_ansible}

# List out servers that vagrant has running
# ------------------------------
if options.list:
    ssh_config = get_ssh_config()
    meta = defaultdict(dict)

    for host in ssh_config:
        meta['hostvars'][host] = ssh_config[host]

    print(json.dumps({_group: list(ssh_config.keys()), '_meta': meta}))
    sys.exit(0)

# Get out the host details
# ------------------------------
elif options.host:
    print(json.dumps(get_a_ssh_config(options.host)))
    sys.exit(0)

# Print out help
# ------------------------------
else:
    parser.print_help()
    sys.exit(0)
