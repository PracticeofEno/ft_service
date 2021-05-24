FROM	alpine

RUN	apk update && apk upgrade
RUN	apk add bash
RUN	apk add openrc --no-cache
RUN	apk add telegraf
RUN	apk add nginx
RUN	apk add openssl
RUN	apk add openssh && sed 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' -i /etc/ssh/sshd_config \
	&& echo 'root:1234' | chpasswd \
	&& ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa \
	&& ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa \
	&& mkdir -p /var/run/sshd
#RUN	apt-get update && apt-get install -y \
#	nginx \
#	openssl \
RUN	rm -rf /etc/telegraf.conf

COPY	./run.sh ./
COPY	./default ./
COPY	./index.html ./
COPY	./telegraf.conf /etc/
COPY	./liveness_check.sh ./

EXPOSE 	80 443 22

CMD	bash run.sh
	
