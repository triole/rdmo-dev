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
rdmo-admin build

sleep 99d

# npm run build:prod &&
# python -m pip install build &&
# python -m build
