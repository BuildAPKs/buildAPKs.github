#!/usr/bin/env bash
# Copyright 2021 (c) all rights reserved by BuildAPKs; see LICENSE
# https://buildapks.github.io published courtesy https://pages.github.com
################################################################################
set -eu
shopt -s nullglob globstar
export RDR="$HOME/buildAPKs"
if [ $# != 1 ]
then
printf "\\n%s\\n\\n" "EXAMPLE USAGE:  '${0##*/} https://github.com/BuildAPKs/buildAPKs.entertainment'" && exit
fi
BASENAME="${@%/}" # strip trailing slash
REPONAME="${BASENAME##*/}" # strip before last slash
LOGINAME="${BASENAME%/*}" # strip after last slash
LOGINAME="${LOGINAME##*/}" # strip before last slash
BASENAME="${BASENAME#*//}" # strip before double slash
SITENAME="${BASENAME%%/*}" # strip after first slash
printf "%s\\n" "Processing $@ in directory ~/${RDR##*/}/sources/$SITENAME/$LOGINAME/$REPONAME:"
if [ -d "$RDR/sources/$SITENAME/$LOGINAME" ]
then
cd "$RDR/sources/$SITENAME/$LOGINAME"
else
mkdir -p "$RDR/sources/$SITENAME/$LOGINAME"
cd "$RDR/sources/$SITENAME/$LOGINAME"
fi
(git clone --depth 1 "$@" --single-branch && cd "$REPONAME" && "$RDR/scripts/bash/build/build.in.dir.bash") || (cd "$REPONAME" && "$RDR/scripts/bash/build/build.in.dir.bash")
# build.repo.bash OEF
