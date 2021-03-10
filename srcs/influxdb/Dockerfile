FROM alpine:3.12

RUN apk update && apk add openrc --no-cache && \
	apk add influxdb && \
    apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache && \
    openrc && touch /run/openrc/softlevel && \
    rc-update add telegraf

COPY	/srcs/execute.sh				/
COPY	/srcs/telegraf.conf			/etc/

EXPOSE	8086

ENTRYPOINT sh execute.sh