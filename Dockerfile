FROM gliderlabs/alpine:3.1
RUN apk-install mysql-client
RUN apk-install git
CMD tail -f /dev/null