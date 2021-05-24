#!/bin/bash
pgrep telegraf
if [ $? -eq 0 ]; then
	echo "telegraf is live"
else
	echo "telegraf is dead"
	exit 1
fi

pgrep influxd
if [ $? -eq 0 ]; then
	echo "influxd is live"
else
	echo "influxd is dead"
	exit 1
fi

