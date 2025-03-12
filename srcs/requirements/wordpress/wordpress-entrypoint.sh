#!/bin/sh
set -e
sleep 10

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
	wp config create	--allow-root \
						--dbname=$SQL_DATABASE \
						--dbuser=$SQL_USER \
						--dbpass=$SQL_PASSWORD \
						--dbhost=mariadb:3306 \
						--path='/var/www/wordpress/'
else
	cat wp-config.php | wc -l
	cat wp-config.php
fi
if ! wp core is-installed --path='/var/www/wordpress/' --allow-root; then
	wp core install \
		--title="SummeryLeak" \
		--admin_user=$ADMIN_USER \
		--admin_password=$ADMIN_PASSWORD \
		--admin_email=$ADMIN_EMAIL \
		--skip-email \
		--path='/var/www/wordpress/' \
		--allow-root
	wp user create $USER_LOGIN $USER_EMAIL --path='/var/www/wordpress/' --allow-root
fi
echo "WordPress setup completed."
