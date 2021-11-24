#!/bin/bash

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.workspace.com/users/Admin@org2.workspace.com/msp
export CORE_PEER_ADDRESS=peer1.org2.workspace.com:7051
export CORE_PEER_LOCALMSPID="Org2MSP"

export UPDATE_ANCHOR_PEER="Org2MSPanchors"

export CHANNEL_NAME=workspace
export ORDERER_ADDRESS="orderer.workspace.com:7050"