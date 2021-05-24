#!/bin/bash
pgrep telegraf
if [ $? -eq 0 ]; then
	echo "telegraf is live"
else
	echo "telegraf is dead"
	exit 1
fi

pgrep nginx
if [ $? -eq 0 ]; then
	echo "nginx is live"
else
	echo "nginx is dead"
	exit 1
fi

pgrep php-fpm7
if [ $? -eq 0 ]; then
	echo "php-fpm7 is live"
else
	echo "php-fpm7 is dead"
	exit 1
fi

