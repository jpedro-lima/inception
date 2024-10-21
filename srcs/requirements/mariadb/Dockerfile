FROM debian:oldstable

ARG MYSQL_DB
ARG MYSQL_USER
ARG MYSQL_PSWD

RUN apt update && apt install -y \
	mariadb-server \
	&& apt clean

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

COPY ./conf/my.cnf			/etc/mysql/my.cnf
COPY ./tools/mdb-script.sh	/tmp/script.sh

RUN chmod 777 /tmp/script.sh \
	&& bash /tmp/script.sh

ENTRYPOINT [ "mysqld_safe" ]