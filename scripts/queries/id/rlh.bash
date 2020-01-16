#!/usr/bin/env bash
# Copyright 2019-2020 (c)  all rights reserved by S D Rausty;  see LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
#####################################################################
set -eu
declare -a RATEARRAY
declare -i RLRESET
declare -i STIME
GLOGIN="$(head -1 ~/buildAPKs/.conf/GAUTH | awk -F':' '{print $1}')" # get login name from file
RATEARRAY=($(curl -is https://api.github.com/users/$GLOGIN | grep Rate)) # get rate information for Github login 
printf "%s\\n" "Rate limit information for Github login $GLOGIN:"
printf "%s\\n" "${RATEARRAY[0]} ${RATEARRAY[1]}" # print rate information for Github login 
printf "%s\\n" "${RATEARRAY[2]} ${RATEARRAY[3]}" # print rate information for Github login 
printf "%s\\n" "${RATEARRAY[4]} ${RATEARRAY[5]}" # print rate information for Github login 
RLRESET="$(tr -dc '[[:print:]]' <<< ${RATEARRAY[5]})" # strip nonprinting charecters
STIME=$(date +%s)
MINR="$(((RLRESET - STIME)/60))"
printf "%s\\n" "$MINR minutes remaining"
# rlh.bash EOF
