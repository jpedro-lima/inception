#!/bin/bash

service mariadb start
sleep 5

mariadb -u root -e " 																		\
	CREATE DATABASE IF NOT EXISTS ${MYSQL_DB}												\
	; CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PSWD}' 						\
	; GRANT ALL ON ${MYSQL_DB}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PSWD}'		\
	; FLUSH PRIVILEGES																		\
	;"
