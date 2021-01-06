FROM debian:buster

WORKDIR	/root/

COPY	./srcs/ .

RUN	apt --yes update \
	&& apt --yes install lsb-release wget gnupg \
	&& echo "4" | dpkg --install mysql-apt-config_0.8.16-1_all.deb

RUN	apt --yes update \
	&& apt --yes upgrade \
	&& apt --yes install nginx php7.3 php7.3-fpm php7.3-mysql \
	&& bash -c "debconf-set-selections <<< \"mysql-community-server mysql-community-server/root-pass password pass\"" \
	&& bash -c "debconf-set-selections <<< \"mysql-community-server mysql-community-server/re-root-pass password pass\"" \
	&& DEBIAN_FRONTEND=noninteractive apt --yes install mysql-server

RUN	mv wordpress.conf /etc/nginx/conf.d \
	&& rm --force /etc/nginx/sites-enabled/default \
	&& nginx -c /etc/nginx/nginx.conf \
	&& nginx -s reload && chmod -R 755 /root/


EXPOSE 80

CMD ["bash", "start_server.sh"]
