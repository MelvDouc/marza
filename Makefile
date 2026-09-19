.PHONY: build run exec stop remove

CONTAINER_ENGINE = podman
IMAGE_NAME = marza-img
CONTAINER_NAME = marza-ctn

build:
	$(CONTAINER_ENGINE) build -t $(IMAGE_NAME) .

run:
	$(CONTAINER_ENGINE) run -d --rm --name $(CONTAINER_NAME) -v $(PWD)/src:/root/.local/bin:z $(IMAGE_NAME)

exec:
	$(CONTAINER_ENGINE) exec -it $(CONTAINER_NAME) bash

stop:
	$(CONTAINER_ENGINE) container stop $(CONTAINER_NAME)

remove:
	$(CONTAINER_ENGINE) container rm $(CONTAINER_NAME)
