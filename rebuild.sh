#!/bin/bash

sudo docker-compose down --rmi all --remove-orphans
sudo docker volume rm \
    rdmo-dc_rdmosrc \
    rdmo-dc_volfiles

sudo docker-compose up -d
sudo docker-compose logs -f 
