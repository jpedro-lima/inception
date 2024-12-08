# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: joapedr2 < joapedr2@student.42sp.org.br    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/08/22 15:40:46 by joapedr2          #+#    #+#              #
#    Updated: 2024/12/08 12:28:15 by joapedr2         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

VOLUME_PATH=/home/joapedr2/data
COMPOSE=./srcs/docker-compose.yml
DOT_ENV=https://gist.githubusercontent.com/jpedro-lima/f579fe04ad6a01911cb7582a403d1ef2/raw/3d1b02c53410c9758b0809d38342947b41fbfa6e/.env

all: permission config up

permission:
	@echo -e '\033[1;33mSUDO PERMISSION!\033[0m'
	@sudo echo -e '\033[1;31mALL RIGHT\033[0m'

config:
	@if [ ! -f ./srcs/.env ]; then \
	 	wget -O ./srcs/.env ${DOT_ENV}; \
	fi
	@sudo chmod 666 /etc/hosts
	@if [ ! "$(shell grep -q 'joapedr2' /etc/hosts)" ]; then \
		sudo echo '127.0.0.1	joapedr2.42.fr' >> /etc/hosts; \
	fi
	@sudo mkdir -p ${VOLUME_PATH}/wordpress-db;
	@sudo mkdir -p ${VOLUME_PATH}/mariadb-db;

up:
	@docker-compose -f ${COMPOSE} build
	@docker-compose -f ${COMPOSE} up -d

down:
	@docker-compose -f ${COMPOSE} down

clean: down
	@if [ "$(shell docker image ls -a | grep wordpress)" ]; then \
		docker rmi wordpress:joapedr2; \
	fi

	@if [ "$(shell docker image ls -a | grep nginx)" ]; then \
		docker rmi nginx:joapedr2; \
	fi
	
	@if [ "$(shell docker image ls -a | grep mariadb)" ]; then \
		docker rmi mariadb:joapedr2; \
	fi

fclean: clean
	@if [ -n "$$(docker volume ls -q)" ]; then \
		docker volume rm $(shell docker volume ls -q); \
	fi
	@sudo rm -fr /home/joapedr2

re: fclean all

.PHONY: all permission config up down clean fclean re
