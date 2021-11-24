#!/bin/bash

export CHAINCODE_PATH=/opt/gopath/src/github.com/chaincode

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.workspace.com/users/Admin@org2.workspace.com/msp
export CORE_PEER_ADDRESS=peer1.org2.workspace.com:7051
export CORE_PEER_LOCALMSPID="Org2MSP"

export UPDATE_ANCHOR_PEER="Org2MSPanchors"

export CHANNEL_NAME=workspace
export ORDERER_ADDRESS="orderer.workspace.com:7050"

peer lifecycle chaincode install "$CHAINCODE_PATH"/assetTransfer.tar.gz

echo "============================= approving chaincode for ${CORE_PEER_ADDRESS} ============================="

CHAINCODE_NAME=sacc
CHANNEL_NAME=workspace
VERSION=1
SEQUENCE=1

peer lifecycle chaincode queryinstalled >&log.txt
cat log.txt
PACKAGE_ID=$(sed -n "/\"$CHAINCODE_NAME\"_\"$SEQUENCE\"/{s/^Package ID: //; s/, Label:.*$//;p;}" log.txt)

peer lifecycle chaincode approveformyorg -o "$ORDERER_ADDRESS" \
    --channelID "$CHANNEL_NAME" --name "$CHAINCODE_NAME" --version "$VERSION" \
    --init-required --package-id "$PACKAGE_ID" --sequence "$SEQUENCE"

peer lifecycle chaincode checkcommitreadiness \
    --channelID "$CHANNEL_NAME" \
    -n "$CHAINCODE_NAME" \
    -v "$VERSION" --sequence "$SEQUENCE" --init-required 
