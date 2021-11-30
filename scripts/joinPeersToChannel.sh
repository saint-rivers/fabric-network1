#!/bin/bash

export COMPOSE_PROJECT_NAME=net
export IMAGE_TAG=latest
export SYS_CHANNEL=system-channel
export CHANNEL_NAME=workspace

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.workspace.com/users/Admin@org1.workspace.com/msp

export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_ADDRESS="peer1.org1.workspace.com:7051"
export ORDERER_ADDRESS="orderer.workspace.com:7050"


echo "============================== Joining peers to channel =================================="

peer channel join -b ./"$CHANNEL_NAME".block -o "$ORDERER_ADDRESS" 

echo "============================== Anchor Update =================================="

peer channel update \
    -o "$ORDERER_ADDRESS" \
    -c "$CHANNEL_NAME" \
    -f ./channel-artifacts/Org1MSPanchor.tx

