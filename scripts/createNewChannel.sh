#!/bin/bash

export ORDERER_ADDRESS="orderer.workspace.com:7050"
export CHANNEL_NAME=workspace

peer channel create \
    -o "$ORDERER_ADDRESS" \
    -c "$CHANNEL_NAME" \
    -f ./channel-artifacts/"$CHANNEL_NAME".tx \
    --outputBlock ./"$CHANNEL_NAME".block