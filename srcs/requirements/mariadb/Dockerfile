FROM debian:bullseye
RUN	apt-get update && apt-get upgrade -y && \
	apt-get install -y \
	mariadb-server mariadb-client &&\
	apt-get clean
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY mariadb-config.sh /usr/local/bin/mariadb-config.sh
COPY mariadb-entrypoint.sh /usr/local/bin/mariadb-entrypoint.sh
RUN chmod +x /usr/local/bin/mariadb-entrypoint.sh 
RUN chmod +x /usr/local/bin/mariadb-config.sh

ENTRYPOINT [ "sh", "/usr/local/bin/mariadb-entrypoint.sh" ]
