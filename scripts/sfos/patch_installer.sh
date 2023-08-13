#!/bin/sh
# bash or ash is required but sh for universal compatibility.
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
#
# TODO: create a back-up of the files before patching, date-time-Nprogressive
#
# release: 0.1.3

set -mue #-o pipefail

trap 'echo -e "\nError occurred ($?) on $LINENO\n" >&2' ERR EXIT

src_file_env "rfos-script-functions"
src_file_env "patch_dblock_functions"

export PATH=$HOME/bin:$PATH

# FUNTIONS DEFINITIONS #########################################################

patch_unapplied_warning() {
    echo
    echo "WARNING: patch #$n failed to be applied to rootfs, skipped"
    echo "         patch: $patch_name $vern"
    echo "         fix pre-requisites and then try to install again."
}

patch_string_to_filename() {
    test -n "${1:-}" || return 1

    # cast the patch data into useful variables
    strn=$(echo $1    | cut -d\; -f1)
    prov=$(echo $strn | cut -d\, -f1  | tr  -d ' '    ||:)
    name=$(echo $strn | cut -d\, -f2  | tr  -d ' '    ||:)
    vern=$(echo $strn | cut -d\, -f3  | tr  -d ' '    ||:)
    extn=$(echo $strn | cut -d\, -f4  | tr  -d ' '    ||:)
    srvs=$(echo $strn | cut -d\, -f5- | grep -vw none ||:)
    srvs=$(echo $srvs | cut -d\# -f1 ||:)

    patch_file="$prov-$name-$vern.patch"
    patch_path="$patch_dir/$patch_file"
    bckup_path=${patch_path%.patch}

    return 0
}

exit_for_manual_intervention() {
    trap - SIGINT EXIT ||:
    stty +echoctl 2>/dev/null ||:
    servs_list=$(cat "$reload_path" 2>/dev/null ||:)
    errexit "patch #$n cannot be $past_action automatically.

\tManual intervetion is needed, these are the working values:

 patch path: $(dirname ${patch_path:-none})
 patch name: $patch_name
 patch opts: $patch_opts
 patch file: $(basename ${patch_path:-none})
 patch revr: $(basename ${patch_reversible:-none})
 patch prev: $(basename ${patch_prev_path:-none})
 srv2reload: $(echo ${servs_list:-none})"
}

do_patch() {
    if patch $patch_opts "$@" 2>&1; then
    	return 0
    else
    	return 1
    fi | eval "$filter_2" ||:
}

reversible_check() {
    echo "  \_ Checking for reversibility..."
    if do_patch -R --dry-run -i "$1"; then
        reversible="OK"
        patch_reversible=$1
    else
        reversible="KO"
        patch_reversible=""
    fi >/dev/null
    echo "  \_ Reversibility : $reversible"
    test "$reversible" = "OK"
}

applicable_check() {
    echo "  \_ Checking for application... "
    if do_patch --dry-run -i "$1"; then
        applicable="OK"
        patch_applicable=$1
    else
        applicable="KO"
        patch_applicable=""
    fi >/dev/null
    echo "  \_ Applicability : $applicable"
    test "$applicable" = "OK"
}

read_patch_string() {
    touch "$patch_db"
    grep ", *$patch_name *," "$patch_db"
    return 0 # RAF: we do not care about finding or not, we check it later
}

# VARIABLES DEFINITIONS ########################################################

patch_db="/etc/patches.db"
patch_dir="/etc/patches.d"
patch_lst="/etc/patches.list"
patch_opts="-slEfp1 -r /dev/null --no-backup-if-mismatch -d/"

reload_path="$patch_dir/services-to-reload.list"

filter_1="grep . | sed -e 's,^,\ \ \ ,'"
filter_2="grep . | sed -e 's,^,\ \ \|\ \ ,'"
filter_3="grep -Ev 'Status:|Percentage:|Results:'"
filter_3="$filter_3 | $filter_2"
filter_4="sed -e 's/^+ //' | $filter_2"
filter_5="tr '\n' '^' | cut -d'^' -f1,3 | tr '^' '\n'"
filter_5="$filter_5 | $filter_1"

patches_to_apply=""
test "x${1:-}" == "x--all" \
	&& patches_to_apply="
sshd-publickey-login-only
utilities-quick-fp-restart
x10ii-iii-agps-config-emea
x10ii-iii-udev-rules-fixing
dnsmasq-connman-integration
"

# SHELL TEST ###################################################################

shn=$(shellname)

echo
echo "Script running on shell: $shn"
echo
if [ "$shn" = "bash" -o "$shn" = "ash" ]; then
    :
elif [ "$shn" = "dash" ]; then
    echo "ERROR: this script cannot run on dash, abort."
    echo
    exit 1
else
    echo "WARNING: this script requires b/ash to run correctly."
    echo
fi >&2

# PARAMETERS CHECK #############################################################

plst="ERROR"
if [ ! -n "$patches_to_apply" ]; then
    if [ -n "${1:-}" ]; then
        patches_to_apply="$@"
        plst="args"
    else
        patches_to_apply=$(cat $patch_lst)
        plst="file"
    fi
else
    plst="--all"
fi

if [ ! -n "$patches_to_apply" ]; then
    errexit "no patches to apply found, abort."
fi
echo
echo "=> Using the patch list from '$plst':"
echo "  \_ List of patches to apply:"
echo
echo "$patches_to_apply" | eval "$filter_1"

servs_list=$(cat "$reload_path" 2>/dev/null ||:)
if [ -n "$servs_list" ]; then
    echo
    echo "WARNING: system services to restart found from a previous run"
    echo "         collected and put in the current list of restarting."
fi

verb_action="apply"
past_action="applied"
# MAIN LOOP EXECUTION ##########################################################
# this loop install all the patches in the ordered list ========================
n=0; mkdir -p "$patch_dir/"; for patch_name in $patches_to_apply; do n=$((n+1))
# this loop is a fake that allows to use break instead of if/else/fi construct ~
skip=0; while true; do # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ # fake loop #

echo
echo "=> Current patch #$n check: $patch_name"

patch_prev_path=""
patch_prev_strn=$(read_patch_string)
if patch_string_to_filename "$patch_prev_strn"; then
    echo "  \_ Current patch: v$vern found"
    echo "  |  $patch_prev_strn"
    if applicable_check "$patch_path"; then
        patch_prev_path=$patch_applicable
    elif reversible_check "$patch_path"; then
        skip=1; break
    else
    	echo "  \_ Current patch: broken"
    fi
else
    echo "  \_ Current patch: none"
fi

verstr="current"
if [ -n "${patch_prev_path:-}" ]; then
    echo "  \_ Patch to $verb_action: $verstr $vern version"
    break
fi

verstr="last"
echo
echo "=> Downloading the patch #$n last version..."
echo "  \_ Patch name: $patch_name"

# RAF: this because -o pipefail is not available and set -e is set for debug ###
if output=$(patch_downloader.sh $patch_name 2>&1);
	then ret=0; else ret=$?; fi
echo "$output" | eval "$filter_4" ||:
if [ $ret -ne 0 ]; then                  # -o pipefail alternative ends here ###
	if [ -n "$patch_prev_strn" ]; then
        echo "  \_ Using local patch."
    	exit_for_manual_intervention
    else
        echo "  \_ Patch unavailable: skip."
    	skip=1; break
    fi
else
	patch_strn=$(read_patch_string)
	if ! patch_string_to_filename "$patch_strn"; then
		errexit "patch string  of '$patch_name' is void, abort."
	fi
fi

if [ "$patch_path" = "$patch_prev_path" ]; then
    exit_for_manual_intervention
fi

if reversible_check "$patch_path"; then
    skip=1; break
fi

break; done; test $skip -eq 1 && continue # ~~~~~~~~~~~~~~~~~~~~~~ # fake loop #

echo
echo "=> System services check for patch #$n..."
brk=0
if [ -n "${srvs:-}" ]; then
    for srv in $srvs; do
        ret=0; systemctl --no-pager status $srv >/dev/null 2>&1 || ret=$?
        if [ $ret -eq 4 ]; then
            echo "  \_ missing system service: $srv"
            echo "  \_ searching, wait..."
            if out=$(pkcon install -yp --allow-reinstall $srv 2>&1); then
                echo "  \_ system service installed: $srv"
            else
                echo "  \_ system service not found: $srv"
                echo "$out" | eval "$filter_3" ||:
                brk=1
                break
            fi
        fi
    done
fi
echo "  \_ system services: ${srvs:-none}"
if [ $brk -ne 0 ]; then
    echo "  \_ system services check: failed, skip patch #$n."
    patch_unapplied_warning
    continue
fi

# This part cannot be interrupted # ********************************************
set +e; stty -echoctl 2>/dev/null ||:; trap 'true' SIGINT EXIT

echo
echo "=> Applying the patch #$n in $verstr version..."

# test if the patch can be applied as expected to be
# apply the patch may fail despite the dry run test
# forcely revert the patch that applied only partially
if ! applicable_check "$patch_path"; then
    echo "  \_ Applying patch: the dry run failed, skip."
    exit_for_manual_intervention                                  #<- exit-point
elif do_patch -i "$patch_path"; then
    echo "  \_ Patch #$n applied to rootfs"
    echo "  \_ Services scheduled to restart: $srvs"
    echo $srvs >> "$reload_path"
else
    echo "  \_ Patch #$n failed to apply, reverting back..."
    if do_patch -R -i "$patch_path"; then
        echo "  \_ Patch #$n reverted back sucessfully."
        continue
    elif ! applicable_check "$patch_path"; then
        echo "  \_ Patch #$n reverse back failed, abort."
        exit_for_manual_intervention "reversed"                   #<- exit-point
    fi
fi

stty +echoctl 2>/dev/null ||:; set -e; trap - SIGINT EXIT
# ******************************************************************************
# move to the next patch
done # =========================================================================

# This part cannot be interrupted # ********************************************
set +e; stty -echoctl 2>/dev/null ||:; trap 'true' SIGINT EXIT

service_switcher() {
	test -n "${1:-}" || return 1 
	if [ "x$2" = "x-" ]; then
		echo "  |  Service disable:" $1
		$sctlcmd disable $1;
	else
		echo "  |  Service enable:" $1
		$sctlcmd enable $1;
	fi
}

echo
sctlcmd="systemctl --no-pager"
servs_list=$(cat "$reload_path" 2>/dev/null ||:)
rm -f "$reload_path"

if [ -n "${servs_list:-}" ]; then
    echo "=> Restarting system services"
    echo "  \_ To restart: "$servs_list
    $sctlcmd daemon-reload
    for i in $servs_list; do
	    s="$i"
	    m="${i:0:1}"
	    if [ "x$m" = "x-" ]; then
	    	s="${i:1}"
	    fi
        $sctlcmd reload $s
        service_switcher $s '+'
    done 2>/dev/null ||:
    echo "  \_ Reload completed"

    mkfifo /tmp/spm.fifo
    { 2>/dev/null
        sleep 1
        $sctlcmd restart $restart_list >/dev/null
        echo -e "  \_ Restart done, ret:$?" >/tmp/spm.fifo
    } &
    disown &>/dev/null

    echo
    echo "WARNING: the connection will not automatically raise up again"
    echo
    dttm=$(date +"%Y-%m-%d %H:%M:%S")
    echo "=> Restarted system services, ${dttm}..."
    printf "  \_ Press a key after the connection will be manually restored."
    read
    while IFS= read -r line; do
        echo "$line"
    done </tmp/spm.fifo
    rm -f /tmp/spm.fifo

    echo
    dttm=$(date +"%Y-%m-%d %H:%M:%S")
    echo "=> Checking the restarted system services, ${dttm}..."
    echo "  \_ To check:" $servs_list
    echo
    for i in $servs_list; do
        s="$i"; test "x${i:0:1}" = "x-" && s="${i:1}"
        $sctlcmd status $s 2>&1 | eval "$filter_5" ||:
    done
    echo
fi

stty +echoctl 2>/dev/null ||:; set -e; trap - SIGINT EXIT
# ******************************************************************************
