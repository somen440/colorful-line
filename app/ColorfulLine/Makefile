dc := docker-compose -p colorful-line

.PHONY: up
up:
	${dc} up -d app

.PHONY: clean
clean:
	${dc} down --volumes

.PHONY: setup
setup:
	${dc} up setup
