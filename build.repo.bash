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
_ANTBUILD_() {
ANTBUILD="$(find "$RDR/sources/$SITENAME/$LOGINAME/$REPONAME" -type f -name build.xml)"
if [[ -n "${ANTBUILD:-}" ]]
then
	for BUILDXML in $ANTBUILD
	do
		printf '%s\\' "ant build in directory ${BUILDXML%/*} begun"
		cd "${BUILDXML%/*}" ; pwd ; ant ||:
		printf '%s\\' "ant build in directory $(pwd) done"
	done
fi
}
_COMBUILD_() {
COMPILSH="$(find "$RDR/sources/$SITENAME/$LOGINAME/$REPONAME" -type f -name compile.sh)"
if [[ -n "${COMPILSH:-}" ]]
then
	for COMPFILE in $COMPILSH
	do
		printf '%s\\' "compile.sh in directory ${COMPFILE%/*} begun"
		cd "${COMPFILE%/*}" ; pwd ; sh "$COMPFILE" ||:
		printf '%s\\' "compile.sh in directory $(pwd) done"
	done
fi
}
_CLONEBUILD_() {
	cd "$RDR/sources/$SITENAME/$LOGINAME" && git clone --depth 1 "$@" --single-branch && cd "$REPONAME" && (_IAR_ "$(pwd)" || _SIGNAL_ "135" "${0##*/} _CLONEBUILD_ _IAR_") && _COMBUILD_ && _ANTBUILD_ && "$RDR/scripts/bash/build/build.in.dir.bash"
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
	cd "$RDR/sources/$SITENAME/$LOGINAME/$REPONAME" && (_IAR_ "$(pwd)" || _SIGNAL_ "135" "${0##*/} _CLONEBUILD_ _IAR_")
	cd "$RDR/sources/$SITENAME/$LOGINAME/$REPONAME" && _COMBUILD_
	cd "$RDR/sources/$SITENAME/$LOGINAME/$REPONAME" && _ANTBUILD_
	cd "$RDR/sources/$SITENAME/$LOGINAME/$REPONAME" && "$RDR/scripts/bash/build/build.in.dir.bash"
elif [ -d "$RDR/sources/$SITENAME/$LOGINAME" ]
then
	_CLONEBUILD_ "$@"
else
	mkdir -p "$RDR/sources/$SITENAME/$LOGINAME"
	_CLONEBUILD_ "$@"
fi
printf '\n%s\n\n' "Please share information about new projects found at https://github.com/BuildAPKs/db.BuildAPKs/issues and https://github.com/BuildAPKs/db.BuildAPKs/pulls in order to help this project out."
# build.repo.bash OEF
