FROM alpine:3.12.3

RUN apk update && apk add nginx && apk add wget
RUN apk add openrc && rc-update add nginx default
RUN rc-status && touch/openrc/softlevel


