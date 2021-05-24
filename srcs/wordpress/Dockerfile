FROM	alpine

RUN	apk update && apk upgrade
RUN	apk add nginx
RUN	apk add bash
RUN	apk add php7 php7-fpm php7-opcache
RUN	apk add php7-gd php7-mysqli php7-zlib php7-curl
RUN	apk add php-json php7-session php-mbstring
RUN	apk add openrc
RUN	apk add telegraf
RUN	mkdir /run/nginx;
RUN	apk add wget
RUN	wget https://wordpress.org/latest.tar.gz
RUN	rm -rf /etc/telegraf.conf

COPY	./default.conf ./
COPY	./index.php	./
COPY	./run.sh	./
COPY	./wp-config.php ./
COPY	./telegraf.conf /etc/
COPY	./liveness_check.sh ./

RUN ["chmod", "+x", "/run.sh"]

EXPOSE 80

ENTRYPOINT ["/run.sh"]
