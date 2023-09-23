#!/bin/bash
source "${HOME}/.bashrc"

cd "${HOME}/rdmo"

pref() {
  cat ${HOME}/rdmo/.nvmrc
}

nvm install "$(pref)" &&
  nvm use --delete-prefix "$(pref)" &&
  npm install &&
  npm run build:prod &&
  python -m pip install build &&
  python -m build
