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
# release: 0.0.2

set -eu

src_file_env "sfos-ssh-connect"

# VARIABLES DEFINITIONS ########################################################

usage() {
    echo
    echo "USAGE: $(basename $0) [ -v | -h ] tarball [ /remote/folder ]"
    echo
    exit 0
}

while [ -n "${1:-}" ]; do
    if [ -e "$1" ]; then
        tarball="$1"
        shift
        continue
    fi
    if [ "${1:0:1}" = "/" ]; then
        if [ ! -n "$tarball" ]; then
            usage
        fi
        remdir="$1"
        shift
        continue
    fi
    case $1 in
    -v)
        v="v"
        ;;
    -h|--help|*)
        usage
        ;;
    esac
    shift
done

remdir=${remdir:-/}

test -n "$tarball" || exit 1

# MAIN CODE EXECUTION ##########################################################

ask_to_stop_mobile_data

echo
echo "=> Restoring backup by SSH/cat..."
echo "  \_ archive: $tarball"
echo "  \_ remote target folder: ${remdir:-/}"

remdir=${remdir:-/}
dd_opts="bs=1M iflag=fullblock"
#dd --help 2>&1 | grep -q progress && stprg="status=progress"

{
    time dd if=$tarball ${v:-${stprg:-}} $dd_opts |\
        ssh $ssh_opts root@$sfos_ipaddr "pigz -dc | tar ${v:-}x -C /"
} 2>&1 | grep -v "tar: removing leading" | grep -E "real|copied" | tr '\t' ' '\
     | sed -e "s/.* bytes (\(.*\), .*)\(.*\)/transfer speed: \\1\\2/" -e \
         "s/real /execution time: /" | sed -e "s,^,  |  ,"
echo "  \_ restore: completed"
echo