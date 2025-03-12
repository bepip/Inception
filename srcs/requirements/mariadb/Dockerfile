FROM debian:bullseye
RUN	apt-get update && apt-get upgrade -y && \
	apt-get install -y \
	mariadb-server mariadb-client &&\
	apt-get clean
COPY conf/50-server.cnf /etc/mysql/mariadb.conf/50-server.cnf
COPY mariadb-entrypoint.sh /usr/local/bin/mariadb-entrypoint.sh
RUN chmod +x /usr/local/bin/mariadb-entrypoint.sh
ENTRYPOINT [ "sh", "/usr/local/bin/mariadb-entrypoint.sh" ]
