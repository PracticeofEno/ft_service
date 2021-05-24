FROM alpine

RUN apk update
RUN apk add grafana
RUN apk add telegraf
RUN apk add openrc
RUN apk add bash
RUN rm -rf /etc/telegraf.conf

COPY ./run.sh ./
COPY ./telegraf.conf ./etc/
COPY ./liveness_check.sh ./
#COPY ./defaults.ini ./etc/grafana.ini
COPY ./dashboard.json ./usr/share/grafana/public/dashboards
COPY ./dashboard.yaml ./usr/share/grafana/conf/provisioning/dashboards/
COPY ./datasource.yaml ./usr/share/grafana/conf/provisioning/datasources/

CMD bash run.sh
