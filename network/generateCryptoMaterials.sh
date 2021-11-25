#!/bin/bash

########################################################################
#       EXPORT ENVIRONMENT VARIABLES
########################################################################

export FABRIC_CFG_PATH=$PWD/config
export PATH=$PATH:$PWD/bin


########################################################################
#       GENERATE CRYPTO MATERIALS
########################################################################

cryptogen generate --config=./config/crypto-config.yaml


