#!/bin/sh

openrc
touch /run/openrc/softlevel
rc-service influxdb start
sleep 3
influx -execute "create database teledb;create user tele with password 'tele';grant all on teledb to tele"
influx -execute "create user admin with password 'admin123' with all privileges"
rc-service telegraf start
tail -f /dev/null
