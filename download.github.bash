#!/usr/bin/env bash
# Copyright 2019-2022 (c) all rights reserved by BuildAPKs; see LICENSE
# https://buildapks.github.io published courtesy https://pages.github.com
################################################################################
set -Eeuo pipefail
shopt -s nullglob globstar
export RDR="$HOME/buildAPKs"
. "$RDR/scripts/bash/shlibs/trap.bash" 67 68 69 "${0##*/} build.github.bash"
. "$RDR/scripts/bash/init/ushlibs.bash"
_AND_ () { # write configuration file for git repository if an AndroidManifest.xml file is found in a git repository
	printf "%s\\n" "$COMMIT" > "$JDR/var/conf/$USER.${NAME##*/}.${COMMIT::7}.ck"
	printf "%s\\n" "0" >> "$JDR/var/conf/$USER.${NAME##*/}.${COMMIT::7}.ck"
	if [[ -z "${1:-}" ]]
	then
		printf "\\e[1;38;5;148m%s\\e[0m" "Found AndroidManifest.xml file in C C# C++ Haskell Java* Kotlin Lua Objective-C* Octave Pearl Python R* and/or Shell language repository $USER ${NAME##*/} ${COMMIT::7}; Writing ~/${RDR##*/}/sources/github/${JDR##*/}/var/conf/$USER.${NAME##*/}.${COMMIT::7}.ck file for git repository ${NAME##*/}; "
	else
		printf "\\e[1;38;5;148m%s\\e[0m" "Found AndroidManifest.xml file in C C# C++ Haskell Java* Kotlin Lua Objective-C* Octave Pearl Python R* and/or Shell language repository $USER ${NAME##*/} ${COMMIT::7}; Downloading ${NAME##*/} and writing ~/${RDR##*/}/sources/github/${JDR##*/}/var/conf/$USER.${NAME##*/}.${COMMIT::7}.ck file for git repository ${NAME##*/}; "
	fi
	_NAMESMAINBLOCK_ QNAMES
}

_ATT_ () {
	if [[ "$TCK" != 1 ]]
	then
		if [[ -d "$JDR/${NAME##*/}" ]] # directory exists
		then	# check if config file exits
			_IG_
		elif ! [[ -d "$JDR/${NAME##*/}" ]] # directory does not exist
		then
			printf "%s\\n" "Querying $USENAME $REPO ${COMMIT::7} for AndroidManifest.xml file:"
			if [[ "$COMMIT" != "" ]]
			then
				if [[ -z "${CULR:-}" ]]
				then
					if [[ "$OAUT" != "" ]]
					then
						ISAND="$(curl --fail --retry 2 -s -u "$OAUT" -i "https://api.github.com/repos/$USENAME/$REPO/git/trees/$COMMIT?recursive=1")" ||:
					else
	 					ISAND="$(curl --fail --retry 2 -s -i "https://api.github.com/repos/$USENAME/$REPO/git/trees/$COMMIT?recursive=1")" ||:
					fi
				else
					if [[ "$OAUT" != "" ]]
					then
						ISAND="$(curl --fail --retry 2 --limit-rate "$CULR" -s -u "$OAUT" -i "https://api.github.com/repos/$USENAME/$REPO/git/trees/$COMMIT?recursive=1")" ||:
					else
	 					ISAND="$(curl --fail --retry 2 --limit-rate "$CULR" -s -i "https://api.github.com/repos/$USENAME/$REPO/git/trees/$COMMIT?recursive=1")" ||:
					fi
				fi
			 	if grep AndroidManifest.xml <<< "$ISAND"
				then
					_AND_ 0
					_GTGF_
				else
					_NAND_
				fi
			fi
		fi
	fi
}

_ATTG_ () {
	if [[ "$TCK" != 1 ]]
	then
		if [[ -d "$JDR/${NAME##*/}" ]] # directory exists
		then
			_IG_
		else
			# clone git repository
			_GTGF_
		fi
	fi
}

