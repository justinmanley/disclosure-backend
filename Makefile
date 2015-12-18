include config.mk

.PHONY: build run test setup

build:
	python manage.py collectstatic --noinput

run:
	python manage.py runserver

test:
	python manage.py test

setup:
	sudo apt-get update -qq
	sudo apt-get install -y \
            mysql-server \
            libmysqlclient-dev \
            python-virtualenv \
            python-dev \
            libjpeg-dev \
            python-mysqldb

	mysql -p --user root -e "CREATE DATABASE calaccess_raw; \
	    GRANT ALL ON calaccess_raw.* TO '$(USER)'@'localhost';"

	virtualenv . 
	
	source bin/activate \
	    && pip install numpy>=1.9.2 \ # numpy has to be installed before other pip dependencies
	    && pip install -r requirements.txt

	source bin/activate \
	    && python manage.py migrate \
	    && python manage.py downloadcalaccessrawdata

	mysql < donors.sql

grant:
	mysql -p --user root -e "CREATE DATABASE calaccess_raw; \
	    GRANT ALL ON calaccess_raw.* TO '$(USER)'@'localhost';"

