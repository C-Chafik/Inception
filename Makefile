#!make

include envfile
export $(shell sed 's/=.*//' envfile)

WB_SITE=/home/$(DOCKER_USER)/data/wordpress
DDB=/home/$(DOCKER_USER)/data/db

.init:
	@if [ ! -d "/home/$(DOCKER_USER)/data" ]; then \
		mkdir -p $(WB_SITE); \
		mkdir -p $(DDB); \
		docker build ./srcs/requirements/mariadb -t mariadb:inception; \
		docker build ./srcs/requirements/nginx -t nginx:inception; \
		docker build ./srcs/requirements/wordpress -t wordpress:inception; \
	fi

all: .init
	docker-compose --env-file ./srcs/.env -f ./srcs/docker-compose.yml up -d 

debug: .init
	docker-compose --env-file ./srcs/.env -f ./srcs/docker-compose.yml up

stop:
	docker-compose  --env-file ./srcs/.env -f ./srcs/docker-compose.yml down

resume: .init
	docker-compose  --env-file ./srcs/.env -f ./srcs/docker-compose.yml up -d 

remove: stop
	sudo rm -rf /home/$(DOCKER_USER)/data/
	docker volume rm -f srcs_data-base; \
	docker volume rm -f srcs_website; \
	docker image rm wordpress:inception; \
	docker image rm mariadb:inception; \
	docker image rm nginx:inception

.SILENT: remove

.PHONY: build stop init run remove debug
