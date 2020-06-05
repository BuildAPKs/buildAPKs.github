#!/usr/bin/env bash
# Copyright 2019-2020 (c) all rights reserved by BuildAPKs, see LICENSE  
# Removes *.ck files that have a NCOMMIT flag.
################################################################################
set -eu 
ARR=("$(find ./var/conf/*.ck)")
for i in $ARR
do
	if grep NCOMMIT "$i" 
	then
		rm -f "$i" 
	fi
done
# rm.NCOMMIT.ck.bash EOF
