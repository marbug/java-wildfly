#!/bin/sh

set -x -e

git checkout master
git pull
git branch | grep -v 'master' | awk '{print "git branch -D "$1;}' | sh
git branch -r | grep 'origin/v' | awk '{print "git checkout " substr($1, 8)}' | sh
