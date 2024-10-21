FROM debian:oldstable

ARG SERVER_NAME

RUN apt update && apt install -y \
	nginx \
	openssl \
	&& apt clean

RUN openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:4096 \
  -keyout /etc/ssl/certs/${SERVER_NAME}.key \
  -out /etc/ssl/certs/${SERVER_NAME}.crt \
  -subj "/C=BR/ST=SP/L=Sao Paulo/O=42SP/OU=Student Project/CN=${SERVER_NAME}/UID=joapedr2"

RUN mkdir -p /var/www/wordpress

COPY ./conf/nginx.conf /etc/nginx/conf.d

ENTRYPOINT [ "nginx" ]
CMD [ "-g", "daemon off;" ]