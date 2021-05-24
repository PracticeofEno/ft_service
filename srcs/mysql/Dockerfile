FROM	alpine
RUN	apk update && apk upgrade
RUN	apk add openrc
RUN	apk add mysql
RUN	apk add mysql-client
RUN	apk add bash
RUN	mkdir -p /run/mysqld
RUN	apk add telegraf
RUN	rm -rf /etc/telegraf.conf

ENV	MYSQL_USER admin
ENV	MYSQL_ROOT_PASSWORD 1234

COPY	./run.sh ./
COPY	./my.cnf /etc/mysql/
COPY	./mysql-init ./
COPY	./telegraf.conf /etc/
COPY	./liveness_check.sh ./
COPY	./wordpress.sql ./

EXPOSE 	3306

ENTRYPOINT	["sh", "./run.sh"]
