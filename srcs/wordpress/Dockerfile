FROM alpine:3.12
  
RUN apk --no-cache add php7 php7-mysqli php7-json php7-mbstring php7-fpm php7-opcache nginx &&\
    apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache

RUN adduser -D -g 'www' www && mkdir -p /run/nginx www &&\
	 chown -R www:www /var/lib/nginx &&\
	 chown -R www:www /www

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    mv /wordpress /www && \
    rm -rf latest.tar.gz

COPY /srcs/wp-config.php /www/
COPY /srcs/nginx.conf /etc/nginx/nginx.conf
COPY /srcs/telegraf.conf			/etc/telegraf/


COPY /srcs/execute.sh ./

EXPOSE 5050

ENTRYPOINT sh execute.sh

