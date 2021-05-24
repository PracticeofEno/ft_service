#!/bin/bash
pgrep telegraf
if [ $? -eq 0 ]; then
	echo "telegraf is live"
else
	echo "telegraf is dead"
	exit 1
fi

pgrep grafana-server
if [ $? -eq 0 ]; then
	echo "grafana-server is live"
else
	echo "grafana-server is dead"
	exit 1
fi

