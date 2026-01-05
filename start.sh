#!/bin/sh
exim -bdf -q15m &
/usr/bin/rspamd -i -f
