#!/bin/bash

openrc
touch /run/openrc/softlevel
mysql_install_db --user=root
rc-service telegraf start
rc-service mariadb start
sleep 2
mysql < /mysql-init
mysql wordpress < /wordpress.sql

tail -f /dev/null




