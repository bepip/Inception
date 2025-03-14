#!/bin/sh
set -e
sleep 10

WP_CONFIG_PATH="/var/www/wordpress/wp-config.php"

if [ ! -f "$WP_CONFIG_PATH" ]; then
    # Manually create wp-config.php
    cat > "$WP_CONFIG_PATH" <<EOF
<?php
define( 'DB_NAME', '$SQL_DATABASE' );
define( 'DB_USER', '$SQL_USER' );
define( 'DB_PASSWORD', '$SQL_PASSWORD' );
define( 'DB_HOST', 'mariadb:3306' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );

$(wp config shuffle-salts --allow-root)

\$table_prefix = 'wp_';

define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';
EOF
    echo "wp-config.php created manually."
else
    echo "wp-config.php already exists."
fi

if ! wp core is-installed --path='/var/www/wordpress' --allow-root; then
    wp core install \
        --url="http://pibernar.42.fr" \
        --title="Prayge Inception" \
        --admin_user=$ADMIN_USER \
        --admin_password=$ADMIN_PASSWORD \
        --admin_email=$ADMIN_EMAIL \
        --skip-email \
        --path='/var/www/wordpress' \
        --allow-root
    wp user create $USER_LOGIN $USER_EMAIL --role=author --path='/var/www/wordpress' --allow-root
fi

echo "WordPress setup completed."

exec /usr/sbin/php-fpm7.4 -F
