FROM debian:bullseye-slim
RUN	apt-get update && apt-get upgrade -y && \
	apt-get install -y \
	mariadb-server mariadb-client \
	curl \
	vim \
	sudo && \
	apt-get clean
COPY conf/50-server.cnf /etc/mysql/mariadb.conf/50-server.cnf
