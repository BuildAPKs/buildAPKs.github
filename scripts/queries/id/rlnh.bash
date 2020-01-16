#!/usr/bin/env bash
# Copyright 2019-2020 (c)  all rights reserved by S D Rausty;  see LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
#####################################################################
set -eu
declare -a RATEARRAY
declare -i RLRESET
declare -i STIME
RATEARRAY=($(curl -is https://api.github.com/rate_limit | grep Rate)) # get rate information from Github 
printf "%s\\n" "Github rate limit information:"
printf "%s\\n" "${RATEARRAY[0]} ${RATEARRAY[1]}" # print rate information
printf "%s\\n" "${RATEARRAY[2]} ${RATEARRAY[3]}" # print rate information
printf "%s\\n" "${RATEARRAY[4]} ${RATEARRAY[5]}" # print rate information
RLRESET="$(tr -dc '[[:print:]]' <<< ${RATEARRAY[5]})" # strip nonprinting characters
STIME=$(date +%s)
MINR="$(((RLRESET - STIME)/60))"
printf "%s\\n" "$MINR minutes remaining"
# rlnh.bash EOF
