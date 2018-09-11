#!/bin/bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/"

<<<<<<< HEAD

function fetch_coda(){
    loc_src="${HOME}/tools/mybins/x86_64/coda"
    dok_tfo="./rdmo/rootfs/bin/"
    if [[ -f "${loc_src}" ]]; then
        mkdir -p "${dok_tfo}"
        cp -f ${loc_src}* ${dok_tfo}
    fi
=======
function fetch_coda(){
loc_src="${HOME}/tools/mybins/x86_64/coda"
dok_tfo="./rdmo/rootfs/bin/"
if [[ -f "${loc_src}" ]]; then
    mkdir -p "${dok_tfo}"
    cp "${loc_src}" "${dok_tfo}"
fi
>>>>>>> 3f275271a41bdbad929e906b17777aaf927cc3bd
}

function set_python_interpreter(){
    tf="${scriptdir}rdmo/dockerfile"
    echo "" > "${tf}"
    while read p; do
        added="false"
        pyint=$(echo "${p}" | grep -Po "^ENV\sPYINT=\"(?=python)")
        pypip=$(echo "${p}" | grep -Po "^ENV\sPYPIP=\"(?=python-pip)")
        if [[ -n ${pyint} ]]; then
            echo ${pyint}${1}\" >> ${tf}
            added="true"
        elif [[ -n ${pypip} ]]; then
            echo ${pypip}${2}\" >> ${tf}
            added="true"
        else
            echo ${p} >> ${tf}
        fi
    done <"${scriptdir}/rdmo/dockerfile_template"
}


# main
# set python interpreter version
fetch_coda
if [[ "${1}" =~ (2|p2|python2) ]]; then
    echo -e "\nBuilding python2 version...\n"
    set_python_interpreter python python-pip
else
    echo -e "\nBuilding python3 version...\n"
    set_python_interpreter python3 python-pip3
fi

# build
sudo docker-compose down --rmi all --remove-orphans
sudo docker volume rm \
    rdmo-dc_rdmosrc \
    rdmo-dc_volfiles

sudo docker-compose up -d
sudo docker-compose logs -f
