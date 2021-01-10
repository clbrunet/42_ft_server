FROM debian:buster

WORKDIR	/root/

RUN	apt --yes update; \
	apt --yes upgrade; \
	apt --yes install nginx openssl \
	php7.3 php7.3-fpm php7.3-mysql mariadb-server;

RUN	rm --force /etc/nginx/sites-enabled/default; \
	openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
	-keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt \
	-subj '/CN=localhost';

COPY	./srcs/ .

RUN	mv --target-directory /var/www/html/ wordpress/ phpmyadmin/; \
	mv ft_server.conf /etc/nginx/conf.d/;

EXPOSE 80 443

ENTRYPOINT	["./start_server.sh"]
CMD	["./nginx_daemon_off.sh"]
