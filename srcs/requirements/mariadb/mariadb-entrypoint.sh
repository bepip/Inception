#!/bin/sh
service mariadb start;
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'localhost';"
mysql -e "FLUSH PRIVILEGES;" -u root --password=${SQL_ROOT_PASSWORD}
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown
exec mysqld_safe
