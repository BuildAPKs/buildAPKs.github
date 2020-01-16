#!/usr/bin/env bash
# Copyright 2019-2020 (c) all rights reserved by BuildAPKs see LICENSE
# buildapks.github.io/buildAPKs published courtesy pages.github.com
#####################################################################
set -Eeuo pipefail
shopt -s nullglob globstar
export RDR="$HOME/buildAPKs"
. "$RDR"/scripts/bash/init/ushlibs.bash
. "$RDR"/scripts/bash/shlibs/trap.bash 67 68 69 "${0##*/} build.github.bash"
_AND_ () { # write configuration file for git repository tarball if AndroidManifest.xml file is found in git repository
	printf "%s\\n" "$COMMIT" > "$JDR/var/conf/$USER.${NAME##*/}.${COMMIT::7}.ck"
	printf "%s\\n" "0" >> "$JDR/var/conf/$USER.${NAME##*/}.${COMMIT::7}.ck"
	if [[ -z "${1:-}" ]] 
	then
		printf "\\e[1;38;5;148m%s\\e[0m" "Found AndroidManifest.xml file in C C# C++ Haskell Java* Kotlin Lua Objective-C* Octave Pearl Python R* and/or Shell language repository $USER ${NAME##*/} ${COMMIT::7}; Writing ~/${RDR##*/}/sources/github/${JDR##*/}/var/conf/$USER.${NAME##*/}.${COMMIT::7}.ck file for git repository ${NAME##*/}; "
	else
		printf "\\e[1;38;5;148m%s\\e[0m" "Found AndroidManifest.xml file in C C# C++ Haskell Java* Kotlin Lua Objective-C* Octave Pearl Python R* and/or Shell language repository $USER ${NAME##*/} ${COMMIT::7}; Downloading ${NAME##*/} tarball and writing ~/${RDR##*/}/sources/github/${JDR##*/}/var/conf/$USER.${NAME##*/}.${COMMIT::7}.ck file for git repository ${NAME##*/}; "
	fi
	_NAMESMAINBLOCK_ QNAMES
}

