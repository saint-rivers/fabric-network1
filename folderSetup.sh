#!/bin/bash

#NETWORK_PATH=$PWD/src/main/network

mkdir channel-artifacts
mkdir config
mkdir crypto-config
mkdir docker
mkdir explorer
mkdir monitoring
mkdir scripts

touch config/crypto-config.yaml
touch config/configtx.yaml
touch config/core.yaml
touch config/orderer.yaml

touch docker/docker-compose.yaml
touch docker/docker-compose-base.yaml