#!/bin/bash

########################################################################
#       EXPORT ENVIRONMENT VARIABLES
########################################################################
export FABRIC_CFG_PATH=$PWD/config
export PATH=$PATH:$PWD/bin

########################################################################
#       GENERATE CRYPTO MATERIALS
########################################################################
cryptogen generate --config="$FABRIC_CFG_PATH"/crypto-config.yaml

########################################################################
#       GENERATE CHANNEL ARTIFACTS
########################################################################

configtxgen -profile TwoOrgsGenesis -channelID system-channel -outputBlock ./channel-artifacts/genesis.block
configtxgen -profile TwoOrgsChannel -channelID workspace -outputCreateChannelTx ./channel-artifacts/workspace.tx
configtxgen -profile TwoOrgsChannel -channelID workspace -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchor.tx -asOrg Org1MSP
configtxgen -profile TwoOrgsChannel -channelID workspace -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchor.tx -asOrg Org2MSP


########################################################################
#       START NETWORK
########################################################################

export COMPOSE_PROJECT_NAME=net
export IMAGE_TAG=latest
export SYS_CHANNEL=system-channel

docker-compose -f docker/docker-compose.yaml up -d
sleep 3s
docker ps


########################################################################
#       CREATE AND JOIN CHANNEL
########################################################################

docker exec -it cli bash -c ". scripts/createChannel.sh workspace"

docker exec -it cli bash -c ". scripts/joinChannelPeer1Org1.sh"
docker exec -it cli bash -c ". scripts/joinChannelPeer1Org2.sh"


########################################################################
#       PACKAGE CHAINCODE
########################################################################

echo "============================= Packaging Chaincode ============================="

pushd ./chaincode || exit 1
go mod init assetTransfer.go
go mod tidy
GO111MODULE=on go mod vendor
popd || exit 1

export FABRIC_CFG_PATH=$PWD/config

peer lifecycle chaincode package ./chaincode/assetTransfer.tar.gz --lang golang --label "sacc_1" --path ./chaincode


########################################################################
#       INSTALLING AND APPROVING CHAINCODE
########################################################################

docker exec -it cli bash -c ". scripts/installAndApproveChaincodePeer1Org1.sh"
docker exec -it cli bash -c ". scripts/installAndApproveChaincodePeer1Org2.sh"


########################################################################
#       COMMITING CHAINCODE
########################################################################

docker exec -it cli bash -c ". scripts/commitChaincode.sh"



########################################################################
#       CREATE NEW CHANNEL
########################################################################

docker exec -it cli bash -c ". scripts/createNewChannel.sh retailing"
