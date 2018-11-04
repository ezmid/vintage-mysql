# Vintage MySQL

[![Build Status](https://travis-ci.org/ezmid/vintage-mysql.svg?branch=master)](https://travis-ci.org/ezmid/vintage-mysql) ![Docker Hub Status](https://img.shields.io/docker/build/ezmid/vintage-mysql.svg) ![Image Pulls](https://img.shields.io/docker/pulls/ezmid/vintage-mysql.svg) ![Image Stars](https://img.shields.io/docker/stars/ezmid/vintage-mysql.svg)

This is a simple docker image with a MySQL server build on top of Alpine Linux for development purposes.

## Installation

**Requirements**
- [GIT](https://git-scm.com/) >= 2.15
- [Docker CE](https://www.docker.com/) >= 17.12.0
- [Goss](https://github.com/aelsabbahy/goss) >= 0.3
- [Make](https://www.gnu.org/software/make/) >= 4.2

**Currently Goss is not available for Windows. Build everything else works on all platforms.*

## Development
```sh
# Build the image, TAG=latest is the default value
$ make build
# Build the image with a specific tag
$ make build TAG=1.1.0
# Test the latest image
$ make test
# Test a specific tag
$ make test TAG=1.1.0
# Push the latest tag to the registry
$ make push
# Push a specific tag
$ make push TAG=1.1.0
```

