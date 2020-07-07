#!/usr/bin/env sh
# Copyright 2020 (c) all rights reserved by BuildAPKs; see LICENSE
# https://buildapks.github.io published courtesy https://pages.github.com
#################################################################################
set -eu
cp build.github.bash download.github.bash && sed -i '308,309d' download.github.bash && printf "%s\\n%s\\n" "$(head -n -1 download.github.bash)" "# download.github.bash OEF" > download.github.bash
# cp.g2d.sh OEF
