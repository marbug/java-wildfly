#!/bin/sh

scriptFilePath="$0"
scriptDirPath=`dirname $scriptFilePath`

downloadsDirName="downloads"
downloadsDirPath="/vagrant/$downloadsDirName"
tmpDirPath="/tmp"

jdkArchiveFileName="jdk-8u161-linux-x64.tar.gz"
jdkArchiveDirName="jdk1.8.0_161"
jdkTargetPath="/opt/jdk"
jdkDownloadUrl="http://www.oracle.com/technetwork/java/javase/downloads/index.html"

wildflyArchiveFileName="wildfly-8.2.1.Final.zip"
wildflyArchiveDirName="wildfly-8.2.1.Final"
wildflyTargetPath="/opt/wildfly"
wildflyDownloadUrl="http://download.jboss.org/wildfly/8.2.1.Final/$wildflyArchiveFileName"
wildflyConfPath="/etc/default/wildfly"

JAVA_HOME="$jdkTargetPath"
JBOSS_HOME="$wildflyTargetPath"
JBOSS_USER="ubuntu"
JBOSS_OPTS="-b 0.0.0.0 -bmanagement 0.0.0.0"

echo "======== Checking needed directories ..."

echo "==== Checking /vagrant directory ..."
if [ ! -d "/vagrant" ]; then
    echo "ERROR: /vagrant directory is absent. This file must be run by vagrant!!! Exiting ..."
    exit 1
fi

echo "==== Checking $downloadsDirPath directory ..."
if [ ! -d "$downloadsDirPath" ]; then
    echo "$downloadsDirName directory is absent. Creating ..."
    mkdir -p "$downloadsDirPath"
fi

echo "==== Checking $tmpDirPath directory ..."
if [ ! -d "$tmpDirPath" ]; then
    echo "ERROR: $tmpDirPath directory is absent. Create ..."
    mkdir -p $tmpDirPath
fi

echo "======== Checking needed archive files ..."

echo "==== Checking $downloadsDirPath/$jdkArchiveFileName file ..."
if [ ! -f "$downloadsDirPath/$jdkArchiveFileName" ]; then
    echo "ERROR: $downloadsDirName/$jdkArchiveFileName file is absent"
    echo "Please, download $jdkArchiveFileName from"
    echo "    $jdkDownloadUrl"
    echo "and move it to $downloadsDirName/$jdkArchiveFileName"
    exit 1
fi

echo "==== Checking $downloadsDirPath/$wildflyArchiveFileName file ..."
if [ ! -f "$downloadsDirPath/$wildflyArchiveFileName" ]; then
    echo "ERROR: $downloadsDirName/$wildflyArchiveFileName file is absent"
    echo "Please, download $wildflyArchiveFileName from"
    echo "    $wildflyDownloadUrl"
    echo "and move it to $downloadsDirName/$wildflyArchiveFileName"
    exit 1
fi

echo "======== Install jdk ..."

echo "==== Prepare target directory ..."
if [ -d "$jdkTargetPath" ]; then
    echo "$jdkTargetPath directory is present. Installation is skipped."
    echo "WARNING: Please, remove $jdkTargetPath if you would like to reinstall jdk"
else
    echo "$jdkTargetPath directory is absent. Install jdk ..."

    echo "==== Copy archive ..."
    if [ -f "$tmpDirPath/$jdkArchiveFileName" ]; then
        echo "$tmpDirPath/$jdkArchiveFileName is present. Remove ..."
        rm -fR "$tmpDirPath/$jdkArchiveFileName"
    fi
    echo "Copy $downloadsDirName/$jdkArchiveFileName to $tmpDirPath/$jdkArchiveFileName ..."
    cp "$downloadsDirPath/$jdkArchiveFileName" "$tmpDirPath/$jdkArchiveFileName"

    echo "==== Go to $tmpDirPath ..."
    cd "$tmpDirPath"
    pwd

    echo "==== Extract archive ..."
    if [ -d "$tmpDirPath/$jdkArchiveDirName" ]; then
        echo "$tmpDirPath/$jdkArchiveDirName is present. Remove ..."
        rm -fR "$tmpDirPath/$jdkArchiveDirName"
    fi
    echo "Extract $tmpDirPath/$jdkArchiveFileName to $tmpDirPath/$jdkArchiveDirName ..."
    tar xfz "./$jdkArchiveFileName"

    echo "==== Copy extracted "$tmpDirPath/$jdkArchiveDirName" to "$jdkTargetPath" ..."
    if [ ! -d "$tmpDirPath/$jdkArchiveDirName" ]; then
        echo "ERROR: $tmpDirPath/$jdkArchiveDirName is absent. Please, check $jdkArchiveFileName archive"
        exit 1
    fi
    cp -R "$tmpDirPath/$jdkArchiveDirName" "$jdkTargetPath"
