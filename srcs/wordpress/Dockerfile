FROM alpine:3.12

RUN apk update 
RUN  apk add lighttpd php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom
   # nginx                                   \
   # mariadb-server                          \
   # php7-fpm                                \
   # php7-mysqli                             \
   # php-mbstring                            \
   # && rm -rf /var/lib/apt/lists/*
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    mv wordpress /var/www/html/ && \
    rm -rf latest.tar.gz
COPY /srcs/wp-config.php /var/www/html/wordpress

EXPOSE 5050

CMD php -s 0.0.0.0:5050 -t /www/
