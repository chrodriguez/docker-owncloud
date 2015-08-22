#!/bin/bash
set -e

source /etc/apache2/envvars

#sed -i 's@DocumentRoot /var/www/html$@DocumentRoot /var/www/owncloud@' /etc/apache2/sites-available/000-default.conf 

DIR=/etc/owncloud
DATA=/var/www/owncloud/data/

# Map www-data uid to specified USER_ID. If no specified, uid 33 will be used
if [ ! -z "$USER_ID" ]; then
  usermod -u $USER_ID $APACHE_RUN_USER
fi

if [ ! "$(ls -A $DIR)" ]; then
  chown $APACHE_RUN_USER $DIR $DATA
  cp -p /var/www/owncloud/config/.htaccess $DIR
  cp -pr /var/www/owncloud/config/* $DIR
fi

[ -L /var/www/owncloud/config] || ( rm -fr /var/www/owncloud/config && ln -s $DIR /var/www/owncloud/config )

apache2 -DFOREGROUND
