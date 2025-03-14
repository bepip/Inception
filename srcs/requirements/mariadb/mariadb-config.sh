#!/bin/sh
#service mariadb start;
#mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
#mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
#mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
#mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
#mysql -e "FLUSH PRIVILEGES;" -u root --password=${SQL_ROOT_PASSWORD}
#mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown
#exec mysqld_safe
set -e

# Start MariaDB temporarily for setup
service mariadb start

# Check if the database has already been initialized
if [ ! -d "/var/lib/mysql/${SQL_DATABASE}" ]; then
    echo "Initializing database and users..."

    # Create database
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

    # Create user and grant privileges
    mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"

    # Set root password
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

    # Flush privileges
    mysql -e "FLUSH PRIVILEGES;"

    echo "Database and users initialized successfully."
else
    echo "Database already initialized. Skipping setup."
fi

# Shut down MariaDB after setup
mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown
