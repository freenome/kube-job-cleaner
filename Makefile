.PHONY: test docker push

IMAGE            ?= gcr.io/freenome-services-dev/kube-job-cleaner
VERSION          ?= $(shell git describe --tags --always --dirty)
TAG              ?= $(VERSION)
GITHEAD          = $(shell git rev-parse --short HEAD)
GITURL           = $(shell git config --get remote.origin.url)
GITSTATUS        = $(shell git status --porcelain || echo "no changes")

default: docker

docker:
	docker build -t "$(IMAGE):$(TAG)" .
	@echo 'Docker image $(IMAGE):$(TAG) can now be used.'

push: docker
	docker push "$(IMAGE):$(TAG)"

