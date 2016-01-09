#!/bin/bash
cp /opt/etc/nginx.conf /etc/nginx/nginx.conf

sed -i "s#%web_root%#$WEB_ROOT#" /etc/nginx/sites-available/vhost

until ping -c 1 fpm
do
  echo "trying to connect with php fpm"
  sleep 1
done

exec /usr/sbin/nginx
