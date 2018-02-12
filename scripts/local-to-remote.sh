#!/bin/sh

git checkout master
git branch | grep -v '* master' | awk '{print "git checkout "$1" && git push"}' | sh
git checkout master
git push
