REGISTRY_NAME = nakanod/nsd
CONTAINER_NAME = nakanod_nsd
TAG = latest

.PHONY: all build run push start stop restart rm shell

all: build

build:
	@docker build ${OPTIONS} --rm -t ${REGISTRY_NAME}:${TAG} .
run:
	@docker run ${OPTIONS} -d -p 53:53 -p 53:53/udp --name ${CONTAINER_NAME} -t ${REGISTRY_NAME} ${COMMAND}
push:
	@docker push ${REGISTRY_NAME}:${TAG}
start:
	@docker start ${CONTAINER_NAME}
stop:
	@docker stop ${CONTAINER_NAME}
restart:
	@docker restart ${CONTAINER_NAME}
rm:
	@docker rm ${CONTAINER_NAME}
shell:
	@docker exec -i -t ${CONTAINER_NAME} /bin/sh
