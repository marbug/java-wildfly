#!/bin/sh

vFileName="$0"
vDirName=`dirname $vFileName`

echo "==== File name:"
echo $vFileName

echo "==== Dir name:"
echo $vDirName

echo "==== Downloads dir:"
vDownloadsDir="$vDirName/../downloads"
echo $vDownloadsDir

echo "==== Checking vagrant dir ..."
if [ -d /vagrant ]; then
    echo "/vagrant dir is present. Using ..."
    vDownloadsDir="/vagrant/downloads"
fi

echo "==== Creating downloads dir ..."
mkdir -p $vDownloadsDir

echo "==== Go to downloads dir ..."
cd $vDownloadsDir
pwd
