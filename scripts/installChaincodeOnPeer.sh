#!/bin/bash

export CHAINCODE_PATH=/opt/gopath/src/github.com/chaincode
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.workspace.com/users/Admin@org1.workspace.com/msp

export CORE_PEER_ADDRESS="peer1.org1.workspace.com:7051"
export ORDERER_ADDRESS="orderer.workspace.com:7050"

export CORE_PEER_LOCALMSPID="Org1MSP"

CHAINCODE_NAME=sacc
CHANNEL_NAME=workspace
VERSION=1
SEQUENCE=1

# install

peer lifecycle chaincode install "$CHAINCODE_PATH"/assetTransfer.tar.gz


# approve 

peer lifecycle chaincode queryinstalled >&log.txt
cat log.txt
PACKAGE_ID=$(sed -n "/\"$CHAINCODE_NAME\"_\"$SEQUENCE\"/{s/^Package ID: //; s/, Label:.*$//;p;}" log.txt)

peer lifecycle chaincode approveformyorg -o "$ORDERER_ADDRESS" \
    --channelID "$CHANNEL_NAME" --name "$CHAINCODE_NAME" \
    --version "$VERSION" --sequence "$SEQUENCE" \
    --peerAddresses "$CORE_PEER_ADDRESS" \
    --package-id "$PACKAGE_ID" \
    --init-required 


