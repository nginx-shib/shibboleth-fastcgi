all:
	docker-compose up

build:
	docker pull centos:7 && docker pull centos:6
	docker-compose build

rebuild:
	docker-compose up --build

clean:
	docker-compose down --volumes --remove-orphans
	rm -rf build/centos-*/*

.PHONY: all build rebuild clean
