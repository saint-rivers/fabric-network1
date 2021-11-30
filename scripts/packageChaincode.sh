#!/bin/bash

pushd ./chaincode || exit 1
go mod init assetTransfer.go
go mod tidy
GO111MODULE=on go mod vendor
popd || exit 1

export FABRIC_CFG_PATH=$PWD/config

peer lifecycle chaincode package ./chaincode/assetTransfer.tar.gz \
    --path ./chaincode \
    --lang golang --label "sacc_1"

