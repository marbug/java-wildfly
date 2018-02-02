#!/bin/sh

vFileName="$0"
vDirName=`dirname $vFileName`

echo "==== File name:"
echo $vFileName

echo "==== Dir name:"
echo $vDirName

echo "==== Checking vagrant dir ..."
if [ -d /vagrant ]; then
    echo "/vagrant dir is present. Using ..."
    vDirName="/vagrant"
fi

echo "==== Downloads dir:"
vDownloadsDir="$vDirName/../downloads"
echo $vDownloadsDir
mkdir -p $vDownloadsDir
