#!/bin/sh

vFileName="$0"
vDirName=`dirname $vFileName`

windflyDirName="wildfly-8.2.1.Final"
windflyDownloadUrl="http://download.jboss.org/wildfly/8.2.1.Final/wildfly-8.2.1.Final.zip"
javaDirName="jdk1.8.0_161"
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

echo "==== Checking java dir ..."
if [ -d "$vDownloadsDir/$javaDirName" ]; then
    echo "Dir $vDownloadsDir/$javaDirName is present"
else
    echo "Please, download and extract jdk to $vDownloadsDir/$javaDirName"
    exit 1
fi

echo "==== Setting JAVA_HOME env variable ..."
export JAVA_HOME="$vDownloadsDir/$javaDirName"
echo "JAVA_HOME:" $JAVA_HOME

echo "==== Running windfly ..."
cd "$vDownloadsDir/$windflyDirName"
pwd
./bin/standalone.sh &
