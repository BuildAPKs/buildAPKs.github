#!/usr/bin/env sh
# Copyright 2019-2020 (c)  all rights reserved by S D Rausty;  see LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# Queries first one hundred GitHib ids for AndroidManifest.xml files.
#####################################################################
set -eu
for i in $(curl -s "https://api.github.com/users?per_page=100&since=0"|grep "\"login"|awk '{ print $2 }' | sed 's/"//g' | sed 's/,//g');do ~/buildAPKs/build.github.bash $i;done
# id.sh EOF
