#!/bin/bash

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

docker volume rm $(docker volume ls -q)

rm -rf crypto-config
if [ $? -eq 0 ]; then
    echo "================== Removing crypto config =================="
    echo OK
else
    echo FAIL
fi

rm -rf channel-artifacts
if [ $? -eq 0 ]; then
    echo "================== Removing channel artifacts =================="
    echo OK
else
    echo FAIL
fi

rm -rf chaincode
if [ $? -eq 0 ]; then
    echo "================== Removing chaincode =================="
    echo OK
else
    echo FAIL
fi
