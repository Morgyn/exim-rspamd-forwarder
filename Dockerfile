FROM docker.io/alpine:3.15.0

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
    ln -sf /dev/stdout /var/log/rspamd/rspamd.log

COPY exim.conf /etc/exim/exim.conf
COPY start.sh /start.sh

# Regardless of the permissions of the original `exim.conf` file in the build context,
# ensure that the `/etc/exim/exim.conf` configuration file is not writable by the Exim user.
# Otherwise, we'll get an Exim panic:
# > Exim configuration file /etc/exim/exim.conf has the wrong owner, group, or mode
RUN chmod 664 /etc/exim/exim.conf
RUN chmod 755 /start.sh

USER exim
EXPOSE 25

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/start.sh"]
