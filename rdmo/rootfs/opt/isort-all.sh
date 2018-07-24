#!/bin/bash

find "${RDMO_SRC}" -regex ".*\/rdmo\/rdmo\/.*\.py$" | xargs isort
