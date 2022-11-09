.init:
	@echo "Please enter your current home directory name EX /home/?USER?"; \
	read USER; \
	DDB=/home/$$USER/data/db; \
	WB_SITE=/home/$$USER/data/wordpress; \
	mkdir -p $$WB_SITE; \
	mkdir -p $$DDB

.build: .init
	docker build ./srcs/requirements/mariadb -t mariadb:inception
	docker build ./srcs/requirements/nginx -t nginx:inception
	docker build ./srcs/requirements/wordpress -t wordpress:inception

all: .build
	docker-compose -f ./srcs/docker-compose.yml up -d 

debug: .build
	docker-compose -f ./srcs/docker-compose.yml up

stop:
	docker-compose -f ./srcs/docker-compose.yml down

run:
	docker-compose -f ./srcs/docker-compose.yml up -d 

remove: stop
	sudo rm -rf /home/cmarouf/data
	docker stop $(shell docker ps -aq); \
	docker rm -f $(shell docker ps -aq); \
	docker rmi -f $(shell docker images -aq); \
	docker volume rm $(shell docker volume ls -q); \
	docker network rm $(shell docker network ls -q)

.SILENT: remove

.PHONY: build stop init run remove debug
