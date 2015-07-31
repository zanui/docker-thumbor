.PHONY: all release build shell test version tag repo

REPO = zanui/thumbor
VERSION = `grep THUMBOR_VERSION Dockerfile | cut -d' ' -f3`
DOCKER = `which docker`
TAG = $(VERSION).$(shell git tag -l | grep $(VERSION) | wc -l | xargs echo)

all: build release

release:
	@echo Pushing $(REPO):$(TAG)...
	@if [ -z "${CIRCLECI}" ]; then echo "This is not CircleCI"; exit 1; fi
	@git tag $(TAG) && git push
	@github-release release -u zanui -r docker-thumbor -t $(TAG) --draft
	@echo Tagging $(REPO):$(TAG) with $(REPO):latest
	@$(DOCKER) tag -f $(REPO):$(TAG) $(REPO):latest
	@echo Tagging $(REPO):$(TAG) with $(REPO):$(VERSION)
	@$(DOCKER) tag -f $(REPO):$(TAG) $(REPO):$(VERSION)
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

run:
	@echo Starting container $(REPO):$(TAG)
	@$(DOCKER) run -d -p 9000:9000 $(REPO):$(TAG)

test:
	@echo Testing $(REPO):$(TAG)...
	@DOCKER_IMAGE=$(REPO):$(TAG) bundle exec rspec

show_version:
	@echo $(VERSION)

show_tag:
	@echo $(TAG)

show_repo:
	@echo $(REPO)
