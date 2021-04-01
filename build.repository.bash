#!/usr/bin/env bash
# Copyright 2021 (c) all rights reserved by BuildAPKs; see LICENSE
# https://buildapks.github.io published courtesy https://pages.github.com
################################################################################
set -Eeuo pipefail
shopt -s nullglob globstar
export RDR="$HOME/buildAPKs"
. "$RDR/scripts/bash/shlibs/trap.bash" 67 68 69 "${0##*/} build.github.bash" wake.idle
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
