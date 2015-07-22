.PHONY: all release build shell test version tag repo

REPO = zanui/thumbor
VERSION = 0.0.1
THUMBOR_VERSION = `grep THUMBOR_VERSION Dockerfile | cut -d' ' -f3 | xargs -n1 -I% echo T%`
DOCKER = `which docker`

TAG = $(shell git rev-parse --abbrev-ref HEAD 2>/dev/null)
ifeq ($(TAG), master)
	TAG = latest
else ifeq ($(TAG), HEAD)
	TAG = latest
endif

all: release

release: build
	$(DOCKER) tag $(REPO) $(REPO):$(THUMBOR_VERSION)
	$(DOCKER) tag $(REPO) $(REPO):$(VERSION)
	$(DOCKER) push $(REPO)
	$(DOCKER) push quay.io/$(REPO)

build:
	$(DOCKER) build -t $(REPO):$(TAG) .

shell:
	$(DOCKER) run -t -i $(REPO):$(TAG) /bin/bash

test:
	DOCKER_IMAGE=$(REPO):$(TAG) bundle exec rspec

version:
	@echo $(THUMBOR_VERSION)

tag:
	@echo $(TAG)

repo:
	@echo $(REPO)
