.PHONY: build run stop remove

CONTAINER_ENGINE = podman
IMAGE_NAME = marza
CONTAINER_NAME = marza-container

build:
	$(CONTAINER_ENGINE) build -t $(IMAGE_NAME) .

run:
	$(CONTAINER_ENGINE) run $(ARGS) --name $(CONTAINER_NAME) $(IMAGE_NAME)

stop:
	$(CONTAINER_ENGINE) container stop $(CONTAINER_NAME)

remove:
	$(CONTAINER_ENGINE) container rm $(CONTAINER_NAME)
