#!/bin/bash
################################################################################
#
# Copyright (C) 2023, Roberto A. Foglietta <roberto.foglietta@gmail.com>
#                     Released under GPLv2 license terms
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# version 2 as published by the Free Software Foundation
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
################################################################################
# release: 0.0.6

set -ue -o pipefail

if ! type errexit 2>&1 | head -n1 | grep -q "is a function"; then
	errexit() {
		if [ -n "${1:-}" ]; then
			echo
			echo "ERROR: $@"
			echo
		fi >&2
		exit 1
	}
fi

branch="devel"
branch="${1:-$branch}"
url="https://raw.githubusercontent.com/robang74/redfishos/$branch/scripts"

src="
pcos/pcos-rfos-suite-installer.sh
sfos/patch_dblock_functions.env
rfos-script-functions.env
pcos/sfos-ssh-connect.env
pcos/fastboot_usb3fix.sh
pcos/rfos-first-setup.sh
"

echo
dir=$HOME/bin
mkdir -p $dir || errexit "cannot create '$dir' folder, abort."

for i in $src; do
	dst=$dir/$(basename $i)
	echo -n "Downloading $i..."
	rm -f $dst
    wget $url/$i -qO $dst || errexit "cannot download $i, abort."
    echo " ok"
	if echo $i | grep -q "\.sh$"; then
		chmod a+x $dst || errexit "cannot chmod +x $dst, abort."
	else
		grep -q "source $dst" "$HOME/.bashrc" ||\
			echo "source $dst" >> "$HOME/.bashrc"
	fi
done
grep -q "export -f src_file_env" "$HOME/.bashrc" ||\
echo "export -f src_file_env" >> "$HOME/.bashrc"

echo
echo "DONE: scripts suite for RedFish OS, installed in"
echo "      folder    : $dir"
echo "      enviroment: $HOME/.bashrc"
echo "Please, (re)execute bash to load its enviroment."
echo
