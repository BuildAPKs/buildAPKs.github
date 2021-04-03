#!/usr/bin/env bash
# Copyright 2021 (c) all rights reserved by BuildAPKs; see LICENSE
# https://buildapks.github.io published courtesy https://pages.github.com
################################################################################
set -eu
shopt -s nullglob globstar
export RDR="$HOME/buildAPKs"
if [ $# != 1 ]
then # print help
	printf "\\n%s\\n\\n%s\\n\\n%s\\n\\n" "The ${0##*/} command has been tested with https://github.com/search and https://gitlab.com/explore successfully.  Share addresses to sourcecode at https://github.com/BuildAPKs in order to help develop this software if you find APK repo candidates for inclusion." "EXAMPLE USAGE:  ${0##*/} https://github.com/BuildAPKs/buildAPKs.entertainment" "If you find repo candidates for inclusion, please share addresses to sourcecode at https://github.com/BuildAPKs in order to help develop this software.  Thank you for using ${0##*/};  Enjoy🎵🎶"
	exit
fi
_CLONEBUILD_() {
	cd "$RDR/sources/$SITENAME/$LOGINAME" && git clone --depth 1 "$@" --single-branch && cd "$REPONAME" && "$RDR/scripts/bash/shlibs/buildAPKs/prep.bash" && "$RDR/scripts/bash/build/build.in.dir.bash"
}
BASENAME="${@%/}" # strip trailing slash
BASENAME="${BASENAME#*//}" # strip before double slash
REPONAME="${BASENAME##*/}" # strip before last slash
LOGINAME="${BASENAME%/*}" # strip after last slash
LOGINAME="${LOGINAME##*/}" # strip before last slash
SITENAME="${BASENAME%%/*}" # strip after first slash
if [ ! -n "${LOGINAME:-}" ] || [ ! -n "${REPONAME:-}" ] || [ ! -n "${SITENAME:-}" ] # any variable or more is empty
then # exit
	printf "%s\\n" "EXCEPTION processing $@ in directory ~/${RDR##*/}/sources/$SITENAME/$LOGINAME/$REPONAME:  EXITING..."
	exit 101
fi
printf "%s\\n" "Processing $@ in directory ~/${RDR##*/}/sources/$SITENAME/$LOGINAME/$REPONAME:"
sleep 1.6
if [ -d "$RDR/sources/$SITENAME/$LOGINAME/$REPONAME" ]
then
	cd "$RDR/sources/$SITENAME/$LOGINAME/$REPONAME"
	"$RDR/scripts/bash/shlibs/buildAPKs/prep.bash"
	"$RDR/scripts/bash/build/build.in.dir.bash"
elif [ -d "$RDR/sources/$SITENAME/$LOGINAME" ]
then
	_CLONEBUILD_ "$@"
else
	mkdir -p "$RDR/sources/$SITENAME/$LOGINAME"
	_CLONEBUILD_ "$@"
fi
# build.repo.bash OEF
