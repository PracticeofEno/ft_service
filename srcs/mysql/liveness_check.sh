#!/bin/bash
pgrep telegraf
if [ $? -eq 0 ]; then
	echo "telegraf is live"
else
	echo "telegraf is dead"
	exit 1
fi

pgrep mariadbd
if [ $? -eq 0 ]; then
	echo "mariadbd is live"
else
	echo "mariadbd is dead"
	exit 1
fi

