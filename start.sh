#!/bin/sh
exim -bdf -q15m &
rspamd -i -f