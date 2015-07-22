.PHONY: all build

DOCKER = `which docker`
REPO = zanui/thumbor

TAG = $(shell git rev-parse --abbrev-ref HEAD 2>/dev/null)
ifeq ($(TAG), master)
	TAG = latest
else ifeq ($(TAG), HEAD)
	TAG = latest
endif

all: release

release: build
	$(DOCKER) push $(REPO)

build:
	$(DOCKER) build -t $(REPO):$(TAG) .

shell:
	docker run -t -i ${REPO}:latest /bin/bash

version:
	@grep THUMBOR_VERSION Dockerfile | cut -d' ' -f3
