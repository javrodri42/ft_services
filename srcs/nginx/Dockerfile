FROM alpine:3.12

RUN apk update && apk add nginx &&\
	apk add openssl openssh && mkdir -p var/run/nginx &&\
	apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache && \
	apk add --no-cache --upgrade bash
RUN mkdir -p var/www/


RUN mkdir /etc/nginx/ssl && \
openssl req -x509 -nodes -days 365 \
		-newkey rsa:2048 -subj "/C=SP/ST=Spain/L=Madrid/O=42/CN=127.0.0.1" \
		-keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt && \
		openssl dhparam -dsaparam -out /etc/ssl/certs/dhparam.pem 2048

RUN rm /etc/nginx/nginx.conf

RUN		ssh-keygen -A

COPY srcs/nginx.conf         /etc/nginx/
COPY srcs/index.html		/var/www/index.html
COPY srcs/ssl_params.conf		/etc/nginx/
COPY srcs/execute.sh			/
COPY srcs/telegraf.conf			/etc/telegraf/

EXPOSE 80 443 

ENTRYPOINT	sh execute.sh