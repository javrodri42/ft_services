FROM alpine

RUN apk update                     && \
    apk add nginx openssh openssl   && \
    mkdir -p /run/nginx 
#RUN apt-get update && apt-get install -y \
 #    nginx


COPY srcs/nginx.conf  /etc/nginx
COPY srcs/ssl_params.conf  /etc/nginx
COPY srcs/index.html  /var/www

EXPOSE 80 443 22

CMD nginx -g 'daemon off;'