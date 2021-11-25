#!/bin/bash

echo "============================== Creating channel =================================="

# export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/

bash ./scripts/env/peer1-org1-env.sh

# what i need is to generate the channel configuration for this one too

export ORDERER_ADDRESS="orderer.workspace.com:7050"
export CHANNEL_NAME=$1

peer channel create \
    -o "$ORDERER_ADDRESS" \
    -c "$CHANNEL_NAME" \
    -f ./channel-artifacts/"$CHANNEL_NAME".tx \
    --outputBlock ./"$CHANNEL_NAME".block

