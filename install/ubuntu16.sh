#!/bin/sh

vFileName="$0"
vDirName=`dirname $vFileName`

windflyDirName="wildfly-8.2.1.Final"
windflyDownloadUrl="http://download.jboss.org/wildfly/8.2.1.Final/wildfly-8.2.1.Final.zip"

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

echo "==== Checking $windflyDirName.zip ..."
if [ -f "./$windflyDirName.zip" ]; then
    echo "File is present"
else
    echo "Downloading $windflyDownloadUrl ..."
    wget -q "$windflyDownloadUrl"
fi

echo "==== Unzipping $windflyDirName.zip ..."
if [ -d "$windflyDirName" ]; then
    echo "./$windflyDirName is present. Skipping unzip ..."
else
    apt-get install -y unzip
    unzip $windflyDirName.zip
fi
