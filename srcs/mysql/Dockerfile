FROM alpine:3.12

RUN 	apk add mysql mariadb mariadb-client openrc && \
		apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache && \
		mkdir -p /run/mysqld &&\
		chown -R root:root /run/mysqld

COPY		/srcs/my.cnf		/etc/
COPY		/srcs/wordpress.sql	/
COPY		/srcs/execute.sh		/
COPY 		/srcs/telegraf.conf /etc/telegraf/
COPY    	/srcs/init_file      /


RUN chmod 777 execute.sh

EXPOSE 3306

ENTRYPOINT	sh execute.sh
