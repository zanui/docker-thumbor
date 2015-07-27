.PHONY: all release build shell test version tag repo

REPO = zanui/thumbor
VERSION = `grep THUMBOR_VERSION Dockerfile | cut -d' ' -f3`
DOCKER = `which docker`
TAG = $(VERSION)

all: release

release: build
	@echo Pushing	 $(REPO):$(TAG)...
	@$(DOCKER) push $(REPO)
	# $(DOCKER) push quay.io/$(REPO)

build:
	@echo Building $(REPO):$(TAG)...
	@$(DOCKER) build -t $(REPO):$(TAG) .

shell:
	@echo Opening shell for $(REPO):$(TAG)
	@$(DOCKER) run --rm -t -i $(REPO):$(TAG) /sbin/my_init -- bash -l

shell_ports:
	@echo Opening shell with ports for $(REPO):$(TAG)
	@$(DOCKER) run --rm -t -i -p 9000:9000 $(REPO):$(TAG) /sbin/my_init -- bash -l

test:
	@echo Testing $(REPO):$(TAG)...
	@DOCKER_IMAGE=$(REPO):$(TAG) bundle exec rspec

version:
	@echo $(VERSION)

tag:
	@echo $(TAG)

repo:
	@echo $(REPO)
