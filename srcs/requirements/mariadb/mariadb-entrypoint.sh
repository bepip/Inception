#!/bin/sh
set -e

if [ ! -f /var/lib/mysql/.initialized ]; then
	/usr/local/bin/mariadb-config.sh
fi

exec mysqld_safe
