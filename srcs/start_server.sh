#!/bin/bash

if [ ! -z "${FT_SERVER_DISABLE_AUTOINDEX+x}" ] \
	&& [ "${FT_SERVER_DISABLE_AUTOINDEX}" != "0" ]; then
	sed --in-place "s/\(autoindex\s*\)on;/\1off;/g" /etc/nginx/conf.d/ft_server.conf;
fi
service php7.3-fpm start;
service nginx start > /dev/null;
service mysql start > /dev/null;
mariadb < mariadb_script.sql;

exec "$@"
