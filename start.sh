#!/bin/sh

test x"$RSPAMD_NAMESERVER" != x"" && {
    echo "dns { nameserver = [\"$RSPAMD_NAMESERVER\"]; }" >> /etc/rspamd/local.d/options.inc
}

exim -bdf -q15m &
rspamd -i -f