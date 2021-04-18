dc := docker-compose -p colorful-line

.PHONY: build
build:
	${dc} pull
	${dc} build

.PHONY: up
up:
	${dc} up -d db
	${dc} run --rm wait
	${dc} up -d app

.PHONY: clean
clean:
	${dc} down --volumes

.PHONY: setup
setup:
	${dc} up setup

.PHONY: ps
ps:
	${dc} ps

.PHONY: tail
tail:
	${dc} logs -f app

.PHONY: restart
restart:
	${dc} restart app
