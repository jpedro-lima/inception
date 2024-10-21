# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: joapedr2 < joapedr2@student.42sp.org.br    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/22 15:40:46 by joapedr2          #+#    #+#              #
#    Updated: 2024/09/01 19:40:06 by joapedr2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

VOLUME_PATH=/home/joapedr2/data
COMPOSE=./srcs/docker-compose.yml
DOT_ENV=https://gist.githubusercontent.com/jpedro-lima/f579fe04ad6a01911cb7582a403d1ef2/raw/3d1b02c53410c9758b0809d38342947b41fbfa6e/.env

all: config up

permission:
	@/usr/bin/echo -e '\033[1;33mSUDO PERMISSION!\033[0m'
	@sudo /usr/bin/echo -e '\033[1;31mALL RIGHT\033[0m'

config:
	@if [ ! -f ./srcs/.env ]; then \
	 	wget -O ./srcs/.env ${DOT_ENV}; \
	fi
	@sudo chmod 666 /etc/hosts
	@if [! grep -q 'joapedr2' /etc/hosts]; then \
		sudo echo '127.0.0.1	joapedr2.42.fr' >> /etc/hosts; \
	fi
	@sudo mkdir -p ${VOLUME_PATH}/wordpress-db;
	@sudo mkdir -p ${VOLUME_PATH}/mariadb-db;

up:
	@docker-compose -f ${COMPOSE} build
	@docker-compose -f ${COMPOSE} up -d

start:
	@docker-compose -f ${COMPOSE} start

stop:
	@docker-compose -f ${COMPOSE} stop

down:
	@docker-compose -f ${COMPOSE} down

prune: down
	@if [ -n "$$(docker volume ls -q)" ]; then \
		docker volume rm $(shell docker volume ls -q); \
	fi
	@sudo rm -fr /home/joapedr2
	@docker system prune -f -a

re: prune all

.PHONY: all permission config up stop start down prune re
