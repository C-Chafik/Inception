docker rm -f $(docker ps -aq)
docker container prune
docker-compose down
