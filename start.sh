#!/bin/bash


########################################################################
#       EXPORT ENVIRONMENT VARIABLES
########################################################################

export FABRIC_CFG_PATH=$PWD/config
export PATH=$PATH:$PWD/bin

########################################################################
#       GENERATE CRYPTO MATERIALS
########################################################################

. network/generateCryptoMaterials.sh

########################################################################
#       GENERATE CHANNEL ARTIFACTS
########################################################################

. network/generateChannelArtifacts.sh


########################################################################
#       START NETWORK
########################################################################

docker-compose -f docker/docker-compose.yaml up -d


########################################################################
#       CREATE AND JOIN CHANNEL
########################################################################

docker exec -it cli bash -c ". scripts/createNewChannel.sh"
docker exec -it cli bash -c ". scripts/joinPeersToChannel.sh"
docker exec -it cli bash -c ". scripts/joinPeersToChannelPeer2.sh"


########################################################################
#       PACKAGE CHAINCODE
########################################################################

. scripts/packageChaincode.sh


########################################################################
#       INSTALLING AND APPROVING CHAINCODE
########################################################################

docker exec -it cli bash -c ". scripts/installChaincodeOnPeer.sh"
docker exec -it cli bash -c ". scripts/installChaincodeOnPeer2.sh"


########################################################################
#       COMMITING CHAINCODE
########################################################################

docker exec -it cli bash -c ". scripts/commitChaincode.sh"
