#!/bin/sh

echo "==== Checking current dir ..."
vCurrentDir=`dirname $0`
echo $vCurrentDir
cd $vCurrentDir

# echo "==== Save to ququdev ..."
# ./use-ququdev.sh
# git push -f

echo "==== Save to bitbucket ..."
./use-bitbucket.sh
git push -f

echo "==== Save to github ..."
./use-github.sh
git push -f
