#!/usr/bin/env bash
# Copyright 2020 (c) all rights reserved by BuildAPKs, see LICENSE  
# Removes *.ck files that have an NCOMMIT flag.
################################################################################
set -eu 
ARR=("$(find ./var/conf/*.ck)")
for i in $ARR
do
	if grep NCOMMIT "$i" 1>/dev/null
	then
		rm -f "$i" 
	fi
done
# rm.NCOMMIT.ck.bash EOF
