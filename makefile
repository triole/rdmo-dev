CURDIR=$(shell pwd)
CONFIG=${CURDIR}/config.toml
DC_MASTER="dc_master.yaml"
DC_TEMP="docker-compose.yaml"
TEMPFILE="/tmp/rdmo-dev.tmp"

DEFAULT_INSTALL_SOURCE=$(shell stoml ${CONFIG} rdmo.install_source)
INSTALL_SOURCE=${s}
INSTALL_SOURCE=$(shell if [ -z "${s}" ]; then echo "${DEFAULT_INSTALL_SOURCE}"; else echo "${s}"; fi)

TESTMODE=${t}
TESTMODE=$(shell if [ -z "${t}" ]; then echo "False"; else echo "True"; fi)

BRANCH=${b}

all: prepare_yaml render_variables run_build tail_logs
build: prepare_yaml run_build
fromscratch: prepare_yaml run_remove run_build
remove: run_remove
log: tail_logs

test: render_variables prepare_yaml

render_variables:
	./sh/render_variables_env.sh "${TESTMODE}" "${INSTALL_SOURCE}" "${BRANCH}"

prepare_yaml:
	cat ${DC_MASTER} \
		| sd -p "<HOME>" "${HOME}" \
		| sd -p "<CURDIR>" "${CURDIR}" \
		| sd -p "<RDMO_SOURCE_MP>" $(shell stoml ${CONFIG} rdmo.rdmo_source_mp) \
		> ${DC_TEMP}
		@# remove volume, if source not local
		@if [ "${INSTALL_SOURCE}" != "${DEFAULT_INSTALL_SOURCE}" ]; then\
			cat ${DC_TEMP} | grep -v "\- rdmosrc:" \
				> "${TEMPFILE}" \
			&& cp -f "${TEMPFILE}" "${DC_TEMP}";\
    	fi

run_build:
	sudo docker-compose up --build -d

run_remove:
	sudo docker-compose down --rmi all
	sudo docker-compose rm --force

tail_logs:
	sudo docker logs -f rdmo 2>&1 | grep -Ev '"GET / HTTP/1.1" 200'
