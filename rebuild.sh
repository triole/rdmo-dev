#!/bin/bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/"


function set_python_interpreter(){
    tf="${scriptdir}rdmo/dockerfile"
    echo "" > "${tf}"
    while read p; do
        var=$(echo "${p}" | grep -Po "^ENV\sPYINT=\"(?=python)")
        if [[ -n ${var} ]]; then
            echo ${var}${1}\" >> ${tf}
        else
            echo ${p} >> ${tf}
        fi
    done <"${scriptdir}/rdmo/dockerfile_template"
}


# main
# set python interpreter version
if [[ "${1}" == "p2" ]]; then
    echo -e "\nBuilding python2 version...\n"
    set_python_interpreter python2
else
    echo -e "\nBuilding python3 version...\n"
    set_python_interpreter python3
fi

# build
sudo docker-compose down --rmi all --remove-orphans
sudo docker volume rm \
    rdmo-dc_rdmosrc \
    rdmo-dc_volfiles

sudo docker-compose up -d
sudo docker-compose logs -f
