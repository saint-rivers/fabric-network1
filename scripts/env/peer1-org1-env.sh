#!/bin/bash

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.workspace.com/users/Admin@org1.workspace.com/msp
export CORE_PEER_ADDRESS=peer1.org1.workspace.com:7051
export CORE_PEER_LOCALMSPID="Org1MSP"

export UPDATE_ANCHOR_PEER="Org1MSPanchors"

export CHANNEL_NAME=workspace
export ORDERER_ADDRESS="orderer.workspace.com:7050"
