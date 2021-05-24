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

