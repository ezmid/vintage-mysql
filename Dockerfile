FROM alpine:3.10

ENV S6_OVERLAY_VERSION=v1.22.1.0

RUN apk --no-cache --update upgrade && \
    apk add curl && \
        curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz \
        | tar xfz - -C / && \
        apk del curl

RUN apk add bash mariadb mariadb-client

RUN \
    # Create needed directories
    mkdir -p /var/lib/mysql && \
    mkdir -p /run/mysqld && \
    mkdir /etc/mysql/conf.d && \
    \
    # Set permissions
    chown -R mysql:mysql /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld && \
    rm -rf /var/cache/apk/*

ADD docker/02-patch-fs /

RUN chmod -R o+x /etc/s6/services/01-mysql/*

VOLUME [ "/run" ]
ENTRYPOINT ["/init"]
CMD []
