#!/bin/bash

docker stop $(docker ps -a -q) 2> /dev/null
docker rm $(docker ps -a -q) 2> /dev/null

docker volume rm $(docker volume ls -q) 2> /dev/null

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
