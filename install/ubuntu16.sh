#!/bin/sh

scriptFilePath="$0"
scriptDirPath=`dirname $scriptFilePath`

wildflyFileName="wildfly-8.2.1.Final.zip"
wildflyDirName="wildfly-8.2.1.Final"
wildflyToDir="wildfly"
wildflyDownloadUrl="http://download.jboss.org/wildfly/8.2.1.Final/$wildflyFileName"
jdkFileName="jdk-8u161-linux-x64.tar.gz"
jdkDirName="jdk1.8.0_161"
programsPath="/home/ubuntu/programs"
wildflyToPath="/opt/$wildflyToDir"

echo "==== File name:"
echo $scriptFilePath

echo "==== Dir name:"
echo $scriptDirPath

echo "==== Checking /vagrant dir ..."
if [ -d /vagrant ]; then
    echo "/vagrant dir is present. Using:"
    scriptDirPath="/vagrant/install"
    echo $scriptDirPath
fi

echo "==== Downloads dir:"
downloadsDir="$scriptDirPath/../downloads"
echo $downloadsDir

echo "==== Checking vagrant dir ..."
if [ -d /vagrant ]; then
    echo "/vagrant dir is present. Using:"
    downloadsDir="/vagrant/downloads"
    echo $downloadsDir
fi

echo "==== Creating downloads dir ..."
mkdir -p $downloadsDir

echo "==== Go to downloads dir ..."
cd $downloadsDir
pwd

echo "==== Extracting $jdkFileName ..."
if [ -d "$downloadsDir/$jdkDirName" ]; then
    echo "$downloadsDir/$jdkDirName is present. Skipping unzip ..."
else
    if [ -f "./$jdkFileName" ]; then
        echo "$jdkFileName is present. Extracting ..."
        tar xfz "./$jdkFileName"
    else
        echo "Download $jdkFileName from"
        echo "    http://www.oracle.com/technetwork/java/javase/downloads/index.html"
        echo "and move it to $downloadsDir"
        exit 1
    fi
fi

echo "==== Extracting $wildflyFileName ..."
if [ -d "$downloadsDir/$wildflyDirName" ]; then
    echo "$downloadsDir/$wildflyDirName is present. Skipping unzip ..."
else
    if [ -f "./$wildflyFileName" ]; then
        echo "$wildflyFileName is present. Extracting ..."
        apt-get install -y unzip
        unzip "./$wildflyFileName"
    else
        echo "Download $wildflyFileName from"
        echo "    $wildflyDownloadUrl"
        echo "and move it to $downloadsDir"
        exit 1
    fi
fi

echo "==== Checking programs dir ..."
echo $programsPath
mkdir -p $programsPath

echo "==== Copy $wildflyDirName to programs dir ..."
if [ -d "$wildflyToPath" ]; then
    echo "$wildflyToPath is present. Skipped."
else
    cp -R "./$wildflyDirName" "$wildflyToPath"
    echo $wildflyToPath
fi

echo "==== Checking jdk dir ..."
if [ -d "$downloadsDir/$jdkDirName" ]; then
    echo "Dir $downloadsDir/$jdkDirName is present"
else
    echo "Please, download and extract jdk to $downloadsDir/$jdkDirName"
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
ls -l "$wildflyToPath/bin/init.d/wildfly.conf"
cp -R "$scriptDirPath/ubuntu16.wildfly.conf" "/etc/default/wildfly"
echo "New file:"
ls -l "/etc/default/wildfly"

echo "==== Copy bin/init.d/wildfly-init-debian.sh to $wildflyToPath/bin/init.d/wildfly dir ..."
ls -l "$wildflyToPath/bin/init.d/wildfly-init-debian.sh"
cp -R "$wildflyToPath/bin/init.d/wildfly-init-debian.sh" "/etc/init.d/wildfly"
chmod 0700 /etc/init.d/wildfly
ls -l "/etc/init.d/wildfly"

echo "==== Fixing permissions ..."
chown -R ubuntu:ubuntu $wildflyToPath
chmod -R 0777 "$wildflyToPath"

echo "==== Running service ..."
update-rc.d wildfly defaults
update-rc.d wildfly enable
service wildfly start
service wildfly status
