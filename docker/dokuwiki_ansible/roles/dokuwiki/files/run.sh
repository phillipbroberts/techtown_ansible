#!/bin/sh

if [ ! -f /srv/dokuwiki/conf/dokuwiki.php ]; then
  echo "populating conf volume"
  mkdir /srv/dokuwiki/conf
  cp -R /srv/dokuwiki/conf.dist/* /srv/dokuwiki/conf/
fi

if [ ! -d /srv/dokuwiki/data/pages ]; then
  echo "populating data volume"
  mkdir /srv/dokuwiki/data
  cp -R /srv/dokuwiki/data.dist/* /srv/dokuwiki/data/
fi

if [ -f /srv/dokuwiki/conf/local.php ]; then
  echo "dokuwiki appears to be configured, removing install.php for security"
  rm -f /srv/dokuwiki/install.php
fi
chown -R www-data:www-data /srv/dokuwiki

exec /usr/bin/supervisord -c /etc/supervisord.conf
