#!/bin/sh

vFileName="$0"
vDirName=`dirname $vFileName`

windflyDirName="wildfly-8.2.1.Final"
windflyDownloadUrl="http://download.jboss.org/wildfly/8.2.1.Final/wildfly-8.2.1.Final.zip"
jdkDirName="jdk1.8.0_161"
programsPath="/home/ubuntu/programs"

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
if [ -d "$vDownloadsDir/$windflyDirName" ]; then
    echo "$vDownloadsDir/$windflyDirName is present. Skipping unzip ..."
else
    apt-get install -y unzip
    unzip $windflyDirName.zip
fi

echo "==== Checking programs dir ..."
echo $programsPath
mkdir -p $programsPath

echo "==== Copy $windflyDirName to programs dir ..."
if [ -d "$programsPath/$windflyDirName" ]; then
    echo "$programsPath/$windflyDirName is present. Skipped."
else
    cp -R "./$windflyDirName" "$programsPath/$windflyDirName"
    echo $programsPath/$windflyDirName
fi

echo "==== Checking jdk dir ..."
if [ -d "$vDownloadsDir/$jdkDirName" ]; then
    echo "Dir $vDownloadsDir/$jdkDirName is present"
else
    echo "Please, download and extract jdk to $vDownloadsDir/$jdkDirName"
    exit 1
fi

echo "==== Setting JAVA_HOME env variable ..."
export JAVA_HOME="$vDownloadsDir/$jdkDirName"
echo "JAVA_HOME:" $JAVA_HOME
echo "JAVA_HOME=\"$JAVA_HOME\"" >> /etc/environment

echo "==== Copy $jdkDirName to programs dir ..."
if [ -d "$programsPath/$jdkDirName" ]; then
    echo "$programsPath/$jdkDirName is present. Skipped."
else
    cp -R "./$jdkDirName" "$programsPath/$jdkDirName"
    echo $programsPath/$jdkDirName
fi

echo "==== Fixing permissions ..."
chown -R ubuntu:ubuntu $programsPath
chmod 0777 "$programsPath/$windflyDirName/standalone/data/content/"

echo "==== Running windfly ..."
cd "$vDownloadsDir/$windflyDirName"
pwd
./bin/standalone.sh &
