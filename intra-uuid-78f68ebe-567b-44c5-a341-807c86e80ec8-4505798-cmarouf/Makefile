
init:
	mkdir -p /home/cmarouf/data/wordpress
	mkdir -p /home/cmarouf/data/db
	docker build ./srcs/requirements/mariadb -t mariadb_inception
	docker build ./srcs/requirements/nginx -t nginx_inception
	docker build ./srcs/requirements/wordpress -t wordpress_inception

remove:
	docker-compose -f ./srcs/docker-compose.yml down
	sudo rm -rf /home/cmarouf/data
	docker container prune -f
run:
	docker-compose -f ./srcs/docker-compose.yml up -d 

debug:
	docker-compose -f ./srcs/docker-compose.yml up

stop:
	docker-compose -f ./srcs/docker-compose.yml down

.SILENT: stop init run remove debug
.PHONY: stop init run remove debug
