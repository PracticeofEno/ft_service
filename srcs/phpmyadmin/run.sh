#!/bin/bash
adduser -D -g 'www' www
mkdir /www
chown -R www:www /var/lib/nginx
chown -R www:www /www

openrc
touch /run/openrc/softlevel
mv default.conf /etc/nginx/nginx.conf
mv index.php /www/
tar -xvf phpMyAdmin-5.0.2-all-languages.tar.gz
mv phpMyAdmin-5.0.2-all-languages phpmyadmin
mv phpmyadmin /www/
rm phpMyAdmin-5.0.2-all-languages.tar.gz
mv ./config.inc.php /www/phpmyadmin/
rc-update add nginx default
rc-update add php-fpm7 default
rc-service php-fpm7 restart
rc-service telegraf start
rc-service nginx start

tail -f /dev/null