fi

echo "======== Install wildfly ..."

echo "==== Prepare target directory ..."
if [ -d "$wildflyTargetPath" ]; then
    echo "$wildflyTargetPath directory is present. Installation is skipped."
    echo "WARNING: Please, remove $wildflyTargetPath if you would like to reinstall wildfly"
else
    echo "$wildflyTargetPath directory is absent. Install wildfly ..."

    echo "==== Copy archive ..."
    if [ -f "$tmpDirPath/$wildflyArchiveFileName" ]; then
        echo "$tmpDirPath/$wildflyArchiveFileName is present. Remove ..."
        rm -fR "$tmpDirPath/$wildflyArchiveFileName"
    fi
    echo "Copy $downloadsDirName/$wildflyArchiveFileName to $tmpDirPath/$wildflyArchiveFileName ..."
    cp "$downloadsDirPath/$wildflyArchiveFileName" "$tmpDirPath/$wildflyArchiveFileName"

    echo "==== Install unzip ..."
    apt-get install -y unzip

    echo "==== Go to $tmpDirPath ..."
    cd "$tmpDirPath"
    pwd

    echo "==== Extract archive ..."
    if [ -d "$tmpDirPath/$wildflyArchiveDirName" ]; then
        echo "$tmpDirPath/$wildflyArchiveDirName is present. Remove ..."
        rm -fR "$tmpDirPath/$wildflyArchiveDirName"
    fi
    echo "Extract $tmpDirPath/$wildflyArchiveFileName to $tmpDirPath/$wildflyArchiveDirName ..."
    unzip "./$wildflyArchiveFileName"

    echo "==== Copy extracted "$tmpDirPath/$wildflyArchiveDirName" to "$wildflyTargetPath" ..."
    if [ ! -d "$tmpDirPath/$wildflyArchiveDirName" ]; then
        echo "ERROR: $tmpDirPath/$wildflyArchiveDirName is absent. Please, check $wildflyArchiveFileName archive"
        exit 1
    fi
    cp -R "$tmpDirPath/$wildflyArchiveDirName" "$wildflyTargetPath"

    echo "==== Fixing copied files permissions ..."
    chown -R "$JBOSS_USER:$JBOSS_USER" "$wildflyTargetPath"
    chmod -R 0777 "$wildflyTargetPath"
fi

echo "======== Install wildfly config ..."

echo "==== Clear wildfly config ..."
echo -n > "$wildflyConfPath"

echo "==== Add JAVA_HOME to config ..."
echo "JAVA_HOME=\"$JAVA_HOME\""
echo "JAVA_HOME=\"$JAVA_HOME\"" >> "$wildflyConfPath"

echo "==== Add JBOSS_HOME to config ..."
echo "JBOSS_HOME=\"$JBOSS_HOME\""
echo "JBOSS_HOME=\"$JBOSS_HOME\"" >> "$wildflyConfPath"

echo "==== Add JBOSS_USER to config ..."
echo "JBOSS_USER=$JBOSS_USER"
echo "JBOSS_USER=$JBOSS_USER" >> "$wildflyConfPath"

echo "==== Add JBOSS_OPTS to config ..."
echo "JBOSS_OPTS=\"$JBOSS_OPTS\""
echo "JBOSS_OPTS=\"$JBOSS_OPTS\"" >> "$wildflyConfPath"

echo "==== Result config"
cat "$wildflyConfPath"

echo "======== Install wildfly service ..."

echo "==== Copy bin/init.d/wildfly-init-debian.sh to /etc/init.d/wildfly ..."
ls -l "$wildflyTargetPath/bin/init.d/wildfly-init-debian.sh"
cp -R "$wildflyTargetPath/bin/init.d/wildfly-init-debian.sh" "/etc/init.d/wildfly"
chmod 0700 /etc/init.d/wildfly
ls -l "/etc/init.d/wildfly"

echo "==== Prepare service ..."
update-rc.d wildfly defaults

echo "==== Enable service ..."
update-rc.d wildfly enable

echo "==== Run service ..."
service wildfly start
service wildfly status
