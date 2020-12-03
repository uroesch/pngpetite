
DOCKER_IMAGE_NAME ?= pngpetite
DOCKERHUB_USERNAME ?= uroesch
CURRENT_GIT_REF ?= $(shell git rev-parse --abbrev-ref HEAD) # Default to current branch
DOCKER_IMAGE_TAG ?= $(shell echo $(CURRENT_GIT_REF) | sed 's|.*/.*[^-]-|v|g')
DOCKER_IMAGE_NAME_TO_TEST ?= $(DOCKERHUB_USERNAME)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG)
PNGPETITE_VERSION ?= 0.4.1

export \
  DOCKER_IMAGE_NAME_TO_TEST \
  PNGPETITE_VERSION 

all: build test README.md

build:
	docker build \
		--tag="$(DOCKER_IMAGE_NAME_TO_TEST)" \
		--file=Dockerfile \
		$(CURDIR)/

shell: build
	docker run -it -v $(CURDIR)/tests/fixtures:/documents/ $(DOCKER_IMAGE_NAME_TO_TEST)

test:
	bats $(CURDIR)/tests/*.bats

# GitHub renders asciidoctor but DockerHub requires markdown.
# This recipe creates README.md from README.adoc.
README.md:
	asciidoctor -b docbook -a leveloffset=+1 -o - README.adoc | \
		pandoc --atx-headers --wrap=preserve -t gfm -f docbook - > README.md

.PHONY: all build test shell deploy clean README.md
