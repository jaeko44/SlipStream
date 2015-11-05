#!/bin/bash
# Install SlipStream connectors.

set -e
set -o pipefail

_SCRIPT_NAME=${0##*/}

_YUM_REPO_KIND_DEFAULT=release

LOG_FILE=/tmp/slipstream-connectors-install.log
exec 4>&2 3>&1 1>>${LOG_FILE} 2>&1

function usage() {
    echo -e "usage:\n$_SCRIPT_NAME [-r repo] <list of connectors>
 -r repo: <release|candidate|snapshot|local> (default: ${_YUM_REPO_KIND_DEFAULT})" 1>&3
    exit 1
}

declare -A YUM_REPO_TO_GH_BRANCH
YUM_REPO_TO_GH_BRANCH[local]=master
YUM_REPO_TO_GH_BRANCH[snapshot]=master
YUM_REPO_TO_GH_BRANCH[candidate]=candidate-latest
YUM_REPO_TO_GH_TAG[${_YUM_REPO_KIND_DEFAULT}]=release-latest

function _check_repo() {
    if ! test "${YUM_REPO_TO_GH_BRANCH[$1]+isset}"; then
        usage
    fi
}

SS_YUM_REPO_KIND=${_YUM_REPO_KIND_DEFAULT}

while getopts :r: opt; do
    case $opt in
    r)
        SS_YUM_REPO_KIND=$OPTARG
        _check_repo $SS_YUM_REPO_KIND
        ;;
    \?)
        usage
        ;;
    esac
done

shift $((OPTIND - 1))

GH_BASE_URL=https://raw.githubusercontent.com/slipstream/SlipStream

function _prints() {
    echo -e "$@" 1>&3
}
function _print() {
    _prints "::: $@"
}
function _printn() {
    echo -en "::: $@" 1>&3
}

function _download() {
    TO=$1
    shift
    FROM=$SCRIPT_BASE_URL/$TO
    _printn "downloading $@... "
    curl -sSf -k -o $TO $FROM || { _print "ERROR: Failed downloading $FROM"; exit 1; }
    _prints "done."
    chmod +x $TO
}

SCRIPT_BASE_URL=$GH_BASE_URL/${YUM_REPO_TO_GH_BRANCH[$SS_YUM_REPO_KIND]}/install/connectors

function _print_on_trap() {
    _prints "\nERROR! Check log file ${LOG_FILE}\n... snippet ...\n$(tail -5 ${LOG_FILE})"
}

function _on_trap() {
    _print_on_trap
}

trap '_on_trap' ERR

CONNECTORS=${@}

_print "Installing SlipStream connectors: $CONNECTORS"

declare -A CONNECTORS_MAPPING 
CONNECTORS_MAPPING=(
    ['cloudstackadvancedzone']='cloudstack'
    ['stratuslabiter']='stratuslab')

for name in $CONNECTORS; do
    _print "---> ${name}"
    [ -n "${CONNECTORS_MAPPING[$name]}" ] && name=${CONNECTORS_MAPPING[$name]}
    script=connector-${name}.sh
    _download $script "$name connector installation script"
    _printn "installing... "
    ./$script
    _prints "done."
done
_print "SlipStream connectors installed: $CONNECTORS"

