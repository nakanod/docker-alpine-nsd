FROM alpine:3.6

ENV NSD_VERSION '4.1.16'

RUN apk add --update --no-cache gcc make linux-headers musl-dev libressl-dev curl && \
    cd /tmp && \
    curl -O https://www.nlnetlabs.nl/downloads/nsd/nsd-${NSD_VERSION}.tar.gz && \
    tar zxf nsd-${NSD_VERSION}.tar.gz && \
    cd nsd-${NSD_VERSION} && \
    LDFLAGS='-static' ./configure --without-libevent && make && make install && \
    apk del gcc make linux-headers musl-dev libressl-dev curl && \
    rm -fr /tmp/* /var/cache/apk/* /usr/local/sbin/nsd-* && \
    adduser -h /home/nsd -s /sbin/nologin -D -H nsd && \
    mkdir /etc/nsd/conf.d /etc/nsd/zone && \
    chown nsd:nsd /var/run /var/db/nsd /etc/nsd/conf.d /etc/nsd/zone

COPY /nsd.conf /etc/nsd/nsd.conf

EXPOSE 53/udp 53/tcp

CMD ["/usr/local/sbin/nsd", "-d"]
