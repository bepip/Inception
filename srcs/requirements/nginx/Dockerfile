FROM debian:bullseye
RUN	apt-get update && apt-get upgrade -y && \
	apt-get install -y \
	openssl \
	nginx \
	curl \
	vim \
	sudo && \
	apt-get clean

RUN mkdir -p /etc/nginx/ssl
RUN apt-get install openssl -y
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=LU/ST=Luxembourg/L=Luxembourg/O=42/OU=42/CN=pibernar.42.fr"
RUN mkdir -p /var/run/nginx
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html
COPY conf/nginx.conf /etc/nginx/nginx.conf
CMD [ "nginx", "-g", "daemon off;" ]
#EXPOSE 443
