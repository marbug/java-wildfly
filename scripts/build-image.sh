#!/bin/sh

scriptName="$0"
osType="$1"

echo "==== Script name"
echo $scriptName

echo "==== Script directory"
scriptDirName=`dirname $scriptName`
echo $scriptDirName

echo "==== Go to root directory"
cd "$scriptDirName/.."
pwd

echo "==== OS type"
echo $osType

if [ "$osType" = "" ]; then
    if [ ! -f "./Dockerfile" ]; then
        echo "OS type is not specified"
        echo "and Dockerfile is absent"
        echo
        ls -1 | grep Dockerfile
        exit 1
    fi
fi

docker image build -f "Dockerfile.${osType}" -t java-wildfly .
