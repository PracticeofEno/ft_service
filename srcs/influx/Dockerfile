FROM alpine

RUN apk update
RUN apk add influxdb
RUN apk add openrc
RUN apk add telegraf
RUN apk add bash
RUN rm -rf /etc/telegraf.conf
RUN rm -rf /etc/influxdb.conf

COPY ./run.sh ./
COPY ./telegraf.conf ./etc/
COPY ./influxdb.conf ./etc/
COPY ./liveness_check.sh ./


CMD bash run.sh
