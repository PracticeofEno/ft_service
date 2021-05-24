#!/bin/bash
pgrep telegraf
if [ $? -eq 0 ]; then
	echo "telegraf is live"
else
	echo "telegraf is dead"
	exit 1
fi

pgrep vsftpd
if [ $? -eq 0 ]; then
	echo "vsftpd is live"
else
	echo "vsftpd is dead"
	exit 1
fi

