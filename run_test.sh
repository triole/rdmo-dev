#!/bin/bash

scriptdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
config="${scriptdir}/config.toml"

arg="${1}"
if [[ "${arg}" =~ (-h|--help) ]]; then
    echo "Supports two args:"
    echo -e "\t1st is the location, can be 'git' or 'local', default is 'local'"
    echo -e "\t2nd is the branch, default is 'master'"
fi

branch="${2}"
if [[ -z "${branch}" ]]; then
    branch="master"
fi
if [[ -z "${arg}" ]]; then
    arg="local"
    url="$(stoml "${config}" "rdmo.rdmo_src")"
fi
if [[ "${arg}" == "git" ]]; then
    url="$(stoml "${config}" "repos.rdmo")"
    url="${url}"
fi

logfolder="${scriptdir}/tmp/log"
logfile="${logfolder}/test_${arg}.log"
err_msg="AN ERROR APPEARED: "

function run_test() {
    echo -e "Start test rdmo test. Retrieve source code from \033[0;93m${1}\033[0m" | tee "${logfile}"
    make t="True" s="${url}" b="${branch}" | tee -a "${logfile}"
    if [[ "${?}" != "0" ]]; then
        echo "${err_msg}: ${?}"
    fi
}

# run tests
mkdir -p "${logfolder}"
run_test "${url}"
make remove
