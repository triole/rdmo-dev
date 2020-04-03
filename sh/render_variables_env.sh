#!/bin/bash
IFS=$' '
scriptdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
basedir="$(echo "${scriptdir}" | grep -Po ".*(?=\/)")"

config="${basedir}/config.toml"
env_variables="${basedir}/variables.env"
env_project_name="${basedir}/.env"

testmode="${1}"
install_source="${2}"
branch="${3}"

function ac() {
    echo -e "${1}" >>"${env_variables}"
}

function getval() {
    stoml "${config}" "${1}"
}

function render() {
    ac "\n# ${1}"
    vals=($(getval "${1}"))
    for key in "${vals[@]}"; do
        s="$(echo "${key}" | tr [:lower:] [:upper:])"
        entry="$(getval "${1}.${key}")"
        if ([[ "${install_source}" != "default" ]] && [[ "${key}" == "install_source" ]]); then
            entry="${install_source}"
        fi
        s+="=${entry}"
        $(ac "${s}")
    done
}

# main
if [[ -f "${env_variables}" ]]; then
    rm "${env_variables}"
fi

if [[ "${testmode}" == "True" ]]; then
    echo "COMPOSE_PROJECT_NAME=rdmo-devtest" >"${env_project_name}"
else
    echo "COMPOSE_PROJECT_NAME=rdmo-dev" >"${env_project_name}"
fi
ac "TESTMODE=${testmode}"
render "general"
render "postgres"
render "rdmo"
ac "BRANCH=${branch}"
