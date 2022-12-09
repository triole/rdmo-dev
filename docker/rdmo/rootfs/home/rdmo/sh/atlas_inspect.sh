#!/bin/bash

atlas schema inspect \
    -u postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}?sslmode=disable
