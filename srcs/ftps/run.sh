#!/bin/bash
chown -R sammy /home/sammy
#openrc bug fix
openrc
touch /run/openrc/softlevel

#ssl create and move
openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Busan/L=Busan/O=AA/OU=BB/CN=localhost" -keyout localhost.dev.key -out localhost.dev.crt
mv localhost.dev.key etc/ssl/private/
mv localhost.dev.crt etc/ssl/certs/
chmod 600 etc/ssl/private/localhost.dev.key etc/ssl/certs/localhost.dev.crt

rc-update add vsftpd default
rc-service vsftpd start
rc-service telegraf start

tail -f /dev/null
