#!/bin/bash
# ubuntu requirements: python3-django, poedit
# alpine docker requirements: gettext
rdmodir="${RDMO_SOURCE_MP}"
if [[ -z "${rdmodir}" || ! -d "${rdmodir}" ]]; then
  rdmodir="${HOME}/rolling/aip/github/rdmo"
fi
locale_dir="${rdmodir}/rdmo/locale"

_rcmd() {
  cmd=${@}
  echo -e "\033[0;93m${cmd}\033[0m"
  eval ${cmd}
}

_printhead() {
  echo -e "\n\033[0;95m${1}\033[0m"
}

make_messages() {
  cd "${rdmodir}/rdmo" && {
    ls -la
    _printhead "make messages, workdir: ${workdir}"

    mapfile -t arr < <(
      find "${locale_dir}" -mindepth 1 -maxdepth 1 -type d
    )
    for el in "${arr[@]}"; do
      pwd
      lang="$(echo "${el}" | grep -Po "[^/]+$")"
      _rcmd django-admin makemessages -v 2 -l ${lang} -d django || exit 1
      _rcmd django-admin makemessages -v 2 -l ${lang} -d djangojs || exit 1
    done
  }
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

export DJANGO_SETTINGS_MODULE="rdmo"
make_messages #&& edit_trans
