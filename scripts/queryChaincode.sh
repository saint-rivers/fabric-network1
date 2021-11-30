#!/bin/bash

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.workspace.com/users/Admin\@org1.workspace.com/msp
export CORE_PEER_ADDRESS="peer1.org1.workspace.com:7051"

peer chaincode query -C workspace -n sacc -c '{"Args":["InitLedger"]}'