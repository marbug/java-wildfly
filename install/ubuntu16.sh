#!/bin/sh

vFileName="$0"
vDirName=`dirname $vFileName`

wildflyFromDir="wildfly-8.2.1.Final"
wildflyToDir="wildfly"
wildflyDownloadUrl="http://download.jboss.org/wildfly/8.2.1.Final/wildfly-8.2.1.Final.zip"
jdkDirName="jdk1.8.0_161"
programsPath="/home/ubuntu/programs"
wildFlyToPath="/opt/$wildflyToDir"

echo "==== File name:"
echo $vFileName

echo "==== Dir name:"
echo $vDirName

echo "==== Checking /vagrant dir ..."
if [ -d /vagrant ]; then
    echo "/vagrant dir is present. Using:"
    vDirName="/vagrant/install"
    echo $vDirName
fi

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

echo "==== Checking $wildflyFromDir.zip ..."
if [ -f "./$wildflyFromDir.zip" ]; then
    echo "File is present"
else
    echo "Downloading $wildflyDownloadUrl ..."
    wget -q "$wildflyDownloadUrl"
fi

echo "==== Unzipping $wildflyFromDir.zip ..."
if [ -d "$vDownloadsDir/$wildflyFromDir" ]; then
    echo "$vDownloadsDir/$wildflyFromDir is present. Skipping unzip ..."
else
    apt-get install -y unzip
    unzip $wildflyFromDir.zip
fi

echo "==== Checking programs dir ..."
echo $programsPath
mkdir -p $programsPath

echo "==== Copy $wildflyFromDir to programs dir ..."
if [ -d "$wildFlyToPath" ]; then
    echo "$wildFlyToPath is present. Skipped."
else
    cp -R "./$wildflyFromDir" "$wildFlyToPath"
    echo $wildFlyToPath
fi

echo "==== Checking jdk dir ..."
if [ -d "$vDownloadsDir/$jdkDirName" ]; then
    echo "Dir $vDownloadsDir/$jdkDirName is present"
else
    echo "Please, download and extract jdk to $vDownloadsDir/$jdkDirName"
    exit 1
fi

echo "==== Setting JAVA_HOME env variable ..."
export JAVA_HOME="$programsPath/$jdkDirName"
echo "JAVA_HOME:" $JAVA_HOME
echo "JAVA_HOME=\"$JAVA_HOME\"" >> /etc/environment

echo "==== Copy $jdkDirName to programs dir ..."
if [ -d "$programsPath/$jdkDirName" ]; then
    echo "$programsPath/$jdkDirName is present. Skipped."
else
    cp -R "./$jdkDirName" "$programsPath/$jdkDirName"
    echo $programsPath/$jdkDirName
fi

echo "==== Copy ubuntu16.wildfly.conf to /etc/default/wildfly ..."
echo "Old file:"
ls -l "$wildFlyToPath/bin/init.d/wildfly.conf"
cp -R "$vDirName/ubuntu16.wildfly.conf" "/etc/default/wildfly"
echo "New file:"
ls -l "/etc/default/wildfly"

echo "==== Copy bin/init.d/wildfly-init-debian.sh to $wildFlyToPath/bin/init.d/wildfly dir ..."
ls -l "$wildFlyToPath/bin/init.d/wildfly-init-debian.sh"
cp -R "$wildFlyToPath/bin/init.d/wildfly-init-debian.sh" "/etc/init.d/wildfly"
ls -l "/etc/init.d/wildfly"

echo "==== Fixing permissions ..."
chown -R ubuntu:ubuntu $wildFlyToPath
chmod -R 0777 "$wildFlyToPath"

echo "==== Running service ..."
apt-get install -y upstart
initctl reload-configuration
service wildfly start
