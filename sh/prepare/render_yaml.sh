#!/bin/bash
scriptdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
dc_master="${scriptdir}/dc_master.yaml"
dc_target="${1}"
conf="${2}"

function gk() {
    stoml "${conf}" "${1}" |
        sd -p "<HOME>" "${HOME}"
}

cat "${dc_master}" |
    sd -p "<RDMO_SOURCE_MP>" "$(gk "mountpoints.rdmo_source")" |
    sd -p "<RDMO_SOURCE_FOL>" "$(gk "folders.rdmo_source")" |
    sd -p "<RDMO_APP_MP>" "$(gk "mountpoints.rdmo_app")" |
    sd -p "<RDMO_APP_FOL>" "$(gk "folders.rdmo_app")" |
    sd -p "<RDMO_PLUGINS_MP>" "$(gk "mountpoints.rdmo_plugins")" |
    sd -p "<RDMO_PLUGINS_FOL>" "$(gk "folders.rdmo_plugins")" |
    sd -p "<SHED_MP>" "$(gk "mountpoints.shed")" |
    sd -p "<SHED_FOL>" "$(gk "folders.shed")" |
    sd -p "<MYBINS_MP>" "$(gk "mountpoints.mybins")" |
    sd -p "<MYBINS_FOL>" "$(gk "folders.mybins")" \
        >"${dc_target}"
