FROM docker.io/alpine:latest

RUN apk --no-cache add exim tini && \
    mkdir /var/spool/exim && \
    chmod 777 /var/spool/exim && \
    ln -sf /dev/stdout /var/log/exim/mainlog && \
    ln -sf /dev/stderr /var/log/exim/panic && \
    ln -sf /dev/stderr /var/log/exim/reject && \
    chmod 0755 /usr/sbin/exim

RUN apk add --no-cache rspamd && \
    chmod 777 /var/log/rspamd && \
    chmod 777 /var/lib/rspamd && \
    touch /etc/rspamd/local.d/options.inc && \
    chmod 664 /etc/rspamd/local.d/options.inc && \
    ln -sf /dev/stdout /var/log/rspamd/rspamd.log

COPY exim.conf /etc/exim/exim.conf
COPY start.sh /start.sh

RUN chmod 664 /etc/exim/exim.conf && \
    chmod 755 /start.sh

USER exim
EXPOSE 25

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/start.sh"]
