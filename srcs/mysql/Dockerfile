FROM alpine:3.12

RUN 	apk add mysql mariadb mariadb-client openrc && \
	mkdir -p /run/mysqld &&\
	chown -R root:root /run/mysqld

COPY		/srcs/my.cnf		/etc/
COPY		/srcs/wordpress.sql	/
COPY		/srcs/start.sh		/
COPY    	/srcs/init_file      /


RUN chmod 777 start.sh

EXPOSE 3306

ENTRYPOINT	sh execute.sh
