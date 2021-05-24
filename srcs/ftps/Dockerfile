FROM alpine

RUN apk update
RUN apk add openrc
RUN apk add bash
RUN apk add openssl vsftpd --no-cache
RUN apk add vim
RUN apk add telegraf

RUN rm -rf /etc/telegraf.conf
RUN adduser sammy --disabled-password
RUN echo sammy:1234 | chpasswd

COPY openssl.conf /etc/ssl/private/
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY run.sh ./
COPY telegraf.conf /etc/
COPY liveness_check.sh ./

EXPOSE 20 21
CMD bash run.sh
