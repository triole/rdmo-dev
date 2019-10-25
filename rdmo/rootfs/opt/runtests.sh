#!/bin/bash

cd ${RDMO_SRC}
cp testing/config/settings/sample.local.py testing/config/settings/local.py
python testing/runtests.py rdmo
