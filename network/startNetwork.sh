#!/bin/bash

export COMPOSE_PROJECT_NAME=net
export IMAGE_TAG=latest
export SYS_CHANNEL=system-channel

docker-compose -f docker/docker-compose.yaml up -d

