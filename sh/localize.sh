#!/bin/bash
# ubuntu requirements: python3-django, poedit

locale_dir="${HOME}/rolling/aip/github/rdmo/rdmo/locale"

rcmd() {
  cmd=${@}
  echo -e "\033[0;93m${cmd}\033[0m"
  eval ${cmd}
}

make_mess() {
  rcmd django-admin makemessages --all
}

edit_trans() {
  mapfile -t arr < <(
    find "${locale_dir}" -mindepth 2 -type f -regex ".*\/django\.po$" |
      sort | head -n 1
  )
  for el in "${arr[@]}"; do
    rcmd poedit "${el}"
  done
  rcmd django-admin compilemessages
}

cd ${locale_dir} && make_mess && edit_trans
