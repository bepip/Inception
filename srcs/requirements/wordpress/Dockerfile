FROM debian:bullseye
RUN	apt-get update && apt-get upgrade -y && \
	apt-get install -y \
	wget \
	php7.4 \
	php-fpm \
	php-mysql \
	mariadb-client &&\
	apt-get clean
RUN wget https://fr.wordpress.org/wordpress-6.7.2-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.7.2-fr_FR.tar.gz && rm wordpress-6.7.2-fr_FR.tar.gz
RUN mkdir -p /var/www/wordpress
RUN chown -R root:root /var/www/wordpress
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
COPY wordpress-entrypoint.sh /usr/local/bin/wordpress-entrypoint.sh
RUN chmod +x /usr/local/bin/wordpress-entrypoint.sh
ENTRYPOINT [ "sh", "/usr/local/bin/wordpress-entrypoint.sh" ]
RUN mkdir -p /run/php
#CMD [ "/usr/sbin/php-fpm7.4", "-F" ]
