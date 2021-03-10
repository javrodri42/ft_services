FROM alpine:3.12

RUN	apk add grafana --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache && \
        apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache

COPY	/srcs/grafana.db			/usr/share/grafana/data/
COPY	/srcs/execute.sh				/
COPY	/srcs/telegraf.conf			/etc/telegraf/

WORKDIR	/usr/share/grafana

EXPOSE	3000

ENTRYPOINT	sh /execute.sh