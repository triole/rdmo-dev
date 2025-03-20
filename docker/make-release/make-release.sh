#!/bin/bash
set -e
source "${HOME}/.bashrc"

cd "${HOME}/rdmo"

pref() {
  cat ${HOME}/rdmo/.nvmrc
}

nvm install "$(pref)"
nvm use --delete-prefix "$(pref)"
npm install

pip install -e .

python -m rdmo check
rdmo-admin check

pip install build

# rdmo-admin messages make
# rdmo-admin messages compile
rdmo-admin build
