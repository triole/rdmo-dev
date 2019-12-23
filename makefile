# manual settings
DC_MASTER="dc_master.yaml"
DC_TEMP="docker-compose.yaml"

CURDIR=$(shell pwd)


all: prepare_yaml run_build tail_logs
build: prepare_yaml run_build
fromscratch: prepare_yaml run_remove run_build
remove: run_remove


prepare_yaml:
	cat ${DC_MASTER} \
		| sd -p "<HOME>" "${HOME}" \
		| sd -p "<CURDIR>" "${CURDIR}" \
		> ${DC_TEMP}

run_build:
	sudo docker-compose up --build -d

run_remove:
	sudo docker-compose down --rmi all
	sudo docker-compose rm --force

tail_logs:
	sudo docker-compose logs -f
