FROM alpine:3.8

MAINTAINER Filip Cieker "filip.cieker@ezmid.com"
LABEL maintainer="Filip Cieker filip.cieker@ezmid.com"

################################################################################
# Quick edit versions
ARG S6_OVERLAY_VERSION=1.21.7.0

################################################################################
# Layer 1 - Init file system
COPY ./docker/01-init-fs /

################################################################################
# Layer 2 - ADD s6 overlay
RUN apk add --no-cache curl \
	&& curl -L -s https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-amd64.tar.gz \
	| tar xvzf - -C /

################################################################################
# Layer 3 - Add MySQL
RUN apk --no-cache --update add \
	mysql \
	mysql-client \
	bash \
	tzdata && \
    addgroup mysql mysql && \
    rm -rf /var/cache/apk/*

################################################################################
# Layer 4 - Path the filesystem with MySQL configuration
COPY ./docker/02-patch-fs /


################################################################################
# Init the system
VOLUME ["/var/lib/mysql"]
EXPOSE 3306
CMD ["/init"]
