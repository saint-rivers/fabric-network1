#!/bin/bash

export COMPOSE_PROJECT_NAME=net
export IMAGE_TAG=latest

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.workspace.com/users/Admin@org2.workspace.com/msp
export CORE_PEER_ADDRESS=peer1.org2.workspace.com:7051
export CORE_PEER_LOCALMSPID="Org2MSP"

export SYS_CHANNEL=system-channel
export CHANNEL_NAME=workspace
export CHANNEL_ID=workspace
export ORDERER_ADDRESS="orderer.workspace.com:7050"



echo "============================== Joining peers to channel =================================="

peer channel join -b ./"$CHANNEL_NAME".block -o "$ORDERER_ADDRESS" 

# osnadmin channel join --orderer-address="$ORDERER_ADDRESS" --channelID=workspace --config-block=./workspace.block

peer channel list

echo "============================== Anchor Update =================================="

peer channel update \
    -o "$ORDERER_ADDRESS" \
    -c "$CHANNEL_NAME" \
    -f ./channel-artifacts/Org2MSPanchor.tx
