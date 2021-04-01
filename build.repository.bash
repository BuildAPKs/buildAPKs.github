#!/usr/bin/env bash
# Copyright 2021 (c) all rights reserved by BuildAPKs; see LICENSE
# https://buildapks.github.io published courtesy https://pages.github.com
################################################################################
set -eu
shopt -s nullglob globstar
export RDR="$HOME/buildAPKs"
if [ $# != 1 ]
then
printf "%s\\n\\n" "EXAMPLE USAGE:  '${0##*/} https://github.com/BuildAPKs/buildAPKs.entertainment'" && exit
fi
. "$RDR/scripts/bash/init/ushlibs.bash"
printf "%s\\n" "Processing $@:"
REPONAME="${@##*/}"
LOGINAME="${@%/*}"
LOGINAME="${LOGINAME##*/}"
SITENAME="${@#*//}"
SITENAME="${SITENAME%/*}"
SITENAME="${SITENAME%/*}"
if [ -d "$RDR/sources/$SITENAME/$LOGINAME" ]
then
cd "$RDR/sources/$SITENAME/$LOGINAME"
else
mkdir -p "$RDR/sources/$SITENAME/$LOGINAME"
cd "$RDR/sources/$SITENAME/$LOGINAME"
fi
git clone --depth 1 "$@" --single-branch && cd "$REPONAME" && "$RDR/scripts/bash/build/build.in.dir.bash" || cd "$REPONAME" && "$RDR/scripts/bash/build/build.in.dir.bash"
# build.repository.bash OEF
