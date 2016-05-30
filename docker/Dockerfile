FROM ansible/ubuntu14.04-ansible
MAINTAINER Mitchell Smith <mitchinseattle2014@gmail.com>

ADD dokuwiki_ansible /srv/dokuwiki_ansible
WORKDIR /srv/dokuwiki_ansible
RUN ansible-playbook dokuwiki.yml -c local

EXPOSE 80

CMD /run.sh

