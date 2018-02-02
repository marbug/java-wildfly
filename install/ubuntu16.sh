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
    echo "/vagrant dir is present. Using:"
    vDownloadsDir="/vagrant/downloads"
    echo $vDownloadsDir
fi

echo "==== Creating downloads dir ..."
mkdir -p $vDownloadsDir

echo "==== Go to downloads dir ..."
cd $vDownloadsDir
pwd

echo "==== Checking wildfly-8.2.1.Final.zip ..."
if [ -f "./wildfly-8.2.1.Final.zip" ]; then
    echo "File is present"
else
    echo "Downloading http://download.jboss.org/wildfly/8.2.1.Final/wildfly-8.2.1.Final.zip ..."
    wget -c http://download.jboss.org/wildfly/8.2.1.Final/wildfly-8.2.1.Final.zip
fi
