# Vintage MySQL

[![Build Status](https://travis-ci.org/ezmid/vintage-mysql.svg?branch=master)](https://travis-ci.org/ezmid/vintage-mysql) ![Docker Hub Status](https://img.shields.io/docker/build/ezmid/vintage-mysql.svg) ![Image Pulls](https://img.shields.io/docker/pulls/ezmid/vintage-mysql.svg) ![Image Stars](https://img.shields.io/docker/stars/ezmid/vintage-mysql.svg)

This is a simple Docker image with a MySQL compliant MariaDB server build on top of Alpine Linux for development purposes.

## Usage

```yaml
# Example of docker-compose.yaml
version: "3"
services:
    mysql:
        image: ezmid/vintage-mysql:latest
        ports:
            - 3306:3306
        environment:
            MYSQL_ROOT_PASSWORD: "${DB_ROOT_PASS:-root}"
            MYSQL_DBTABASE: "${DB_NAME:-my-project}"
            MYSQL_USER: "${DB_USER:-my-project}"
            MYSQL_PASSWORD: "${DB_PASS:-my-project}"
            # For alpine version..
            MYSQL_ROOT_PWD: "${DB_ROOT_PASS:-root}"
            MYSQL_USER_DB: "${DB_NAME:-my-project}"
```

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

