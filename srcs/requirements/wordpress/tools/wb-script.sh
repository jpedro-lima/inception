#!/bin/bash

echo "[======== PINGING DATABASE CONTAINER ========]"

start_time=$(date +%s)
end_time=$((start_time + 30))

while [ $(date +%s) -lt $end_time ]; do

	nc -zv mariadb 3306

	if [ $? -eq 0 ]; then
		break
	fi

	sleep 1
done

if [ $(date +%s) -ge $end_time ]; then
    echo "[========MARIADB IS NOT RESPONDING========]"
fi

wp core install	\
	--path=/var/www/wordpress			\
	--url="$SERVER_NAME"				\
	--title="42SP Inception"			\
	--admin_user="$WP_ADMIN_USER"		\
	--admin_password="$WP_ADMIN_PSWD"	\
	--admin_email="$WP_ADMIN_MAIL"		\
	--allow-root

wp user create	\
	--path=/var/www/wordpress	\
	"$WP_USER" "$WP_MAIL"		\
	--user_pass=$WP_PSWD		\
	--role='author'				\
	--allow-root

php-fpm7.4 -F