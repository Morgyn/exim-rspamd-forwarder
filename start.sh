#!/bin/sh
exim -bdf -q15m &
/usr/sbin/rspamd -i -f
