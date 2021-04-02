#!/usr/bin/env bash
# Copyright 2021 (c) all rights reserved by BuildAPKs; see LICENSE
# https://buildapks.github.io published courtesy https://pages.github.com
################################################################################
set -eu
shopt -s nullglob globstar
export RDR="$HOME/buildAPKs"
if [ $# != 1 ]
then
printf "\\n%s\\n\\n%s\\n\\n" "The '${0##*/}' command has been tested with https://github.com/search and https://gitlab.com/explore successfully.  Please share addresses to sourcecode at https://github.com/BuildAPKs in order to help develop this topic if you find repo candidates for inclusion." "EXAMPLE USAGE:  '${0##*/} https://github.com/BuildAPKs/buildAPKs.entertainment'" && exit
fi
_CLONEBUILD_() {
cd "$RDR/sources/$SITENAME/$LOGINAME"
git clone --depth 1 "$@" --single-branch 
cd "$REPONAME"
"$RDR/scripts/bash/build/build.in.dir.bash"
}
BASENAME="${@%/}" # strip trailing slash
BASENAME="${BASENAME#*//}" # strip before double slash
REPONAME="${BASENAME##*/}" # strip before last slash
LOGINAME="${BASENAME%/*}" # strip after last slash
LOGINAME="${LOGINAME##*/}" # strip before last slash
SITENAME="${BASENAME%%/*}" # strip after first slash
printf "%s\\n" "Processing $@ in directory ~/${RDR##*/}/sources/$SITENAME/$LOGINAME/$REPONAME:"
if [ -d "$RDR/sources/$SITENAME/$LOGINAME/$REPONAME" ]
then
cd "$RDR/sources/$SITENAME/$LOGINAME/$REPONAME"
"$RDR/scripts/bash/build/build.in.dir.bash"
elif [ -d "$RDR/sources/$SITENAME/$LOGINAME" ]
then
_CLONEBUILD_ "$@"
else
mkdir -p "$RDR/sources/$SITENAME/$LOGINAME"
_CLONEBUILD_ "$@"
fi
# build.repo.bash OEF
