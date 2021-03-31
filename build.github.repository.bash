#!/usr/bin/env bash
# Copyright 2021 (c) all rights reserved by BuildAPKs; see LICENSE
# https://buildapks.github.io published courtesy https://pages.github.com
################################################################################
set -Eeuo pipefail
shopt -s nullglob globstar
export RDR="$HOME/buildAPKs"
. "$RDR/scripts/bash/shlibs/trap.bash" 67 68 69 "${0##*/} build.github.bash"
. "$RDR/scripts/bash/init/ushlibs.bash"
if [ - d "$RDR/sources/github/repos" ]
then
cd "$RDR/sources/github/repos"
else
mkdir -p "$RDR/sources/github/repos"
cd "$RDR/sources/github/repos"
fi
git clone --depth 1 "$@" --single-branch
"$RDR/scripts/bash/build/build.in.dir.bash"
# build.github.repository.bash OEF
