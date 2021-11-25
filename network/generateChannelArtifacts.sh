#!/bin/bash

configtxgen -profile TwoOrgsGenesis \
    -channelID system-channel \
    -outputBlock ./channel-artifacts/genesis.block

configtxgen -profile TwoOrgsChannel \
    -channelID workspace \
    -outputCreateChannelTx ./channel-artifacts/workspace.tx

configtxgen -profile TwoOrgsChannel \
    -channelID workspace \
    -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchor.tx \
    -asOrg Org1MSP

configtxgen -profile TwoOrgsChannel \
    -channelID workspace \
    -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchor.tx \
    -asOrg Org2MSP
