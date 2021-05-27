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

COPY ./grafana.json ./usr/share/grafana/public/dashboards
COPY ./nginx.json ./usr/share/grafana/public/dashboards
COPY ./phpmyadmin.json ./usr/share/grafana/public/dashboards
COPY ./wordpress.json ./usr/share/grafana/public/dashboards
COPY ./mysql.json ./usr/share/grafana/public/dashboards
COPY ./influx.json ./usr/share/grafana/public/dashboards
COPY ./ftps.json ./usr/share/grafana/public/dashboards

COPY ./grafana2.yaml ./usr/share/grafana/conf/provisioning/dashboards/
COPY ./nginx.yaml ./usr/share/grafana/conf/provisioning/dashboards/
COPY ./phpmyadmin.yaml ./usr/share/grafana/conf/provisioning/dashboards/
COPY ./wordpress.yaml ./usr/share/grafana/conf/provisioning/dashboards/
COPY ./mysql.yaml ./usr/share/grafana/conf/provisioning/dashboards/
COPY ./influx.yaml ./usr/share/grafana/conf/provisioning/dashboards/
COPY ./ftps.yaml ./usr/share/grafana/conf/provisioning/dashboards/

COPY ./datasource.yaml ./usr/share/grafana/conf/provisioning/datasources/

CMD bash run.sh
