FROM  alpine:3.12

RUN apk add --no-cache phpmyadmin nginx php7 php7-mysqli php7-json php7-mbstring php7-fpm php7-opcache &&\
    apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache

RUN adduser -D -g 'www' www && mkdir -p /run/nginx www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /www

RUN         mv /usr/share/webapps/phpmyadmin /www/
RUN         mkdir  -p  /etc/phpmyadmin/tmp \
            && chmod 777 /etc/phpmyadmin/tmp

RUN         mkdir  -p  /www/phpmyadmin/tmp \
            && chmod 777 /www/phpmyadmin/tmp

COPY 		/srcs/telegraf.conf /etc/telegraf/
COPY 	    /srcs/nginx.conf /etc/nginx/nginx.conf
COPY        /srcs/config.inc.php /etc/phpmyadmin/config.inc.php
COPY        /srcs/execute.sh ./

EXPOSE		5000

ENTRYPOINT  sh execute.sh
