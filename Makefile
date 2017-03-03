# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

include .env

.DEFAULT_GOAL=build

network:
	@docker network inspect $(DOCKER_NETWORK_NAME) >/dev/null 2>&1 || docker network create $(DOCKER_NETWORK_NAME)

volumes:
	@docker volume inspect $(DATA_VOLUME_HOST) >/dev/null 2>&1 || docker volume create --name $(DATA_VOLUME_HOST)

pull:
	docker pull $(DOCKER_NOTEBOOK_IMAGE)

notebook_image: pull

# build: check-files network volumes
# 	docker-compose build

build:network volumes
		docker-compose build

# .PHONY: network volumes check-files pull notebook_image build
.PHONY: network volumes pull notebook_image build
