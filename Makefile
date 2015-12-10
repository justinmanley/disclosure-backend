.PHONY: build run test setup

build:
	python manage.py collectstatic --noinput

run:
	python manage.py runserver

test:
	python manage.py test

setup:
	sudo apt-get install mysql
	sudo apt-get install python-virtualenv

	mysql -p --user root -e "CREATE DATABASE calaccess_raw; \
	    GRANT ALL ON calacces_raw.* TO 'ec2-user'@'localhost';"

	virtualenv . && bin/activate
	pip install -r requirements.txt

	pip manage.py migrate
	pip manage.py downloadcalaccessrawdata

