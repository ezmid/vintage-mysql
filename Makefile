#!/usr/bin/make -f

# RUN WHOLE PROCESS IN ONE SHELL
.ONESHELL:

################################################################################
################################################################################
# Variable definitions
################################################################################

# Are we running in an interactive shell? If so then we can use codes for
# a colored output
ifeq ("$(shell [ -t 0 ] && echo yes)","yes")
FORMAT_BOLD=\e[1m
FORMAT_RED=\033[0;31m
FORMAT_YELLOW=\033[0;33m
FORMAT_GREEN=\x1b[32;01m
FORMAT_RESET=\033[0m
else
FORMAT_BOLD=
FORMAT_RED=
FORMAT_YELLOW=
FORMAT_GREEN=
FORMAT_RESET=
endif

# Path to the echo binary. This is needed because on some systems there are
# multiple versions installed and the alias "echo" may reffer to something
# different.
ECHO=$(shell which echo)
OSECHOFLAG=-e
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	ECHO=echo
	OSECHOFLAG=
	FORMAT_BOLD=
endif

# Import all ENV vars / overwrite defaults
ifeq ($(shell test -e .env && echo -n yes),yes)
    include ./.env
    export $(shell sed 's/=.*//' .env)
endif

################################################################################
################################################################################
# Help and tool warmup
################################################################################

# Default target, must be first!
.ONESHELL: default
.PHONY: default
default:
	@$(ECHO) ""
	@$(ECHO) "\n\n$(FORMAT_YELLOW)$(shell cat docs/ascii-logo.txt)$(FORMAT_RESET)\n"
	@$(ECHO) $(OSECHOFLAG)  "$(FORMAT_YELLOW)\n\nCommands:$(FORMAT_RESET)\n\n" \
	"  make init                              Init environment from *.dist files\n" \
	"  make start                             Start all Docker services\n" \
	"  make build                             Build binary\n" \
	"  make test                              Quick run tests\n" \
	"  make test/curl                         Quick check of /v1/translate API\n" \
	"\n" \
	"  make docker/login                      Login to the registry\n" \
	"  make docker/build                      Build docker image\n" \
	"  make docker/push                       Push a docker image to the registry\n" \
	"\n" \
	"\n" \

# Preload .env variables if file exists
.PHONY: env/load
env/load:
ifneq ($(wildcard .env),)
    include ./.env
    export $(shell sed 's/=.*//' .env)
endif

# Prepare env for development
.PHONY: init
init:
	cp -p .env.dist .env

################################################################################
# Build/rebuild the image
.PHONY: build
.ONESHELL: build
build:
	docker build . -t $(IMAGE_NAME):$(TAG)

################################################################################
# Push the image to registry
.PHONY: push
.ONESHELL: push
push:
	docker push $(IMAGE_NAME):$(TAG)

################################################################################
# Run a test
.PHONY: test
.ONESHELL: test
test:
	@dgoss run $(IMAGE_NAME):$(TAG) --retry-timeout 30s --sleep 1s
