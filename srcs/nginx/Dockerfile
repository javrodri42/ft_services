FROM alpine

RUN apk update                     
RUN apk add nginx openssh openssl   
RUN mkdir -p /run/nginx
RUN openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 -subj "/C=SP/ST=Spain/L=Madrid/O=42/CN=localhost"\
    -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx.crt
RUN openssl dhparam -dsaparam -out /etc/ssl/certs/dhparam.pem 2048

#RUN apt-get update && apt-get install -y \
 #    nginx


COPY srcs/nginx.conf  /etc/nginx
COPY srcs/ssl_params.conf  /etc/nginx
COPY srcs/index.html  /var/www

EXPOSE 80 443 22

CMD nginx -g 'daemon off;'