.PHONY: help

.DEFAULT_GOAL := help

SHELL := /bin/bash

NAME   := comicrack
ORG    := pezhore
REPO   := ${ORG}/${NAME}
TAG    := $(shell git log -1 --pretty=format:"%h")
IMG    := ${REPO}:${TAG}
LATEST := ${REPO}:latest
VERSION := $(shell cat VERSION)


help: # http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

release: ## tag a release from master and push to origin
	git tag -a -m release $(VERSION)
	git push --tags

build: ## build the Docker image for this app
	docker build --network=host --tag $(REPO):$(VERSION) --rm=false .

login: ## Login to docker hub
	docker login -u $(ORG)

push: ## push the latest Docker image to DockerHub
	docker push $(REPO):$(VERSION)

shell: ## run an interactive bash session in the container
	docker run -it $(REPO) /bin/bash

run: ## run the container
	docker run $(REPO)

deploy: build login push