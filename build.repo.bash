#!/usr/bin/env bash
# Copyright 2021-2022 (c) all rights reserved by BuildAPKs; see LICENSE
# https://buildapks.github.io published courtesy https://pages.github.com
################################################################################
set -eu
shopt -s nullglob globstar
export RDR="$HOME/buildAPKs"
if [ $# != 1 ]
then # print help
	printf "\\n%s\\n\\n%s\\n\\n%s\\n\\n" "The ${0##*/} command has been tested with https://github.com/search and https://gitlab.com/explore successfully." "EXAMPLE USAGE:  ${0##*/} https://github.com/BuildAPKs/buildAPKs.entertainment" "If you find repo candidates that merit inclusion, please share addresses to sourcecode repositories that work with this command at https://github.com/BuildAPKs in order to help develop this software.  Thank you for using ${0##*/};  Enjoy🎵🎶"
	exit
fi
_DOBUILD_() {
 	cd "$RDR/sources/$SITENAME/$LOGINAME/$REPONAME" && (_IAR_ "$PWD" || _SIGNAL_ "135" "${0##*/} _CLONEBUILD_ _IAR_")
	cd "$RDR/sources/$SITENAME/$LOGINAME/$REPONAME" && printf "\\e[1;38;5;151mFound %s APK files in ~/%s/.\\n\\n\\e[0m" "$(find "$PWD" -type f -name "*apk" | wc -l)" "$(cut -d"/" -f7-99 <<< "$PWD")" && "$RDR/scripts/bash/build/build.in.dir.bash"
	cd "$RDR/sources/$SITENAME/$LOGINAME/$REPONAME" && printf "\\e[1;38;5;151mFound %s APK files in ~/%s/.\\n\\n\\e[0m" "$(find "$PWD" -type f -name "*apk" | wc -l)" "$(cut -d"/" -f7-99 <<< "$PWD")"
}
_CLONEBUILD_() {
	cd "$RDR/sources/$SITENAME/$LOGINAME" && git clone --depth 1 "$@" --single-branch || _SIGNAL_ "135" "${0##*/} _CLONEBUILD_ git clone" "79"
	_DOBUILD_
}
BASENAME="${@%/}" # strip trailing slash
BASENAME="${BASENAME#*//}" # strip before double slash
REPONAME="${BASENAME##*/}" # strip before last slash
LOGINAME="${BASENAME%/*}" # strip after last slash
LOGINAME="${LOGINAME##*/}" # strip before last slash
SITENAME="${BASENAME%%/*}" # strip after first slash
if [ -z "${LOGINAME:-}" ] || [ -z "${REPONAME:-}" ] || [ -z "${SITENAME:-}" ] # any variable or more is empty
then # exit
	printf "%s\\n" "EXCEPTION processing $@ in directory ~/${RDR##*/}/sources/$SITENAME/$LOGINAME/$REPONAME:  EXITING..."
	exit 101
fi
printf "%s\\n" "Processing $@ in directory ~/${RDR##*/}/sources/$SITENAME/$LOGINAME/$REPONAME:"
. "$RDR"/scripts/bash/shlibs/buildAPKs/prep.bash
if [ -d "$RDR/sources/$SITENAME/$LOGINAME/$REPONAME" ]
then
_DOBUILD_
elif [ -d "$RDR/sources/$SITENAME/$LOGINAME" ]
then
	_CLONEBUILD_ "$@"
else
	mkdir -p "$RDR/sources/$SITENAME/$LOGINAME"
	_CLONEBUILD_ "$@"
fi

printf '\n%s\n\n' "Please share information about new projects found at https://github.com/BuildAPKs/db.BuildAPKs/issues and https://github.com/BuildAPKs/db.BuildAPKs/pulls in order to help this project develop."
# build.repo.bash OEF
