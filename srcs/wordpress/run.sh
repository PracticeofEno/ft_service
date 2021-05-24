#!/bin/bash
adduser -D -g 'www' www
mkdir /www
chown -R www:www /var/lib/nginx
chown -R www:www www

openrc
touch /run/openrc/softlevel
mv default.conf /etc/nginx/nginx.conf
mv index.php /www/
tar -xvf latest.tar.gz
mv wordpress /www/
mv wp-config.php /www/wordpress/
rc-service telegraf start
rc-service php-fpm7 start
rc-service nginx start

tail -f /dev/null
#bash
