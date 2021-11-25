#!/bin/bash

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

docker volume rm $(docker volume ls -q)

rm -rf crypto-config
echo "Removing crypto config:"
if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
fi

rm -rf channel-artifacts
echo "Removing channel artifacts:"
if [ $? -eq 0 ]; then
    echo OK
else
    echo FAIL
fi
