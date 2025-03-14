#!/bin/sh
set -e

# Start MariaDB service
service mariadb start

# Wait for MariaDB to be ready

# Initialize the database if it hasn't been initialized yet
if [ ! -d "/var/lib/mysql/${SQL_DATABASE}" ]; then
	mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
	mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
	mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
	mysql -e "FLUSH PRIVILEGES;" -u root --password=${SQL_ROOT_PASSWORD}
fi

# Shutdown MariaDB
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# Start MariaDB in safe mode
exec mysqld_safe
