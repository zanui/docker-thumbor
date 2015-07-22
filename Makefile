.PHONY: all release build shell test version tag repo

REPO = zanui/thumbor
VERSION = `grep THUMBOR_VERSION Dockerfile | cut -d' ' -f3`
DOCKER = `which docker`
TAG = $(VERSION)

all: release

release: build
	$(DOCKER) push $(REPO)
	# $(DOCKER) push quay.io/$(REPO)

build:
	$(DOCKER) build -t $(REPO):$(TAG) .

shell:
	$(DOCKER) run -t -i $(REPO):$(TAG) /bin/bash

test:
	DOCKER_IMAGE=$(REPO):$(TAG) bundle exec rspec

version:
	@echo $(VERSION)

tag:
	@echo $(TAG)

repo:
	@echo $(REPO)
