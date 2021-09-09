#!/usr/bin/env bash
# Copyright 2021 (c) all rights reserved by BuildAPKs; see LICENSE
# https://buildapks.github.io published courtesy https://pages.github.com
################################################################################
set -eu
shopt -s nullglob globstar
export RDR="$HOME/buildAPKs"
if [ $# = 0 ]
then # print help
	printf "\\n%s\\n\\n%s\\n%s\\n%s\\n\\n%s\\n\\n" "The ${0##*/} command has been tested with https://code.google.com successfully.  Share addresses to sourcecode at https://github.com/BuildAPKs in order to help develop this software if you find APK repo candidates for inclusion." "EXAMPLE USAGES:" "	${0##*/} https://code.google.com/p/apps-for-android" "	${0##*/} https://code.google.com/archive/p/permission-explorer" "If you find repo candidates for inclusion, please share addresses to sourcecode at https://github.com/BuildAPKs/db.BuildAPKs in order to help develop this software.  Thank you for using ${0##*/};  Enjoy🎵🎶"
	exit
fi
CGREPONAME="${1##*/}" # strip before last slash
if [ ! -d "$RDR/sources/code.google.com/" ]
then
	mkdir -p "$RDR/sources/code.google.com/"
fi
cd "$RDR/sources/code.google.com/"
if [ ! -f "$CGREPONAME.archive.zip" ]
then
	wget "https://storage.googleapis.com/google-code-archive-source/v2/code.google.com/$CGREPONAME/source-archive.zip" -O "$CGREPONAME.archive.zip"
fi
if [ ! -d "$CGREPONAME" ]
then
unzip "$CGREPONAME.archive.zip"
fi
cd "$CGREPONAME"
"$RDR/bin/build.in.dir.bash"
printf '\n%s\n\n' "Please share information about new projects found at https://github.com/BuildAPKs/db.BuildAPKs/issues and https://github.com/BuildAPKs/db.BuildAPKs/pulls in order to help this project out."
# build.code.google.com.bash EOF
