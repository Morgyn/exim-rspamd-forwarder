#!/bin/sh

if [ -z "${RSPAMD_NAMESERVER}" ]; then
    echo "dns { nameserver = [\"${RSPAMD_NAMESERVER}\"]; }" >> /etc/rspamd/local.d/options.inc
fi

exim -bdf -q15m &
rspamd -i -f