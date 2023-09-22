#!/bin/bash
scriptdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dc_master="${scriptdir}/dc_master.yaml"
dc_target="${1}"
conf="${2}"

function gk() {
  stoml "${conf}" "${1}" | envsubst
}

export RDMO_SOURCE_MP="$(gk "mountpoints.rdmo_source")"
export RDMO_SOURCE_FOL="$(gk "folders.rdmo_source")"
export RDMO_APP_MP="$(gk "mountpoints.rdmo_app")"
export RDMO_APP_FOL="$(gk "folders.rdmo_app")"
export RDMO_PLUGINS_MP="$(gk "mountpoints.rdmo_plugins")"
export RDMO_PLUGINS_FOL="$(gk "folders.rdmo_plugins")"
export SHED_MP="$(gk "mountpoints.shed")"
export SHED_FOL="$(gk "folders.shed")"
export MYBINS_MP="$(gk "mountpoints.mybins")"
export MYBINS_FOL="$(gk "folders.mybins")"

cat "${dc_master}" | envsubst >"${dc_target}"
