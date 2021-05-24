#!/bin/bash

adduser -D -g 'www' www
mkdir /www
chown -R www:www /var/lib/nginx
chown -R www:www /www

openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Busan/L=Busan/O=42Seoul/OU=Park/CN=localhost" -keyout localhost.dev.key -out localhost.dev.crt
mv localhost.dev.key etc/ssl/private/
mv localhost.dev.crt etc/ssl/certs/
chmod 600 etc/ssl/private/localhost.dev.key etc/ssl/certs/localhost.dev.crt
rm -rf /etc/nginx/nginx.conf
mv ./default /etc/nginx/nginx.conf
mv ./index.html /www/index.html

#error fix
openrc
touch /run/openrc/softlevel
rc-service nginx start
rc-service telegraf start
/usr/sbin/sshd -D
