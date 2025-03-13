#!/bin/sh
set -e

echo "Starting WordPress setup..."
sleep 10

# Check database connectivity
if ! wp db check --path='/var/www/wordpress/' --allow-root; then
    echo "Cannot connect to database. Please check your configuration."
    exit 1
fi

# Create wp-config.php if it doesn't exist
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    echo "Creating wp-config.php..."
    if ! wp config create --allow-root \
                          --dbname="$SQL_DATABASE" \
                          --dbuser="$SQL_USER" \
                          --dbpass="$SQL_PASSWORD" \
                          --dbhost=mariadb:3306 \
                          --path='/var/www/wordpress/'; then
        echo "Failed to create wp-config.php"
        exit 1
    fi
else
    echo "wp-config.php already exists. Content:"
    wc -l /var/www/wordpress/wp-config.php
    cat /var/www/wordpress/wp-config.php
fi

# Install WordPress core if not already installed
if ! wp core is-installed --path='/var/www/wordpress/' --allow-root; then
    echo "Installing WordPress core..."
    if ! wp core install --title="SummeryLeak" \
                         --admin_user="$ADMIN_USER" \
                         --admin_password="$ADMIN_PASSWORD" \
                         --admin_email="$ADMIN_EMAIL" \
                         --skip-email \
                         --path='/var/www/wordpress/' \
                         --allow-root; then
        echo "Failed to install WordPress core"
        exit 1
    fi

    echo "Creating additional user..."
    if ! wp user create "$USER_LOGIN" "$USER_EMAIL" --path='/var/www/wordpress/' --allow-root; then
        echo "Failed to create additional user"
        exit 1
    fi
else
    echo "WordPress is already installed."
fi

echo "WordPress setup completed successfully."
exec php-fpm7.4 -F
#
##!/bin/sh
##set -e
#sleep 10
#
#if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
#	wp config create	--allow-root \
#						--dbname=$SQL_DATABASE \
#						--dbuser=$SQL_USER \
#						--dbpass=$SQL_PASSWORD \
#						--dbhost=mariadb:3306 \
#						--path='/var/www/wordpress/'
#else
#	cat /var/www/wordpress/wp-config.php | wc -l
#	cat /var/www/wordpress/wp-config.php
#fi
#if ! wp core is-installed --path='/var/www/wordpress/' --allow-root; then
#	wp core install \
#		--title="SummeryLeak" \
#		--admin_user=$ADMIN_USER \
#		--admin_password=$ADMIN_PASSWORD \
#		--admin_email=$ADMIN_EMAIL \
#		--skip-email \
#		--path='/var/www/wordpress/' \
#		--allow-root
#	wp user create $USER_LOGIN $USER_EMAIL --path='/var/www/wordpress/' --allow-root
#fi
#echo "WordPress setup completed."
#
