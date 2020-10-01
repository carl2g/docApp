#!/bin/bash
if [[ ! -z $1 ]]
then
heroku pg:reset DATABASE_URL  --confirm "$1"
heroku run rake db:migrate --app "$1"
heroku run rake db:seed --app "$1"
heroku run rake migration:apply_updates --app "$1"
else
	echo "You need to specify app name"
fi