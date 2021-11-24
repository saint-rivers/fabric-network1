#!/bin/bash

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.workspace.com/users/Admin@org1.workspace.com/msp
export CORE_PEER_ADDRESS=peer1.org1.workspace.com:7051
export CORE_PEER_LOCALMSPID="Org1MSP"

export CHANNEL_NAME=workspace
export ORDERER_ADDRESS="orderer.workspace.com:7050"

CHAINCODE_NAME=sacc
VERSION=1
SEQUENCE=1

echo "============================= committing chaincode for ${CORE_PEER_ADDRESS} ============================="


peer lifecycle chaincode commit -o "$ORDERER_ADDRESS" \
    --channelID "$CHANNEL_NAME" --name "$CHAINCODE_NAME" \
    --peerAddresses peer1.org1.workspace.com:7051 \
    --peerAddresses peer1.org2.workspace.com:7051 \
    --sequence "$SEQUENCE" --version "$VERSION" --init-required

peer lifecycle chaincode querycommitted --channelID "$CHANNEL_NAME" --name "$CHAINCODE_NAME"

