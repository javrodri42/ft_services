FROM alpine

RUN apk update && apk add nginx && mkdir -p /run/nginx
#RUN apt-get update && apt-get install -y \
 #    nginx


COPY srcs/nginx.conf  /etc/nginx
COPY srcs/index.html  /var/www

EXPOSE 80 22 443

CMD nginx -g 'daemon off;'