_ATT_ () {
	if [[ "$CK" != 1 ]]
	then
		if [[ ! -f "${NAME##*/}.${COMMIT::7}.tar.gz" ]] # tar file does not exist
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
					_BUILDAPKS_
				else
					_NAND_
				fi
			fi
		# check if bash array F1AR contains value NAME
		elif [[ -f "${NAME##*/}.${COMMIT::7}.tar.gz" ]] && [[ ! "${F1AR[@]}" =~ "${NAME##*/}" ]] # tarfile exists and directory does NOT exist
		then
			_AND_
			_FJDX_ 
		elif [[ -f "${NAME##*/}.${COMMIT::7}.tar.gz" ]] && [[ "${F1AR[@]}" =~ "${NAME##*/}" ]] # tarfile and directory exist
		then
			_AND_
			export SFX="$(tar tf "${NAME##*/}.${COMMIT::7}.tar.gz" | awk 'NR==1' )" || _SIGNAL_ "24" "_ATT_ SFX"
		fi
	fi
}

_BUILDAPKS_ () { # https://developer.github.com/v3/repos/commits/
	printf "\\n%s\\n" "Getting $NAME/tarball/$COMMIT -o ${NAME##*/}.${COMMIT::7}.tar.gz:"
	if [[ -z "${CULR:-}" ]]
	then
		if [[ "$OAUT" != "" ]] # see .conf/GAUTH file 
		then
			curl --fail --retry 2 -u "$OAUT" -L "$NAME/tarball/$COMMIT" -o "${NAME##*/}.${COMMIT::7}.tar.gz" || _SIGNAL_ "30" "_BUILDAPKS_ curl"
		else
			curl --fail --retry 2 -L "$NAME/tarball/$COMMIT" -o "${NAME##*/}.${COMMIT::7}.tar.gz" || _SIGNAL_ "32" "_BUILDAPKS_ curl"
		fi
	else
		if [[ "$OAUT" != "" ]] # see .conf/GAUTH file 
		then
			curl --fail --retry 2 --limit-rate "$CULR" -u "$OAUT" -L "$NAME/tarball/$COMMIT" -o "${NAME##*/}.${COMMIT::7}.tar.gz" || _SIGNAL_ "40" "_BUILDAPKS_ curl"
		else
			curl --fail --retry 2 --limit-rate "$CULR" -L "$NAME/tarball/$COMMIT" -o "${NAME##*/}.${COMMIT::7}.tar.gz" || _SIGNAL_ "42" "_BUILDAPKS_ curl"
		fi
	fi
	_FJDX_ 
}

_CKAT_ () {
	_MKJDC_ 
	CK=0
	REPO=$(awk -F/ '{print $NF}' <<< "$NAME") # redirect output to a variable 
	if ! grep -iw "$REPO" "$RDR"/var/db/ANAMES # repository name is not found in ANAMES file
	then	# process copy and build repository 
		NPCK="$(find "$JDR/var/conf/" -name "$USER.${NAME##*/}.???????.ck")" ||: # check if file exists with wildcards
		for CKFILE in "$NPCK" 
		do
		 	if [[ $CKFILE = "" ]] # configuration file is not found
		 	then
		 		printf "%s" "Checking $USENAME $REPO for last commit:  " 
		  		COMMIT="$(_GC_)" ||:
				printf "%s\\e[1;38;5;142m%s\\e[0m%s\\n" "Found commit " "${COMMIT::7}" "; Continuing..."
		 		_ATT_ || _SIGNAL_ "60" "_CKAT_ _ATT_"
				sleep 0.$(shuf -i 24-72 -n 1)	# eases network latency
		 	else # load configuration information from file 
		 		printf "%s" "Loading $USENAME $REPO config from $CKFILE:  "
		 		COMMIT=$(head -n 1 "$NPCK") || _SIGNAL_ "62" "_CKAT_ COMMIT"
		  		CK=$(tail -n 1  "$NPCK") || _SIGNAL_ "64" "_CKAT_ CK"
				_PRINTCK_ 
		 	fi
			export CK=0
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
		then	# echo array TYPE, print message and exit
			echo "${TYPE[@]}"  
			_SIGNAL_ "68" "${TYPE[17]} undefined!" "68"
		fi) || (echo "${TYPE[@]}" && _SIGNAL_ "70" "TYPE[17]: unbound variable" "70") # or echo array TYPE, print message and exit
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
}

_GETREPOS_() {
	if [[ ! -f "$JDR/repos" ]] # file repos does not exist 
	then	# get repository information
		until [[ $RPCT -eq 0 ]] # there are zero pages remaining
		do	# get a page of repository information
			printf "%s\\n" "Downloading GitHub $USENAME page $RPCT repositories information: "
			if [[ -z "${CULR:-}" ]] # curl --limit-rate is not set
			then
				if [[ "$OAUT" != "" ]] # see .conf/GAUTH file for information 
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

_MKJDC_ () { # create JDR/var/conf directory contains query for \` AndroidManifest.xml \` files in GitHub USENAME repositores results. 
	if [ ! -d "$JDR/var/conf" ]
	then
		mkdir -p "$JDR/var/conf"
	fi
	if [ ! -d "$JDR/var/conf" ]
	then
	printf "%s\\n\\n" "This directory contains query for \` AndroidManifest.xml \` files in GitHub $USENAME repositores results.  The following files are created in ${USENAME,,}/var/conf and their purpose is outlined here:
	| file name | purpose |
	-----------------------
	| *.ck      | results from query for commit and AndroidManifest.xml file(s) | 
	| NAMES.db  | var/db/*NAMES* files processed through var/db/*NAMES;  Remove this file to reprocess login through var/db/*NAMES upon susequent build. | 
	| NAMFS.db  | The number of AndroidManifest.xml files that were found at login https://github.com/$USENAME. | 
	| NAPKS.db  | The number of APKs that were built on device with BuildAPKs. |  " > "$JDR/var/conf/README.md" 
	fi
}

_FJDX_ () { 
	export SFX="$(tar tf "${NAME##*/}.${COMMIT::7}.tar.gz" | awk 'NR==1' )" || _SIGNAL_ "82" "_FJDX_"
	printf "\\e[1;38;5;148m%s\\e[0m\\n" "Running \` tar xvf ${NAME##*/}.${COMMIT::7}.tar.gz | grep AndroidManifest.xml \`:"
	(tar xvf "${NAME##*/}.${COMMIT::7}.tar.gz" | grep AndroidManifest.xml || _SIGNAL_ "84" "_FJDX_") ; _IAR_ "$JDR/$SFX" || _SIGNAL_ "84" "_FJDX_"
}

_GC_ () { 
	if [[ "$OAUT" != "" ]] # see .conf/GAUTH file for information  
	then # download only first few bytes of a source page
	 	curl --fail --retry 2 -u "$OAUT" https://api.github.com/repos/"$USER/$REPO"/commits -s 2>&1 | head -n 3 | tail -n 1 | awk '{ print $2 }' | sed 's/"//g' | sed 's/,//g' 
	else
	 	curl --fail --retry 2 https://api.github.com/repos/"$USER/$REPO"/commits -s 2>&1 | head -n 3 | tail -n 1 | awk '{ print $2 }' | sed 's/"//g' | sed 's/,//g' 
	fi
}

_MAINGITHUB_ () {
	if [[ -z "${NUM:-}" ]] 
	then
		export NUM="$(date +%s)"
	fi
	export USENAME="${UONE##*/}"
	export USER="${USENAME,,}"
	export OAUT="$(cat "$RDR/.conf/GAUTH" | awk 'NR==1')" # load login:token key from .conf/GAUTH file, see the GAUTH file for more information to enable OAUTH authentication
	export WRAMES=0
	printf "\\n\\e[1;38;5;116m%s\\n\\e[0m" "${0##*/}: Beginning BuildAPKs with build.github.bash $@:"
	. "$RDR"/scripts/bash/shlibs/buildAPKs/fandm.bash
	. "$RDR"/scripts/bash/shlibs/buildAPKs/prep.bash
	. "$RDR"/scripts/sh/shlibs/buildAPKs/fapks.sh
	. "$RDR"/scripts/sh/shlibs/buildAPKs/names.sh 0
	. "$RDR"/scripts/sh/shlibs/mkfiles.sh
	. "$RDR"/scripts/sh/shlibs/mkdirs.sh
	_MKRDIRS_ "opt"
	_MKDIRS_ "db" "cache/lib" "cache/lib/res-appcompat" "cache/lib/res-cardview" "cache/lib/res-design" "cache/lib/res-recyclerview" "cache/stash" "cache/tarballs" "db" "db/log" "log/messages"
	_MKFILES_ "db/ANAMES" "db/BNAMES" "db/B10NAMES" "db/B100NAMES" "db/GNAMES" "db/ONAMES" "db/QNAMES" "db/RNAMES" "db/XNAMES" "db/YNAMES" "db/ZNAMES" "db/log/BNAMES" "db/log/B10NAMES" "db/log/B100NAMES" "db/log/GNAMES"
	if grep -Hiw "$USENAME" "$RDR"/var/db/[PRXYZ]NAMES
	then	# create null directory, profile, repos files, and exit
		if grep -iw "$USENAME" "$RDR"/var/db/ONAMES 1>/dev/null
		then
			JDR="$RDR/sources/github/orgs/$USER"
		else
			JDR="$RDR/sources/github/users/$USER"
		fi
		mkdir -p "$JDR" # create null directory
		touch "$JDR"/profile # create null profile file 
		touch "$JDR"/repos # create null repos file 
		printf "\\e[7;38;5;204mUsername %s is found in %s: NOT processing download and build for username %s!  Remove the login from the corresponding file(s) and the account's build directory in %s if an empty directory was created to process %s.  Then run \` %s \` again to attempt to build %s's APK projects, if any.  File %s has more information:\\e[0m\\n" "$USENAME" "~/${RDR##*/}/var/db/[PRXYZ]NAMES" "$USENAME" "~/${RDR##*/}/sources/github/{orgs,users}" "$USENAME" "${0##*/} $USENAME" "$USENAME" "~/${RDR##*/}/var/db/README.md" 
		awk 'NR>=16 && NR<=44' "$RDR/opt/db/README.md" || _SIGNAL_ "86" "\` awk 'NR>=16 && NR<=42' $RDR/opt/db/README.md \` _MAINGITHUB_"
		printf "\\e[7;38;5;203m%s is found in %s: NOT processing download and build for username %s!  Remove the username from the corresponding file(s) and the account's build directory in %s if an empty directory was created to process %s.  Then run \` %s \` again to attempt to build %s's APK projects, if any.  Scroll up to read information from the %s file.\\e[0m\\n" "$USENAME" "$(grep -Hiw "$USENAME" "$RDR"/var/db/[PRXYZ]NAMES)" "$USENAME" "~/${RDR##*/}/sources/github/{orgs,users}" "$USENAME" "${0##*/} $USENAME" "$USENAME" "~/${RDR##*/}/var/db/README.md" 
		exit 0 # and exit
	else	# check whether login is a user or an organization
		_CUTE_
	fi
	_WAKELOCK_
	_GETREPOS_
	_PRINTJS_
	JARR=($(grep -B 5 -e "\"\:\ \"Java" -e "\"\:\ \"Objective-C" -e "\"\:\ \"R" -e "\"\:\ \"C\"" -e "\"\:\ \"C#\"" -e "\"\:\ \"C++\"" -e "\"\:\ \"Haskell"\" -e "\"\:\ \"Kotlin"\" -e "\"\:\ \"Lua"\" -e "\"\:\ \"Octave"\" -e "\"\:\ \"Pearl"\" -e "\"\:\ \"Python"\" -e "\"\:\ \"Shell\"" "$JDR/repos" | grep svn_url | awk -v x=2 '{print $x}' | sed 's/\,//g' | sed 's/\"//g')) || _SIGNAL_ "88" "create JARR ${0##*/} build.github.bash" # create array of C C# C++ Haskell Java* Kotlin Lua Objective-C* Octave Pearl Python R* and Shell language repositories
	_PRINTJD_
	if [[ "${JARR[@]}" == *ERROR* ]]
	then
		_NAMESMAINBLOCK_ ZNAMES
		_SIGNAL_ "90" "search for ERROR in JARR ${0##*/} build.github.bash" "4"
	fi
	F1AR=($(find "$JDR" -maxdepth 1 -type d)) # creates array of JDR contents 
	cd "$JDR"
	_PRINTAS_
	for NAME in "${JARR[@]}" # lets you delete partial downloads and repopulates a JDR directory from remote source.  Directories can be deleted, too.  They are repopulated from the downloaded tarballs.  
	do	# This creates a "slate" within each ~/buildAPKs/sources/github/{orgs,users}/JDR folder that can be selectively reset.  This can be important on a slow connection that might yield incomplete download results on a first attempt to download and build multiple APKs from remote source code.  
		# To populate a partially downloaded JDR folder without deleting everything that was downloaded remove the ~/buildAPKs/sources/github/{orgs,users}/JDR/var directory which this script creates.  The unpacked tarball directories which correspond to individual repositories can be deleted to reset a JDR directory as well.  This can be accomplished with one find command ` find . -maxdepth 1 -type d -exec rm -rf {} \; ` issued in the JDR folder.  Checking the integity of multiple tarballs is automated with ` ~/buildAPKs/scripts/maintenance/delete.corrupt.tars.sh ls ` which should be excecuted in the same JDR directory to check for tarball errors.  If a corrupt tarball is found by ` delete.corrupt.tars.sh `, it will be deleted.  
		# Run ` build.github.bash login [curl rate] ` and the logins you are trying to download might download easier if you are encountering difficulties downloading.  This information regards extremely fast and very slow connections, i.e. slower than 14400 baud and 4G at max speed.  Rate limiting is also effective on very high speed connections.  See ` grep -hrC 4 sleep ~/buildAPKs/scripts ` to view how buildAPKs handles device and network latency.  Excessive latency breaks downloads. 
		# If you have trouble while downloading APK source code repositories, better results might be found downloading the many files ` build.github.bash ` can request when searching for source code and downloading source code tarball files with rate limiting enabled than without rate limiting.
		# An example is provided for convenience; ` build.github.bash https://github.com/BuildAPKs c 33600 ` will throttle the download rate for ` curl ` to 33600.  It will take a long time to attempt to download everything that has an AndroidManifest.xml file from BuildAPKs at GitHub at this speed as some of the repositories are quite large.  Experimenting with the rate limit speed is recommended as devices, connections and the time of day are all fairly unique and factors for a successful download and build on device.
		_CKAT_ 
	done
	_PRINTJD_
	_RLREMING_
	_ANDB_ 
	_APKBC_
	. "$RDR"/scripts/bash/shlibs/buildAPKs/bnchn.bash bch.gt 
}

_NAND_ () { # write configuration file for repository if AndroidManifest.xml file is NOT found in git repository
	printf "%s\\n" "$COMMIT" > "$JDR/var/conf/$USER.${NAME##*/}.${COMMIT::7}.ck"
	printf "%s\\n" "1" >> "$JDR/var/conf/$USER.${NAME##*/}.${COMMIT::7}.ck"
	printf "\\n\\e[1;38;5;185m%s\\e[0m\\n\\n" "Could not find an AndroidManifest.xml file in C C# C++ Haskell Java* Kotlin Lua Objective-C* Octave Pearl Python R* and/or Shell language repository $USER ${NAME##*/} ${COMMIT::7}:  NOT downloading ${NAME##*/} tarball."
}

_PRINTAS_ () {
	printf "\\e[1;34mSearching for AndroidManifest.xml files:\\e[0m\\n"'\033]2;Searching for AndroidManifest.xml files: OK\007'
}

_PRINTCK_ () {
	if [[ "$CK" = 1 ]]
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

_RLREMING_ () { # if connection is available, print GitHub rate limit limit
	RATEARRAY=($(curl -is https://api.github.com/rate_limit | grep Rate)) || printf "\\e[2;7;38;5;51m%s\\e[0m\\n\\n" "The Internet connection is not available; Continuing..." # create array with get rate information https://developer.github.com/v3/rate_limit/ from GitHub without incurring an API hit
	if [[ ! -z "${RATEARRAY:-}" ]] # if RATEARRAY is set
	then	# print GitHub X-RateLimit-Limit information to screen
		printf "%s\\n" "GitHub rate limit information:"
		printf "\\e[2;7;38;5;144m%s\\e[0m\\n" "${RATEARRAY[0]} ${RATEARRAY[1]}"
		printf "\\e[2;7;38;5;146m%s\\e[0m\\n" "${RATEARRAY[2]} ${RATEARRAY[3]}"
		printf "\\e[2;7;38;5;148m%s\\e[0m\\n" "${RATEARRAY[4]} ${RATEARRAY[5]}"
		[ "$OAUT" != "" ]  && printf "\\e[1;7;38;5;185m%s\\e[0m\\n\\n" "OAUTH token $OAUT is enabled; Continuing..." || printf "\\e[2;7;38;5;150m%s\\e[0m\\n\\n" "File ~/${RDR##*/}/.conf/GAUTH has more information about X-RateLimit; Continuing..."	# print information about the .conf/GAUTH file
	fi
	unset RATEARRAY
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
 	_MAINGITHUB_ "$*"
fi
# build.github.bash OEF
