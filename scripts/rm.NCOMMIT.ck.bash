#!/usr/bin/env bash
# Copyright 2020 (c) all rights reserved by BuildAPKs, see LICENSE  
# Removes *.ck files that have an NCOMMIT flag.
################################################################################
set -eu 

_PRNT_ () {	# print message with one trialing newline
	printf "%s\\n" "$1"
}

_PRNT_ "Script ${0##*/} rm.NCOMMIT.ck.bash: STARTED..."
ARR=("$(find ./var/conf/*.ck)")
for i in $ARR
do
	if grep NCOMMIT "$i" 1>/dev/null
	then
		rm -f "$i" 
	fi
done
_PRNT_ "Script ${0##*/} rm.NCOMMIT.ck.bash: DONE"
# rm.NCOMMIT.ck.bash EOF
