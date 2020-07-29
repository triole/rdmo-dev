#!/bin/bash

psql -h ${POSTGRES_HOST} -U ${POSTGRES_USER} \
    -c "INSERT INTO authtoken_token (key, created, user_id) VALUES ('${API_DEV_KEY}', 'NOW', 1)"
