#!/bin/sh

vFileName="$0"
vDirName=`dirname $vFileName`

wildflyDirName="wildfly-8.2.1.Final"
wildflyDownloadUrl="http://download.jboss.org/wildfly/8.2.1.Final/wildfly-8.2.1.Final.zip"
jdkDirName="jdk1.8.0_161"
programsPath="/home/ubuntu/programs"

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

echo "==== Checking $wildflyDirName.zip ..."
if [ -f "./$wildflyDirName.zip" ]; then
    echo "File is present"
else
    echo "Downloading $wildflyDownloadUrl ..."
    wget -q "$wildflyDownloadUrl"
fi

echo "==== Unzipping $wildflyDirName.zip ..."
if [ -d "$vDownloadsDir/$wildflyDirName" ]; then
    echo "$vDownloadsDir/$wildflyDirName is present. Skipping unzip ..."
else
    apt-get install -y unzip
    unzip $wildflyDirName.zip
fi

echo "==== Checking programs dir ..."
echo $programsPath
mkdir -p $programsPath

echo "==== Copy $wildflyDirName to programs dir ..."
if [ -d "$programsPath/$wildflyDirName" ]; then
    echo "$programsPath/$wildflyDirName is present. Skipped."
else
    cp -R "./$wildflyDirName" "$programsPath/$wildflyDirName"
    echo $programsPath/$wildflyDirName
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

echo "==== Setting JBOSS_HOME env variable ..."
export JBOSS_HOME="$programsPath/$wildflyDirName"
echo "JAVA_HOME:" $JBOSS_HOME
echo "JAVA_HOME=\"$JBOSS_HOME\"" >> /etc/environment

echo "==== Copy $jdkDirName to programs dir ..."
if [ -d "$programsPath/$jdkDirName" ]; then
    echo "$programsPath/$jdkDirName is present. Skipped."
else
    cp -R "./$jdkDirName" "$programsPath/$jdkDirName"
    echo $programsPath/$jdkDirName
fi

echo "==== Copy wildfly.conf to $programsPath/$wildflyDirName/bin/init.d/wildfly.conf ..."
echo "Old file:"
ls -l "$programsPath/$wildflyDirName/bin/init.d/wildfly.conf"
cp -R "$vDirName/wildfly.conf" "$programsPath/$wildflyDirName/bin/init.d/wildfly.conf"
echo "New file:"
ls -l "$programsPath/$wildflyDirName/bin/init.d/wildfly.conf"

echo "==== Copy bin/init.d/wildfly-init-debian.sh to $programsPath/$wildflyDirName/bin/init.d/wildfly.conf dir ..."
ls -l "$programsPath/bin/init.d/wildfly-init-debian.sh"
cp -R "$programsPath/bin/init.d/wildfly-init-debian.sh" "/etc/init.d/wildfly"
ls -l "/etc/init.d/wildfly"

echo "==== Fixing permissions ..."
chown -R ubuntu:ubuntu $programsPath
# chmod -R 0777 "$programsPath/$wildflyDirName/standalone/data/content"
chmod -R 0777 "$programsPath/$wildflyDirName"

reboot
