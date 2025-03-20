#!/bin/bash
IFS=$' '
scriptdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
basedir="$(echo "${scriptdir}" | grep -Po "^.*(?=/.*/)")"

config="${basedir}/conf.toml"
env_variables="${basedir}/variables.env"
env_project_name="${basedir}/.env"

install_source="${1}"
branch="${2}"
testmode="${3}"

function ac() {
  echo -e "${1}" >>"${env_variables}"
}

function getval() {
  stoml "${config}" "${1}"
}

function render() {
  suffix="${2}"
  ac "\n# ${1}"
  vals=($(getval "${1}"))
  for key in "${vals[@]}"; do
    s="$(echo "${key}" | tr [:lower:] [:upper:])"
    entry="$(getval "${1}.${key}")"
    if ([[ "${install_source}" != "default" ]] && [[ "${key}" == "install_source" ]]); then
      entry="${install_source}"
    fi
    if [[ -n "${suffix}" ]]; then
      s="${s}${suffix}"
    fi
    s+="=${entry}"
    $(ac "${s}")
  done
}

# main
if [[ -f "${env_variables}" ]]; then
  rm "${env_variables}"
fi

tm="False"
if [[ "${testmode}" == "test" ]]; then
  echo "COMPOSE_PROJECT_NAME=rdmo-devtest" >"${env_project_name}"
  tm="True"
else
  echo "COMPOSE_PROJECT_NAME=rdmo-dev" >"${env_project_name}"
fi
ac "TESTMODE=${tm}"
render "general"
render "postgres"
render "mountpoints" "_MP"
render "repos" "_REP"
ac "BRANCH=${branch}"