_CKAT_ () {
	TCK=0
	REPO=$(awk -F/ '{print $NF}' <<< "$NAME") # redirect output to a variable
	if ! grep -iw "$REPO" "$RDR"/var/db/ANAMES # repository name is not found in ANAMES file
	then	# process copy and build repository
		NPCK="$(find "$JDR/var/conf/" -name "$USER.${NAME##*/}.???????.ck")" || _SIGNAL_ "58" "_CKAT_ NPCK" # check if file exists with wildcards
		for CKFILE in "$NPCK"
		do
		 	if [[ $CKFILE = "" ]] # configuration file is not found
		 	then
		 		printf "%s" "Checking $USENAME $REPO for last commit:  "
		  		COMMIT="$(_GC_)" ||:

				if [[ -z "${COMMIT:-}" ]]
				then
					printf "\\e[1;38;5;214m%s\\e[0m%s\\n" "Could NOT find a commit; " "Continuing..."
					COMMIT="NCOMMIT"
					_NAND_
				else
					printf "%s\\e[1;38;5;142m%s\\e[0m%s\\n" "Found commit " "${COMMIT::7}" "; Continuing..."
			 		_ATT_ || _SIGNAL_ "60" "_CKAT_ _ATT_"
					sleep 0."$(shuf -i 24-72 -n 1)"	# eases network latency
				fi
		 	else # load configuration information from file
		 		printf "%s" "Loading $USENAME $REPO config from ~/$(cut -d"/" -f7-99 <<< $CKFILE)  "
		 		COMMIT=$(head -n 1 "$NPCK") || _SIGNAL_ "62" "_CKAT_ COMMIT"
		  		TCK=$(tail -n 1  "$NPCK") || _SIGNAL_ "64" "_CKAT_ TCK"
				_PRINTCK_
		 		_ATTG_ || _SIGNAL_ "62" "_CKAT_ _ATTG_"
		 	fi
		done
	else
		printf "%s" "Not processing $REPO; listing found in ~/"${RDR##*/}"/var/db/ANAMES file. "
 	fi
}

_CUTE_ () { # check if USENAME is an organization or a user
	. "$RDR"/scripts/bash/shlibs/buildAPKs/bnchn.bash bch.st
	_RLREMING_
	if [[ $(grep -iw "$USENAME" "$RDR/var/db/log/GNAMES" | awk '{print $2}') == User ]] && [[ -f "$RDR/sources/github/users/$USER/profile" ]] && [[ -f "$RDR/sources/github/users/$USER/repos" ]] # found in GNAMES and is a user and files exist
	then	# assign user attributes to USENAME
		export ISUSER=users
		export ISOTUR=users
		export USENAME="$(grep -iw "$USENAME" "$RDR/var/db/log/GNAMES" | awk '{print $1}')"
		export JDR="$RDR/sources/github/$ISOTUR/$USER"
		export JID="github.$ISOTUR.$USER"
	elif [[ $(grep -iw "$USENAME" "$RDR/var/db/log/GNAMES" | awk '{print $2}') == Organization ]] && [[ -f "$RDR/sources/github/orgs/$USER/profile" ]] && [[ -f "$RDR/sources/github/orgs/$USER/repos" ]] # found in GNAMES and is an organization and files exist
	then 	# assign organization attributes to USENAME
		export ISUSER=users
		export ISOTUR=orgs
		export USENAME="$(grep -iw "$USENAME" "$RDR/var/db/log/GNAMES" | awk '{print $1}')"
		export JDR="$RDR/sources/github/$ISOTUR/$USER"
		export JID="github.$ISOTUR.$USER"
	else	# get login and type of login from GitHub
		if [[ "$OAUT" != "" ]] # see file .conf/GAUTH file for information
		then	# create array TYPE
			mapfile -t TYPE < <(curl -u "$OAUT" "https://api.github.com/users/$USENAME")
		else
			mapfile -t TYPE < <(curl "https://api.github.com/users/$USENAME")
		fi
		# test if array TYPE contains profile information
		if [[ "${TYPE[1]}" == *\"message\":\ \"Not\ Found\"* ]] # array TYPE contains string message\":\ \"Not\ Found
		then	# print message and exit
			printf "\\n\\e[1;38;5;185m%s\\e[0m\\n\\n" "Could not find a GitHub login with $USENAME:  Exiting..."
			exit 44
		fi
		# array TYPE is undefined
		(if [[ -z "${TYPE[17]}" ]]
		then	# print array TYPE, print message and exit
			printf "\\n\\e[1;38;5;185m%s\\e[0m\\n\\n" "${TYPE[@]}"
			_SIGNAL_ "68" "${TYPE[17]} undefined!" "68"
		fi) || (printf "\\n\\e[1;38;5;185m%s\\e[0m\\n\\n" "${TYPE[@]}" && _SIGNAL_ "70" "TYPE[17]: unbound variable" "70") # or print array TYPE, print message and exit
		export USENAME="$(printf "%s" "${TYPE[1]}" | sed 's/"//g' | sed 's/,//g' | awk '{print $2}')" || _SIGNAL_ "71" "_CUTE_ \$USENAME"
		export GHUID="$(printf "%s" "${TYPE[2]}" | sed 's/"//g' | sed 's/,//g' | awk '{print $2}')" || _SIGNAL_ "72" "_CUTE_ \$USENAME"
		NAPKS="$(printf "%s" "${TYPE[17]}" | sed 's/"//g' | sed 's/,//g' | awk '{print $2}')" || (_SIGNAL_ "74" "_CUTE_ \$NAPKS: create \$NAPKS failed; Exiting..." 24)
		if [[ "${TYPE[17]}" == *User* ]]
		then
			export ISUSER=users
			export ISOTUR=users
		else
			export ISUSER=users
			export ISOTUR=orgs
		fi
		export JDR="$RDR/sources/github/$ISOTUR/$USER"
		export JID="github.$ISOTUR.$USER"
		if [[ ! -d "$JDR" ]]
		then
			mkdir -p "$JDR"
		fi
		printf "%s\\n" "${TYPE[@]}" > "$JDR"/profile
		_MKJDC_
		_NAMESMAINBLOCK_ GNAMES log/GNAMES
		unset NAPKS
	fi
	printf "%s\\n" "Processing $USENAME:"
	KEYT=("\"login\"" "\"id\"" "\"type\"" "\"name\"" "\"company\"" "\"blog\"" "\"location\"" "\"hireable\"" "\"bio\"" "\"public_repos\"" "\"public_gists\"" "\"followers\"" "\"following\"" "\"created_at\"" )
	for KEYS in "${KEYT[@]}" # print selected information from profile file
	do
		grep "$KEYS" "$JDR/profile" | sed 's/\,//g' | sed 's/\"//g'
	done
	RCT="$(grep public_repos "$JDR/profile" | sed 's/\,//g' | sed 's/\"//g' | awk '{print $2}')" # repository count
	RPCT="$(($RCT/100))" # repository page count
	if [[ $(($RCT%100)) -gt 0 ]] # there is a remainder
	then	# add one more page to total reqest
		RPCT="$(($RPCT+1))"
	fi
	_MKJDC_
}

_GC_ () {
	if [[ "$OAUT" != "" ]]	# see .conf/GAUTH file for information
	then	# download only first few bytes of a source page
	 	curl --fail --retry 2 -u "$OAUT" https://api.github.com/repos/"$USER/$REPO"/commits -s 2>&1 | head -n 3 | tail -n 1 | awk '{ print $2 }' | sed 's/"//g' | sed 's/,//g'
	else
	 	curl --fail --retry 2 https://api.github.com/repos/"$USER/$REPO"/commits -s 2>&1 | head -n 3 | tail -n 1 | awk '{ print $2 }' | sed 's/"//g' | sed 's/,//g'
	fi
}

_GETREPOS_() {
	if [[ ! -f "$JDR/repos" ]]	# file repos does not exist
	then	# get repository information
		until [[ $RPCT -eq 0 ]] # there are zero pages remaining
		do	# get a page of repository information
			printf "%s\\n" "Downloading GitHub $USENAME page $RPCT repositories information: "
			if [[ -z "${CULR:-}" ]]	# curl --limit-rate is not set
			then
				if [[ "$OAUT" != "" ]]	# see .conf/GAUTH file for information
				then
					curl --fail --retry 2 -u "$OAUT" "https://api.github.com/$ISUSER/$USER/repos?per_page=100&page=$RPCT" > "$JDR/var/conf/repos.tmp"
					cat "$JDR/var/conf/repos.tmp" >> "$JDR/repos"
				else
					curl --fail --retry 2 "https://api.github.com/$ISUSER/$USER/repos?per_page=100&page=$RPCT" > "$JDR/var/conf/repos.tmp"
					cat "$JDR/var/conf/repos.tmp" >> "$JDR/repos"
				fi
			else
				if [[ "$OAUT" != "" ]]
				then
					curl --fail --retry 2 --limit-rate "$CULR" -u "$OAUT" "https://api.github.com/$ISUSER/$USER/repos?per_page=100&page=$RPCT" > "$JDR/var/conf/repos.tmp"
					cat "$JDR/var/conf/repos.tmp" >> "$JDR/repos"
				else
					curl --fail --retry 2 --limit-rate "$CULR" "https://api.github.com/$ISUSER/$USER/repos?per_page=100&page=$RPCT" > "$JDR/var/conf/repos.tmp"
					cat "$JDR/var/conf/repos.tmp" >> "$JDR/repos"
				fi
			fi
			rm -f "$JDR"/var/conf/repos.tmp
			RPCT="$(($RPCT-1))"
		done
	fi
}

_GTGF_ () {	# clone git repository
	NAME="${NAME/#https/git}"
	if [[ -f "$JDR/var/conf/$USER.${NAME##*/}.${COMMIT::7}.br" ]]
	then
		RBRANCH="$( tail -n 1 "$JDR/var/conf/$USER.${NAME##*/}.${COMMIT::7}.br" )"
	else
		printf "%s\\n" "Checking HEAD branch in $NAME..."
		RBRANCH="$( git remote show $NAME | grep "HEAD branch" | cut -d ":" -f 2 )"
		RBRANCH="${RBRANCH# }" # strip leading space
		printf "%s\\n%s\\n" "$COMMIT" "$RBRANCH" > "$JDR/var/conf/$USER.${NAME##*/}.${COMMIT::7}.br"
	fi
	printf "%s\\n" "Getting branch $RBRANCH from git repository $NAME..."
	( ( git clone --depth 1 "$NAME" --branch $RBRANCH --single-branch ; cd ${NAME##*/} ; git fsck ; cd $JDR ) || ( cd $JDR && _SIGNAL_ "32" "_GTGF_ git clone" )
	_IAR_ "$JDR/${NAME##*/}" || _SIGNAL_ "34" "_GTGF_ _IAR_"
}

_IG_ () { # do nothing if config file is correct
	if grep "${NAME##*/}" "${NAME##*/}"/.git/config 1>/dev/null
	then
		printf "%s\\n\\n" "Found clone of git repository ${NAME##*/}: Continuing..."
	else	# get repository
		_GTGF_
	fi
}

_MAINGITHUB_ () {
	if [[ -z "${NUM:-}" ]]
	then
		export NUM="$(date +%s)"
	fi
	export USENAME="${UONE##*/}"
	export USER="${USENAME,,}"
	export OAUT="$(awk 'NR==1' "$RDR/.conf/GAUTH")" # load login:token key from .conf/GAUTH file, see the GAUTH file for more information to enable OAUTH authentication
	export WRAMES=0
	printf "\\n\\e[1;38;5;116m%s\\n\\e[0m" "${0##*/}: Beginning BuildAPKs with build.github.bash $@:"
	. "$RDR"/scripts/bash/shlibs/buildAPKs/fandm.bash
	. "$RDR"/scripts/bash/shlibs/buildAPKs/prep.bash
	. "$RDR"/scripts/sh/shlibs/buildAPKs/fapks.sh
	. "$RDR"/scripts/sh/shlibs/buildAPKs/names.sh 0
	. "$RDR"/scripts/sh/shlibs/mkfiles.sh
	. "$RDR"/scripts/sh/shlibs/mkdirs.sh
	# create directories in RDR if not exist
	_MKDIRS_ "bin" "opt" "tmp" "var/cache/lib" "var/cache/lib/res-appcompat" "var/cache/lib/res-cardview" "var/cache/lib/res-design" "var/cache/lib/res-recyclerview" "var/cache/stash" "var/cache/tarballs" "var/db" "var/db/log" "var/lock" "var/log/github/orgs" "var/log/github/users" "var/log/messages" "var/log/messages" "var/run/lock/auth" "var/run/lock/wake" "var/tmp"
	# create files in RDR/var if not exist
	_MKVFILES_ "db/ANAMES" "db/BNAMES" "db/B10NAMES" "db/B100NAMES" "db/GNAMES" "db/ONAMES" "db/QNAMES" "db/RNAMES" "db/XNAMES" "db/YNAMES" "db/ZNAMES" "db/log/BNAMES" "db/log/B10NAMES" "db/log/B100NAMES" "db/log/GNAMES"
	if grep -i "^$USENAME$" "$RDR"/var/db/[PRXYZ]NAMES
	then	# create null directory, profile, repos files, and exit
		if grep -i "^$USENAME$" "$RDR"/var/db/ONAMES 1>/dev/null
		then
			JDR="$RDR/sources/github/orgs/$USER"
		else
			JDR="$RDR/sources/github/users/$USER"
		fi
		mkdir -p "$JDR" # create null directory
		touch "$JDR"/profile # create null profile file
		touch "$JDR"/repos # create null repos file
		printf "\\e[7;38;5;204mUsername %s is found in %s: NOT processing download and build for username %s!  Remove the login from the corresponding file(s) and the account's build directory in %s if an empty directory was created to process %s.  Then run \` %s \` again to attempt to build %s's APK projects, if any.  File %s has more information:\\e[0m\\n" "$USENAME" "~/${RDR##*/}/var/db/[PRXYZ]NAMES" "$USENAME" "~/${RDR##*/}/sources/github/{orgs,users}" "$USENAME" "${0##*/} $USENAME" "$USENAME" "~/${RDR##*/}/var/db/README.md"
		awk 'NR>=20 && NR<=46' "$RDR/opt/db/README.md" || _SIGNAL_ "86" "awk 'NR>=16 && NR<=46' $RDR/opt/db/README.md _MAINGITHUB_"
		printf "\\e[7;38;5;203m%s is found in %s: NOT processing download and build for username %s!  Remove the username from the corresponding file(s) and the account's build directory in %s if an empty directory was created to process %s.  Then run \` %s \` again to attempt to build %s's APK projects, if any.  Scroll up to read information from the %s file.\\e[0m\\n" "$USENAME" "$(grep -i "^$USENAME$" "$RDR"/var/db/[PRXYZ]NAMES)" "$USENAME" "~/${RDR##*/}/sources/github/{orgs,users}" "$USENAME" "${0##*/} $USENAME" "$USENAME" "~/${RDR##*/}/var/db/README.md"
		exit 0
	else	# check whether login is a user or an organization
		_CUTE_
	fi
	_WAKELOCK_
	_GETREPOS_
	_PRINTJS_
	JARR=($(grep -B 5 -e "\"\:\ \"Java" -e "\"\:\ \"Objective-C" -e "\"\:\ \"R" -e "\"\:\ \"C\"" -e "\"\:\ \"C#\"" -e "\"\:\ \"C++\"" -e "\"\:\ \"Haskell"\" -e "\"\:\ \"Kotlin"\" -e "\"\:\ \"Lua"\" -e "\"\:\ null" -e "\"\:\ \"Octave"\" -e "\"\:\ \"Pearl"\" -e "\"\:\ \"Python"\" -e "\"\:\ \"Shell\"" "$JDR/repos" | grep svn_url | awk -v x=2 '{print $x}' | sed 's/\,//g' | sed 's/\"//g')) || _SIGNAL_ "88" "create JARR ${0##*/} build.github.bash" # create array of C C# C++ Haskell Java* Kotlin Lua Objective-C* Octave Pearl Python R* and Shell language repositories
	_PRINTJD_
	if [[ "${JARR[@]}" == *ERROR* ]]
	then
		_NAMESMAINBLOCK_ ZNAMES
		_SIGNAL_ "90" "search for ERROR in JARR ${0##*/} build.github.bash" "90"
	fi
	F1AR=($(find "$JDR" -maxdepth 1 -type d)) # create array of JDR contents
	cd "$JDR"
	_PRINTAS_
	for NAME in "${JARR[@]}"
	do
		_CKAT_
	done
	_PRINTJD_
	. "$RDR"/scripts/bash/shlibs/buildAPKs/bnchn.bash bch.gt
}

_MKJDC_ () { # create JDR/var/conf directory which contains query for \` AndroidManifest.xml \` files at GitHub USENAME repositores results.
	if [ ! -d "$JDR/var/conf" ]
	then
		mkdir -p "$JDR/var/conf"
		printf "%s\\n" "	README.md for $JDR/var/conf

	This directory contains results for query for \` AndroidManifest.xml \` files at $USENAME\'s GitHub repositores.  The following files are created in $JDR/var/conf and their purpose is outlined here:

	| File Name | Purpose |
	-----------------------
	| *.br      | Results from check for HEAD branch. |
	| *.ck      | Results from query for commit and AndroidManifest.xml file. |
	| APKSN.db  | The names of the APKs that were built on device with BuildAPKs. |
	| DS.db     | $USENAME\'s GitHub repositores download size. |
	| NAMES.db  | Files processed in ~/buildAPKs/var/db/*NAMES;  Remove this file to reprocess $USENAME through ~/buildAPKs/var/db/*NAMES upon subsequent builds. |
	| NAMFS.db  | How many AndroidManifest.xml files were found in $USENAME\'s git repositories. |
	| NAPKS.db  | The number of APKs that were built on device with BuildAPKs. |

<!-- README.md EOF -->" > "$JDR/var/conf/README.md"
	fi
}

_NAND_ () { # write configuration file for repository if AndroidManifest.xml file is NOT found in git repository
	printf "%s\\n" "$COMMIT" > "$JDR/var/conf/$USER.${NAME##*/}.${COMMIT::7}.ck"
	printf "%s\\n" "1" >> "$JDR/var/conf/$USER.${NAME##*/}.${COMMIT::7}.ck"
	printf "\\n\\e[1;38;5;185m%s\\e[0m\\n\\n" "Could not find an AndroidManifest.xml file in C C# C++ Haskell Java* Kotlin Lua Objective-C* Octave Pearl Python R* and/or Shell language repository $USER ${NAME##*/} ${COMMIT::7}:  NOT downloading ${NAME##*/}."
}

_PRINTAS_ () {
	printf "\\e[1;34mSearching for AndroidManifest.xml files:\\e[0m\\n"'\033]2;Searching for AndroidManifest.xml files: OK\007'
}

_PRINTCK_ () {
	if [[ "$TCK" = 1 ]]
	then
		printf "\\e[1;38;5;185m%s\\e[0m\\n\\n" "WARNING AndroidManifest.xml file not found; Continuing..."
	else
		printf "\\e[1;38;5;148m%s\\e[0m\\n\\n" "File AndroidManifest.xml found; Continuing..."
	fi
}

_PRINTJD_ () {
	printf "\\e[1;32mDONE\\e[0m\\n"
}

_PRINTJS_ () {
	printf "\\n\\e[1;34mSearching for C C# C++ Haskell Java* Kotlin Lua Objective-C* Octave Pearl Python R* and Shell language repositories: "'\033]2;Searching for C C# C++ Haskell Java* Kotlin Lua Objective-C* Octave Pearl Python R* and Shell language repositories: OK\007'
}

_RLREMING_ () { # print GitHub rate limit
	if [[ $(awk 'NR==1' "$RDR/.conf/DRLIM") == "true" ]]
	then	# get rate limit information from GitHub
		printf "\\e[2;7;38;5;144m%s\\e[0m\\n" "GitHub rate limit information:"
		printf "%s\\e[0m\\n" "$(curl -is https://api.github.com/rate_limit | grep Ratelimit)" || printf "%s\\n" "Could not get rate limit information from GitHub."
		[ "$OAUT" != "" ]  && printf "\\e[2;7;38;5;148m%s\\e[0m\\n\\n" "OAUTH token $OAUT is enabled; Continuing..." || printf "\\e[2;7;38;5;150m%s\\e[0m\\n\\n" "Change true to false in file ~/${RDR##*/}/.conf/DRLIM to disable rate limit check.  File ~/${RDR##*/}/.conf/GAUTH has more information about rate limit; Continuing..." # print information about the RDR/.conf/GAUTH file
	fi
}

if [[ -z "${1:-}" ]] # no argument is given
then	# print message and exit
	printf "\\e[1;7;38;5;204m%s\\e[1;7;38;5;201m%s\\e[1;7;38;5;204m%s\\e[1;7;38;5;201m%s\\e[1;7;38;5;204m%s\\e[1;7;38;5;201m%s\\e[1;7;38;5;204m%s\\n\\e[0m\\n" "GitHub username must be provided;  File " "~/${RDR##*/}/opt/db/UNAMES" " lists usernames that build APKs on device with BuildAPKs!  To attempt to build all the usernames contained in this file run " "for NAME in \$(cat ~/${RDR##*/}/opt/db/UNAMES) ; do ~/${RDR##*/}/${0##*/} \$NAME ; done" ".  File " "~/${RDR##*/}/.conf/GAUTH" " has information about bandwidth supplied by GitHub should this for loop command be run. "
	exit 68
fi
export UONE="${1%/}" # https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion
if [[ ! -z "${2:-}" ]] # a second argument is given
then	# check if the second argument begins with with the letter c: [[c]url rate] limit download transmission rate for curl.
	if [[ "${2//-}" = [Cc]* ]] # the second argument begins with the letter c
	then	# the third argument is required, e.g. [512] [1024] [2048]
		if [[ ! -z "${3:-}" ]] && ! [[ "$3" =~ [^[:digit:]] ]] # the third argument is defined and is composed of only digits
		then	# use argument $3 and limit download transmission rate for curl
 			CULR="$3"
 			_MAINGITHUB_ "$*"
		else	# print numerical message and exit
			printf "\\e[0;31m%s\\e[1;31m%s\\e[0;31m%s\\e[1;31m%s\\e[0;31m%s\\e[7;31m%s\\e[0m\\n" "Add a numerical rate limit to " "${0##*/} $1 $2 " "as the third argument to continue with curl --rate-limit, i.e. " "${0##*/} $1 $2 16384" ":" " Exiting..."
			exit 64
		fi
	else	# print curl with rate limiting message and exit
		printf "\\e[0;31m%s\\e[1;31m%s\\e[0;31m%s\\e[1;31m%s\\e[0;31m%s\\e[7;31m%s\\e[0m\\n" "To use curl with rate limiting add a numerical rate limit to " "${0##*/} $1 curl " "as the third argument to continue with curl --rate-limit, i.e. " "${0##*/} $1 curl 16384" ":" " Exiting..."
		exit 66
	fi
else	# process GitHub login
 	_MAINGITHUB_ "$@"
fi
printf '\n%s\n\n' "Please share information about new projects found at https://github.com/BuildAPKs/db.BuildAPKs/issues and https://github.com/BuildAPKs/db.BuildAPKs/pulls in order to help this project out."
# download.github.bash OEF
