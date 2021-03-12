FROM	alpine:3.12

RUN		apk update &&\
		apk add openssl &&\
		apk add vsftpd &&\
		rm -rf /var/cache/apk/* &&\
		apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache

#FTPS conf
RUN		echo -e "user\nuser" | adduser user -h /ftps_user;
RUN		chown user:user /ftps_user
RUN		touch /var/log/vsftpd.log
RUN		echo "user" >> /etc/vsftpd/vsftpd.userlist

#SSL
RUN		openssl req -x509 -out /etc/ssl/certs/vsftpd.crt -keyout /etc/ssl/private/vsftpd.key -newkey rsa:2048 -nodes -sha256 -subj '/CN=localhost'

COPY	/srcs/telegraf.conf			/etc/telegraf/
COPY	/srcs/execute.sh				/

EXPOSE 21 31000

ENTRYPOINT sh execute.sh