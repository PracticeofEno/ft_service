#!/bin/sh
openrc
touch /run/openrc/softlevel
rc-service telegraf start
grafana-server --homepath /usr/share/grafana/
tail -f /dev/null
