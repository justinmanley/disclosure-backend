.PHONY: build run test setup

build:
	python manage.py collectstatic --noinput

run:
	python manage.py runserver

test:
	python manage.py test

setup:
	sudo apt-get update -qq

	sudo apt-get install -y mysql-server libmysqlclient-dev python-virtualenv python-dev libjpeg-dev

	mysql -p --user root -e "CREATE DATABASE calaccess_raw; \
	    GRANT ALL ON calacces_raw.* TO '$USER'@'localhost';"

	virtualenv . && source bin/activate
	pip install numpy>=1.9.2 # numpy has to be installed first
	pip install -r requirements.txt

	python manage.py migrate
	python manage.py downloadcalaccessrawdata

