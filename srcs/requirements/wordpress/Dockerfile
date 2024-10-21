FROM debian:oldstable

ARG SERVER_NAME

ARG WP_ADMIN_MAIL
ARG WP_ADMIN_USER
ARG WP_ADMIN_PSWD

ARG WP_MAIL
ARG WP_USER
ARG WP_PSWD

RUN apt update && apt install -y \
	php7.4			\
	php7.4-fpm		\
	php-mysql 		\
	mariadb-client	\
	wordpress		\
	wget			\
	netcat			\
	&& apt clean

RUN wget -O /usr/bin/wp \
	https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod 777 /usr/bin/wp

RUN wp core download --allow-root --path=/var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress
RUN chmod -R 777 /var/www/wordpress/

RUN mkdir -p /run/php

COPY ./conf/www.conf		/etc/php/7.4/fpm/pool.d/www.conf
COPY ./conf/wp-config.php	/var/www/wordpress/wp-config.php
COPY ./tools/wb-script.sh	/tmp/script.sh

RUN chmod 777 /tmp/script.sh

ENTRYPOINT [ "/tmp/script.sh" ]