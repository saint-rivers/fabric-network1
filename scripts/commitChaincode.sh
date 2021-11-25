#!/bin/bash

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.workspace.com/users/Admin@org1.workspace.com/msp
export CHANNEL_NAME=workspace

export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_ADDRESS="peer1.org1.workspace.com:7051"
export ORDERER_ADDRESS="orderer.workspace.com:7050"

CHAINCODE_NAME=sacc
VERSION=1
SEQUENCE=1

peer lifecycle chaincode checkcommitreadiness \
    --channelID "$CHANNEL_NAME" --name "$CHAINCODE_NAME" \
    --version "$VERSION" --sequence "$SEQUENCE" \
    --init-required

peer lifecycle chaincode commit -o "$ORDERER_ADDRESS" \
    --channelID "$CHANNEL_NAME" --name "$CHAINCODE_NAME" \
    --version "$VERSION" --sequence "$SEQUENCE" \
    --peerAddresses peer1.org1.workspace.com:7051 \
    --peerAddresses peer1.org2.workspace.com:7051 \
    --init-required

peer lifecycle chaincode querycommitted \
    --channelID "$CHANNEL_NAME" \
    --name "$CHAINCODE_NAME"