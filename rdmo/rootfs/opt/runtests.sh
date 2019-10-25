#!/bin/bash

# display help
if [[ "${1}" =~ h|help ]]; then
    echo -e "\nModule paths to test; can be modulename, modulename.TestCase or modulename.TestCase.test_method"
    echo -e "\nI.e. runtests.sh rdmo.project\n"
    exit
fi


cd ${RDMO_SRC}
cp testing/config/settings/sample.local.py testing/config/settings/local.py

if [[ -z "${1}" ]]; then
    python testing/runtests.py rdmo
else
    python testing/runtests.py $@
fi
