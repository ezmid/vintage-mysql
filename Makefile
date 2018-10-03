IMAGE=hub.docker.com/vintage/mysql
tag=latest

.PHONY: default
.ONESHELL: default
default:
	@echo -e "\nRun 'make build tag=1.0.0' to build the image and push it to the registry\n"

.PHONY: build
.ONESHELL: build
build:
	docker build . -t $(IMAGE):$(tag)
	docker push $(IMAGE):$(tag)
