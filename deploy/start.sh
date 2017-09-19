#!/bin/bash

cd /sites/$SITENAME/
git pull origin master

/etc/init.d/postgresql start
sh /sites/$SITENAME/misc/cleanup.sh

/etc/init.d/nginx start -D

cd /sites/$SITENAME/source/
touch /tmp/gunicorn.access.log
touch /tmp/gunicorn.error.log
gunicorn --bind unix:/tmp/$SITENAME.socket config.wsgi:application --access-logfile /tmp/gunicorn.access.log --error-logfile /tmp/gunicorn.error.log -D
